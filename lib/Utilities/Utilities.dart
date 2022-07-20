import 'dart:io';
import 'package:amc/Database/database.dart';
import 'package:amc/models/notification_model.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class Utilities{

  static DatabaseManager dbManager = DatabaseManager();

  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 6),onTimeout: (){
        return <InternetAddress>[];
      });
      if (kDebugMode) {
        print('connection checking...');
      }

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (kDebugMode) {
          print('connected');
        }
        return true;
      }

    } on SocketException catch (_) {
      if (kDebugMode) {
        print('not connected');
      }
    }

    return false;
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black);
  }


  static Future<String> httpPost(String url) async {
    if (kDebugMode) {
      print(url);
    }
    Response response = await post(Uri.parse(url));
    int statusCode = response.statusCode;
    if (statusCode == 200){
      return response.body;
    } else {
      return "404";
    }
  }

  static Future<String> httpGet(String url) async {
    if (kDebugMode) {
      print(url);
    }
    Response response = await get(Uri.parse(url));
    int statusCode = response.statusCode;
    if (statusCode == 200){
      return response.body;
    } else {
      return "404";
    }
  }

  static Widget emptyScreen(){
    return const Align(
      alignment: Alignment.center,
      child: Text(
          'No Record Found'
      ),
    );
  }

  static Future<void> internetNotAvailable(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off,size: 60,),
                const SizedBox(height: 16,),
                const Text('No Internet Connection', style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 8,),
                const Text('Internet access is required \nto use this feature.', textAlign: TextAlign.center,),
                const SizedBox(height: 16,),
                SizedBox(
                  width: 120,
                  child: OutlinedButton(onPressed: (){
                    Navigator.pop(context);

                  }, child: const Text("Cancel")),
                )
              ],
            ),
          );
        });
  }

  static TextInputFormatter onlyNumberFormat(){
    return FilteringTextInputFormatter.allow(RegExp("[0-9]"));
  }

  static bool numberHasValid(String value) {
    String  pattern = r"^[0][3][0-5]\d{8}$";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static TextInputFormatter onlyTextFormat(){
    return FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"));
  }

  static TextInputFormatter bothFormat(){
    return FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"));
  }

  static bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static Future<void> saveNotification(String title, String body) async {

    NotificationModel notificationModel = NotificationModel(title: title, description: body);

    int id = await dbManager.insert(Keys.notification, notificationModel);
    if (id == 0){
      if (kDebugMode) {
        print("Unable to add notification in local database");
      }
    }


  }
}