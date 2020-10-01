import 'dart:async';

import 'package:amc/Styles/MyImages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Styles/Keys.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 1, child: SizedBox.shrink()),
            Expanded(flex: 1, child: Image.asset(MyImages.AMCLogo,)),
            Expanded(flex: 1, child: Container(
              margin: const EdgeInsets.only(bottom: 36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Smart Hospital App by ", style: TextStyle(fontSize: 16.0),),
                  Image.asset(MyImages.instaLogoBlue, height: 36.0,),
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

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool status = prefs.getBool(Keys.status) ?? false;

    if (status) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }

  }


  startTime() async {
    var _duration = new Duration(seconds: 7);
    return new Timer(_duration, navigationPage);
  }
}
