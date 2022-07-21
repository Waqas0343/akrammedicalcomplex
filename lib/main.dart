import 'package:amc/Styles/MyColors.dart';
import 'package:amc/firebase_options.dart';
import 'package:amc/routes/pages.dart';
import 'package:amc/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    title: 'amc',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: MyColors.primary,
      primaryColorLight: MyColors.primaryLight,
      primaryColorDark: MyColors.primaryDark,
      fontFamily: "Regular",
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
      inputDecorationTheme: const InputDecorationTheme(
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
    getPages: AppPages.pages,
    initialRoute: AppRoutes.splash,
  ));
}

