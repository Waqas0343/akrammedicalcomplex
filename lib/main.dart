import 'package:amc/Screens/Signup.dart';
import 'package:amc/Splash.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/Login.dart';
import 'Screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

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
        fontFamily: "Regular",
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          toolbarTextStyle: const TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "SemiBold",
            ),
          ).bodyText2,
          titleTextStyle: const TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "SemiBold",
            ),
          ).headline6,
        ),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey.shade300,
          labelColor: Colors.white,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: MyColors.primary,
        ),
        primaryIconTheme: const IconThemeData(
          color: MyColors.icons,
        ),
        dividerColor: MyColors.divider,
        buttonTheme: const ButtonThemeData(
          buttonColor: MyColors.primary,
          padding: EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontFamily: "Light",
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: MyColors.primary,
        ),
        colorScheme: const ColorScheme.light(
          primary: MyColors.primary,
        ).copyWith(
          secondary: MyColors.accent,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const Login(),
        '/home': (BuildContext context) => const Home(),
        '/signup': (BuildContext context) => const SignUp(),
      },
      home: const Splash(),
    );
  }
}
