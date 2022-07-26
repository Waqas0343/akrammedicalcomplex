import 'package:amc/Screens/Settings/NewProfileSettings.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/models/profile_model.dart';
import 'package:amc/placeholder/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Profile? profile;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Image.asset(
          MyImages.logo,
          height: 50,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: profile != null
              ? ProfileSettings(
                  profile: profile!,
                )
              : isLoading
                  ? const ProfileShimmer()
                  : const Center(
                      child: Text("Profile Not found"),
                    ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  void getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString(Keys.username);
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable();
      setState(() {
        isLoading = false;
      });
      return;
    }

    String response = await Utilities.httpGet(
        ServerConfig.getPatientInfo + "&username=$username");
    isLoading = false;

    if (response != "404") {
      setState(() {
        profile = profileModelFromJson(response).response!.response;
      });
    } else {
      Utilities.showToast("Unable to get Profile Setting try again later");
    }
  }
}
