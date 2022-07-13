import 'package:amc/models/profile_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/models/city_model.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class LocationGettingScreen extends StatefulWidget {
  final bool isAlreadyExists;

  const LocationGettingScreen(this.isAlreadyExists, {Key? key}) : super(key: key);


  @override
  _LocationGettingScreenState createState() =>
      _LocationGettingScreenState(isAlreadyExists);
}

class _LocationGettingScreenState extends State<LocationGettingScreen> {
  final cityController = TextEditingController();
  final locationController = TextEditingController();
  final areaController = TextEditingController();
  final bool isAlreadyExists;

  final FocusNode areaFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  Profile? profile;
  bool isAreaEmpty = false, isLocationEmpty = false, isCityEmpty = false;
  late SharedPreferences preferences;
  late List<String?> cities;
  bool isLoading = true;

  _LocationGettingScreenState(this.isAlreadyExists);

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
        ], systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: ListView(
          children: [
            const Text("Where do you live?",
                style: TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primary,
                    fontSize: 28.0)),
            const SizedBox(
              height: 16,
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
            TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: cityController,
                    focusNode: cityFocus,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      cityFocus.unfocus();
                      FocusScope.of(context).requestFocus(addressFocus);
                    },
                    decoration: InputDecoration(
                        filled: false,
                        hintText: "Select City",
                        errorText: isCityEmpty ? "Can't be empty" : null)),
                noItemsFoundBuilder: (context) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("No City Found"),
                  );
                },
                suggestionsCallback: (name) {
                  var values = [];
                  for (var city in cities) {
                    if (city!.toLowerCase().contains(name.toLowerCase())) {
                      values.add(city);
                    }
                  }
                  return values;
                },
                itemBuilder: (context, dynamic suggestion) {
                  return ListTile(
                    dense: true,
                    title: AutoSizeText(
                      suggestion,
                      maxLines: 1,
                    ),
                  );
                },
                onSuggestionSelected: (dynamic suggestion) {
                  setState(() {
                    isCityEmpty = false;
                    cityController.text = suggestion;
                  });
                }),
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    cities = <String?>[];
    getCities();
    isAlreadyExists ? usersLocation() : isLoading = false;
  }

  void usersLocation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String username = preferences.getString(Keys.username);
    String? area = preferences.getString(Keys.area);
    String? city = preferences.getString(Keys.city);
    String? address = preferences.getString(Keys.address);
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable(context);
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (area!.isNotEmpty) {
      setState(() {
        areaController.text = area;
      });
    }
    if (city!.isNotEmpty) {
      setState(() {
        cityController.text = city;
      });
    }
    if (address!.isNotEmpty != null) {
      setState(() {
        locationController.text = address;
      });
    }

    // String response = await Utilities.httpGet(
    //     ServerConfig.getPatientInfo + "&username=$username");
    //
    // if (response != "404") {
    //   setState(() {
    //     profile = profileModelFromJson(response).response.response;
    //
    //     if (profile != null) {
    //       String area = profile.address.area ?? "";
    //       String city = profile.address.city ?? "";
    //       String address = profile.address.location ?? "";
    //       if (area.isNotEmpty) {
    //         areaController.text = area;
    //       }
    //       if (city.isNotEmpty) {
    //         cityController.text = city;
    //       }
    //       if (address.isNotEmpty != null) {
    //         locationController.text = address;
    //       }
    //     }
    //     isLoading = false;
    //   });
    // } else {
    //   Utilities.showToast("Unable to get Profile Setting try again later");
    // }
  }

  void getCities() async {
    preferences = await SharedPreferences.getInstance();
    String response = await Utilities.httpGet(ServerConfig.cities);
    if (response != "404") {
      if (!mounted) return;
      citiesFromJson(response).citiesList!.cities!.forEach((city) {
        setState(() {
          cities.add(city.name);
        });
      });
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
      Utilities.internetNotAvailable(context);
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
    if (cities.isNotEmpty) {
      if (!cities.contains(city)) {
        enableButton();
        Utilities.showToast("Select City from given list");
        return;
      }
    }
    if (location.isEmpty) {
      enableButton();
      setState(() {
        isLocationEmpty = true;
      });
      return;
    }

    String values = "&Username=" +
        username! +
        "&Title=${title ?? ""}" +
        "&Name=$name" +
//            "&CNIC=" +
        "&Phone=$phone" +
//            "&Profession=" +
        "&Email=${email ?? ""}" +
        "&City=" +
        city +
        "&Area=" +
        area +
        "&Location=" +
        location +
//            "&Weight=" +
//            "&Height="  +
//            "&dateofbirth=" +
        "&ImagePath=${image ?? ""}";
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
