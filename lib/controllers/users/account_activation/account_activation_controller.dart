import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Screens/account_creation/LocationGettingScreen.dart';
import '../../../Screens/accounts/user_accounts.dart';
import '../../../Server/ServerConfig.dart';
import '../../../Styles/Keys.dart';
import '../../../Utilities/Utilities.dart';
import '../../../Widgets/loading_dialog.dart';
import '../../../Widgets/loading_spinner.dart';
import '../../../models/otp_model.dart';

class AccountActivationController extends GetxController {
  final RxString _phone = RxString('');
  OTPResponse? _otpResponse;
  late Timer _timer;
  RxInt start = 60.obs;
  final RxBool _isActive = RxBool(true);
  bool hasError = false;
  String currentText = "";
  String userPhoneNo = " ";
  String otp = " ";
  bool isLogin = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  late SharedPreferences preferences;
  String? username;
  bool isTaped = true;
  String buttonText = "Verify";
  StreamController<ErrorAnimationType>? errorController;

  @override
  void onInit() {
    getPreferences();
    startTimer();
    errorController = StreamController<ErrorAnimationType>();
    isLogin = Get.arguments['isLogin'];
    if (isLogin) {
      _otpResponse = Get.arguments['Response'];
      userPhoneNo = _otpResponse!.userList!.first.phone ?? " ";
      try {
        _phone(_otpResponse!.userList!.first.phone);
      } catch (_) {}
     } else{
         userPhoneNo =  Get.arguments['userPhone'];
         otp =Get.arguments['userOTP'];
    }
    super.onInit();
  }

  @override
  void dispose() {
    errorController!.close();
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (countDown < 1) {
          _isActive(false);
          timer.cancel();
        } else {
          _isActive(true);
          start(countDown - 1);
        }
      },
    );
  }

  void reSend() async {
    if (otp == currentText) {
      Get.to(() => const LocationGettingScreen(false));
    }
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable;
      return;
    }
    if (_timer.isActive) {
      return;
    } else {
      _timer.cancel();
      startTimer();
      start = 60.obs;
    }

    String response = await Utilities.httpPost(
        ServerConfig.resendCode + '&phone=$userPhoneNo');
    if (response != "404") {
      if (jsonDecode(response)["Response"]["Response"] == "Success") {
        enableButton();
        if (kDebugMode) {
          print("Pin code has been sent");
        }
      }
    } else {
      Utilities.showToast("Unable to send");
    }
    enableButton();
  }

  void verify(String code) async {
    disableButton();
    if (isLogin == true) {
      Get.dialog(const LoadingSpinner());
      Get.to(
        () => UserAccounts(list: _otpResponse),
      );
    } else if (isLogin == false) {
      Get.to(() => const LocationGettingScreen(false));
    }
    disableButton();
    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable;
      return;
    }
    Loading.dismiss();
    enableButton();
  }

  void getPreferences() async {
    preferences = await SharedPreferences.getInstance();
    username = preferences.getString(Keys.USERNAME);
  }

  void disableButton() {
    isTaped = false;
  }

  void enableButton() {
    isTaped = true;
  }

  int get countDown => start.value;

  String get phone => _phone.value;

  bool get isActive => _isActive.value;
}
