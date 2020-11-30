import 'dart:io';

import 'package:amc/Database/Database.dart';
import 'package:amc/Models/NotificationModel.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';


class Utilities{

  static DatabaseManager dbManager = DatabaseManager();

  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 6),onTimeout: (){
        return List<InternetAddress>();
      });
      print('connection checking...');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }

    } on SocketException catch (_) {
      print('not connected');
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

    Response response = await post(url);
    int statusCode = response.statusCode;
    if (statusCode == 200){
      return response.body;
    } else {
      return "404";
    }
  }

  static Future<String> httpGet(String url) async {
    Response response = await get(url);
    int statusCode = response.statusCode;
    if (statusCode == 200){
      return response.body;
    } else {
      return "404";
    }
  }

  static Widget emptyScreen(){
    return Align(
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
                Icon(Icons.wifi_off,size: 60,),
                SizedBox(height: 16,),
                Text('No Internet Connection', style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),
                Text('Internet access is required \nto use this feature.', textAlign: TextAlign.center,),
                SizedBox(height: 16,),
                Container(
                  width: 120,
                  child: OutlinedButton(onPressed: (){
                    Navigator.pop(context);

                  }, child: Text("Cancel")),
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
    RegExp regExp = new RegExp(pattern);
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
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static Future<void> saveNotification(String title, String body) async {

    NotificationModel notificationModel = NotificationModel(title: title, description: body);

    int id = await dbManager.insert(Keys.notification, notificationModel);
    if (id == 0){
      print("Unable to add notification in local database");
    }


  }
}