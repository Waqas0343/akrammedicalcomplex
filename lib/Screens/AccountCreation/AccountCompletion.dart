import 'package:amc/Screens/Home.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Privacy/PrivacyPolicy.dart';

class AccountCompletion extends StatefulWidget {
  @override
  _AccountCompletionState createState() => _AccountCompletionState();
}

class _AccountCompletionState extends State<AccountCompletion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(MyImages.logo, height: 40,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to Instacare",style: TextStyle(height: 1.5,fontWeight: FontWeight.bold, color: MyColors.primary, fontSize: 28.0)),

            SizedBox(
              height: 16,
            ),
            RichText(
                textAlign: TextAlign.start,
                text: TextSpan(text: "Read our ",
                  style: TextStyle(height:1.5,color: MyColors.primary, fontSize: 18.0),
                  children: [
                    TextSpan(text: "Privacy Policy.",
                        style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.primary, fontSize: 18.0, decoration: TextDecoration.underline, height: 1.5),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Route newRoute = new MaterialPageRoute(builder: (_)=>PrivacyPolicy());
                          Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
                        }
                    ),
                    TextSpan(text: " Tap on Get Started to accept the Terms of Service.",
                        style: TextStyle(color: MyColors.primary, fontSize: 18.0)
                    ),
                  ],
                )
            ),
            SizedBox(
              height: 24,
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () {
                  Route newRoute = new MaterialPageRoute(builder: (_)=>Home());
                  Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                padding: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: MyColors.primary,
                textColor: Colors.white,
              ),
            ),
          ],),
      ),
    );
  }
}
