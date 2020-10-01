import 'package:amc/Screens/Home.dart';
import 'package:amc/Screens/Signup.dart';
import 'package:amc/Splash.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/Login.dart';
import 'Utilities/Utilities.dart';



Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];

    String title = notification["title"];
    String body = notification["body"];
    Utilities.saveNotification(title, body);

  }
  return null;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'amc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyColors.primary,
        primaryColorLight: MyColors.primary_light,
        primaryColorDark: MyColors.primary_dark,
        accentColor: MyColors.accent,
        fontFamily: "Regular",
        colorScheme: ColorScheme.light(primary: MyColors.primary),
        cursorColor: MyColors.primary,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: false,
          brightness: Brightness.dark,
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "SemiBold"))
        ),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey.shade300,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontWeight: FontWeight.bold)
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: MyColors.primary
        ),
        primaryIconTheme: IconThemeData(color: MyColors.icons),
        dividerColor: MyColors.divider,
        buttonTheme: ButtonThemeData(
          buttonColor: MyColors.primary,

          padding: const EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
        ),
        textTheme: TextTheme(headline1: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontFamily: "Light"),
          fillColor: Colors.white,
          filled: true
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/home': (BuildContext context) => new Home(),
        '/signup': (BuildContext context) => new SignUp(),
      },
      home: Splash(),
    );
  }
}
