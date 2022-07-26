import 'dart:async';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/routes/routes.dart';
import 'package:amc/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Styles/Keys.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(flex: 1, child: SizedBox.shrink()),
            Expanded(
                flex: 1,
                child: Image.asset(
                  MyImages.logo,
                )),
            Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 36.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Smart Hospital App by ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Image.asset(
                        MyImages.instaLogoBlue,
                        height: 36.0,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() async {
    bool status = Get.find<Preferences>().getBool(Keys.status) ?? false;
    if (status) {
      Get.offNamed(AppRoutes.home);
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }

  startTime() async {
    var _duration = const Duration(seconds: 1);
    return Timer(_duration, navigationPage);
  }
}
