import 'package:amc/Models/CitiesModel.dart';
import 'package:amc/Models/ProfileModel.dart';
import 'package:amc/Screens/Settings/NewProfileSettings.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'AccountSettings.dart';
// import 'ProfileSettings.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Profile profile;
  List<String> cities;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Image.asset(
          MyImages.logo,
          height: 40,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: profile != null
              ? ProfileSettings(
                  profile: profile,
                  cities: cities,
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );

    //   DefaultTabController
    //     (
    //   length: 2,
    //   child: Scaffold(
    //     body: NestedScrollView(
    //         body: TabBarView(children: <Widget>[
    //           isLoading
    //               ? Column(mainAxisAlignment: MainAxisAlignment.center,children: [CircularProgressIndicator()],)
    //               : ProfileSettings(cities: cities,profile: profile,),
    //           AccountSettings()
    //         ]),
    //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //           return <Widget>[
    //             SliverAppBar(
    //               pinned: true,
    //               floating: true,
    //               title: Text("Settings"),
    //               bottom: TabBar(
    //                 indicatorColor: Colors.white,
    //                   isScrollable: false,
    //                   tabs: <Tab>[
    //                 new Tab(text: "Profile",),
    //                 new Tab(text: "Account",),
    //               ]),
    //             )
    //           ];
    //       },
    //     ),
    //   ),
    // );
  }

  @override
  void initState() {
    super.initState();
    cities = [];
    getInfo();
  }

  void getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.username);
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable(context);
      setState(() {
        isLoading = false;
      });
      return;
    }

    String citiesResponse = await Utilities.httpGet(ServerConfig.cities);

    String response = await Utilities.httpGet(
        ServerConfig.getPatientInfo + "&username=$username");

    if (citiesResponse != "404") {
      if (!mounted) return;
      citiesFromJson(citiesResponse).citiesList.cities.forEach((city) {
        setState(() {
          cities.add(city.name);
        });
      });
    } else {
      Utilities.showToast("Unable to get Cities");
    }

    if (response != "404") {
      setState(() {
        profile = profileModelFromJson(response).response.response;
        isLoading = false;
      });
    } else {
      Utilities.showToast("Unable to get Profile Setting try again later");
    }
  }
}
