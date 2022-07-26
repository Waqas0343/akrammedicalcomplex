import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/models/city_model.dart';
import 'package:amc/models/profile_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class LocationGettingScreen extends StatefulWidget {
  final bool isAlreadyExists;

  const LocationGettingScreen(this.isAlreadyExists, {Key? key})
      : super(key: key);

  @override
  _LocationGettingScreenState createState() => _LocationGettingScreenState();
}

class _LocationGettingScreenState extends State<LocationGettingScreen> {
  final cityController = TextEditingController();
  final locationController = TextEditingController();
  final areaController = TextEditingController();

  final FocusNode areaFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  Profile? profile;
  bool isAreaEmpty = false, isLocationEmpty = false, isCityEmpty = false;
  late SharedPreferences preferences;
  late List<String> cities = [];
  bool isLoading = true;

  bool isTaped = true;
  String buttonText = "Save";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          MyImages.logo,
          height: 50,
        ),
        actions: [
          TextButton(
            onPressed: () => move(),
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: ListView(
          children: [
            const Text(
              "Where do you live?",
              style: TextStyle(
                height: 1.5,
                fontWeight: FontWeight.bold,
                color: MyColors.primary,
                fontSize: 28.0,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: cityController,
              focusNode: cityFocus,
              onFieldSubmitted: (text) {
                cityFocus.unfocus();
                FocusScope.of(context).requestFocus(addressFocus);
              },
              decoration: InputDecoration(
                filled: false,
                hintText: "Select City",
                errorText: isCityEmpty ? "Can't be empty" : null,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: areaController,
              focusNode: areaFocus,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              onSubmitted: (text) {
                areaFocus.unfocus();
                FocusScope.of(context).requestFocus(cityFocus);
              },
              onChanged: (text) {
                if (text.isNotEmpty) {
                  setState(() {
                    isAreaEmpty = false;
                  });
                }
              },
              decoration: InputDecoration(
                  hintText: "Area",
                  filled: false,
                  errorText: isAreaEmpty ? "Can't be Empty" : null),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: locationController,
              focusNode: addressFocus,
              minLines: 4,
              maxLines: 7,
              decoration: InputDecoration(
                  hintText: "Full Address",
                  filled: false,
                  errorText: isLocationEmpty ? "Can't be Empty" : null),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  setState(() {
                    isLocationEmpty = false;
                  });
                }
              },
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: isTaped ? () => updateInfo() : null,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCities();
    isAlreadyExists ? usersLocation() : isLoading = false;
  }

  bool get isAlreadyExists => widget.isAlreadyExists;

  void usersLocation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String username = preferences.getString(Keys.username);
    String? area = preferences.getString(Keys.area);
    String? city = preferences.getString(Keys.city);
    String? address = preferences.getString(Keys.address);
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable();
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (area != null) {
      setState(() {
        areaController.text = area;
      });
    }
    if (city != null) {
      setState(() {
        cityController.text = city;
      });
    }
    if (address != null) {
      setState(() {
        locationController.text = address;
      });
    }
  }

  void getCities() async {
    preferences = await SharedPreferences.getInstance();
    String response = await Utilities.httpGet(ServerConfig.cities);
    if (response != "404") {
      var list = citiesFromJson(response)
          .citiesList
          ?.cities
          ?.map((e) => e.name!)
          .toList();

      if (list != null) {
        if (!mounted) return;
        setState(() {
          cities.addAll(list);
        });
      }
    } else {
      Utilities.showToast("Unable to get Cities");
    }
  }

  void updateInfo() async {
    disableButton();
    preferences = await SharedPreferences.getInstance();
    String? phone = preferences.getString(Keys.phone);
    String? username = preferences.getString(Keys.username);
    String? name = preferences.getString(Keys.name);
    String? email, image, title;
    if (isAlreadyExists) {
      email = preferences.getString(Keys.email);
      image = preferences.getString(Keys.image);
      title = preferences.getString(Keys.title);
    }

    String area = areaController.text.trim();
    String city = cityController.text.trim();
    String location = locationController.text.trim();

    areaFocus.unfocus();
    cityFocus.unfocus();
    addressFocus.unfocus();

    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable();
      return;
    }

    if (area.isEmpty) {
      enableButton();
      setState(() {
        isAreaEmpty = true;
      });
      return;
    }

    if (city.isEmpty) {
      enableButton();
      setState(() {
        isCityEmpty = true;
      });
      return;
    }

    if (location.isEmpty) {
      enableButton();
      setState(() {
        isLocationEmpty = true;
      });
      return;
    }

    String values =
        "&Username=$username&Title=${title ?? ""}&Name=$name&Phone=$phone"
        "&Email=${email ?? ""}&City=$city&Area=$area&Location=$location&ImagePath=${image ?? ""}";

    Loading.build(context, false);

    String response =
        await Utilities.httpGet(ServerConfig.patientInfoUpdate + values);
    Loading.dismiss();
    if (response != "404") {
      preferences.setString(Keys.city, city);
      preferences.setString(Keys.area, area);
      preferences.setString(Keys.address, location);
      if (isAlreadyExists) Utilities.showToast("Update successfully");
      move();
    } else {
      Utilities.showToast("Unable to update location");
    }
    enableButton();
  }

  void move() {
    Route newRoute = MaterialPageRoute(builder: (_) => const Home());
    Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
  }

  void disableButton() {
    setState(() {
      isTaped = false;
    });
  }

  void enableButton() {
    setState(() {
      isTaped = true;
    });
  }
}
