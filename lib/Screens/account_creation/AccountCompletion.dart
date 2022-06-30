import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Privacy/PrivacyPolicy.dart';
import '../home.dart';

class AccountCompletion extends StatefulWidget {
  const AccountCompletion({Key? key}) : super(key: key);

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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(MyImages.logo, height: 50,), systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Update to Instacare",style: TextStyle(height: 1.5,fontWeight: FontWeight.bold, color: MyColors.primary, fontSize: 28.0)),

            const SizedBox(
              height: 16,
            ),
            RichText(
                textAlign: TextAlign.start,
                text: TextSpan(text: "Read our ",
                  style: const TextStyle(height:1.5,color: MyColors.primary, fontSize: 18.0),
                  children: [
                    TextSpan(text: "Privacy Policy.",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: MyColors.primary, fontSize: 18.0, decoration: TextDecoration.underline, height: 1.5),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Route newRoute = MaterialPageRoute(builder: (_)=>PrivacyPolicy());
                          Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
                        }
                    ),
                    const TextSpan(text: " Tap on Get Started to accept the Terms of Service.",
                        style: TextStyle(color: MyColors.primary, fontSize: 18.0)
                    ),
                  ],
                )
            ),
            const SizedBox(
              height: 24,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Route newRoute = MaterialPageRoute(builder: (_)=>Home());
                  Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],),
      ),
    );
  }
}
