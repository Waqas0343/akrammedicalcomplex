import 'dart:async';

import 'package:amc/Screens/Home.dart';
import 'package:amc/Styles/Strings.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ThankYouScreen extends StatefulWidget {
  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  bool isPaused = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Future<bool>.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                child: FlareActor(
                  "assets/animation/success.flr", alignment: Alignment.center,
                  animation: 'Untitled',
                  snapToEnd: true,
                  isPaused: isPaused,
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(Strings.Congrats_title,textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 22, height: 1.5),),
                    SizedBox(height: 16,),
                    Text(Strings.Congrats_Description,textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.grey, height: 1.5),)
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Route newRoute = new MaterialPageRoute(builder: (_)=> Home());
    Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    startTime();
    Future.delayed(Duration(seconds: 4),(){
      isPaused = true;
      setState(() {});
    });
  }
}