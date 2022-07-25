import 'package:amc/Styles/Keys.dart';
import 'package:amc/services/preferences.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../app/debug.dart';
import '../models/login_model.dart' as login_user_model;
import '../models/otp_model.dart';
import 'ServerConfig.dart';

class ApiFetch {
  static Dio dio = Dio();

  static Future<OTPResponse?> loginWithPhone(String values) async {
    Response response;
    OTPResponse? otpResponse;
    try {
      Debug.log(ServerConfig.otp + values);
      response = await dio.post(ServerConfig.otp + values);
    } catch (e) {
      Debug.log(e);
      return otpResponse;
    }

    if (response.statusCode == 200) {
      Debug.log(response.data.toString());

      try {
        otpResponse =
            OTPResponse.fromJson(response.data['Response']['Response']);
      } catch (e) {
        Debug.log(e);
      }
    }
    return otpResponse;
  }

  static Future<login_user_model.User?> login(String values) async {
    // String? ipAddress = await IpAddress().getIpAddress();

    Response response;

    try {
      Debug.log(ServerConfig.login + values);
      response = await dio.get(ServerConfig.login + values);
    } catch (e) {
      Debug.log(e);
      return null;
    }

    try {
      Debug.log(response.data.toString());

      return login_user_model.User.fromJson(
          response.data["Response"]["Response"]);
    } catch (e) {
      Debug.log(e);
    }

    return null;
  }

  static Future<bool> deleteAccounts(String value) async {
    Response response;
    try {
      Debug.log(ServerConfig.deleteAccounts + value);
      response = await dio.post(
        ServerConfig.deleteAccounts + value,
      );
    } catch (e) {
      Debug.log(e);
      return false;
    }
    try {
      return response.data["Response"]['Response'];
    } catch (e) {
      Debug.log(e);
    }
    return false;
  }

  static Future<bool> resendCode(String phone) async {
    Response response;
    try {
      String url = ServerConfig.resendCode + '&phone=$phone';
      Debug.log(url);
      response = await dio.post(
        url,
      );
    } catch (e) {
      Debug.log(e);
      return false;
    }
    try {
      return response.data["Response"]['Response'] == "Success";
    } catch (e) {
      Debug.log(e);
    }
    return false;
  }

  static Future<void> saveFCMToken(String token) async {
    try {
      String? username = getx.Get.find<Preferences>().getString(Keys.username);
      String url = ServerConfig.saveToken + '&deviceType=Flutter&username=$username&token=$token';
      print(url);
      Debug.log(url);
      Response response = await dio.post(
        url,
      );
      Debug.log(response.data);
    } catch (e) {
      Debug.log(e);
    }
  }
}
