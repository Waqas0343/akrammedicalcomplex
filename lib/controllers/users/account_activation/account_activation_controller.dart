import 'dart:async';
import 'dart:convert';
import 'package:amc/Server/api_fetch.dart';
import 'package:amc/services/preferences.dart';
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
  final RxInt start = RxInt(60);
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
    Get.find<Preferences>().getString(Keys.username);
    startTimer();
    errorController = StreamController<ErrorAnimationType>();
    isLogin = Get.arguments['isLogin'];
    if (isLogin) {
      _otpResponse = Get.arguments['Response'];
      userPhoneNo = _otpResponse!.userList!.first.phone ?? " ";
      try {
        _phone(_otpResponse!.userList!.first.phone);
      } catch (_) {}
    } else {
      userPhoneNo = Get.arguments['userPhone'];
      otp = Get.arguments['userOTP'];
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

  Future reSend() async {
    if (_timer.isActive) {
      return;
    }

    _timer.cancel();
    startTimer();
    start.value = 60;

    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable;
      return;
    }

    bool result = await ApiFetch.resendCode(userPhoneNo);
    if (!result) {
      Utilities.showToast("Unable to send");
    }
  }

  void verify(String code) {
    if (isLogin) {
      Get.to(
        () => UserAccounts(list: _otpResponse),
      );
    } else {
      Get.to(() => const LocationGettingScreen(false));
    }
  }

  int get countDown => start.value;

  String get phone => _phone.value;

  bool get isActive => _isActive.value;
}
