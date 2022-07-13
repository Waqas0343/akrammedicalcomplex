import 'dart:async';

import 'package:amc/Styles/Strings.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

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
              child: SizedBox(
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
                  children: const [
                    Text(Strings.congratsTitle,textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 22, height: 1.5),),
                    SizedBox(height: 16,),
                    Text(Strings.congratsDescription,textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.grey, height: 1.5),)
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
    var _duration = const Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Route newRoute = MaterialPageRoute(builder: (_)=> const Home());
    Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    startTime();
    Future.delayed(const Duration(seconds: 4),(){
      isPaused = true;
      setState(() {});
    });
  }
}