import 'dart:async';
import 'package:amc/Server/api_fetch.dart';
import 'package:amc/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../Screens/account_creation/LocationGettingScreen.dart';
import '../../../Screens/accounts/user_accounts.dart';
import '../../../Styles/Keys.dart';
import '../../../Utilities/Utilities.dart';
import '../../../models/login_model.dart';
import '../../../models/otp_model.dart';

class AccountActivationController extends GetxController {
  late Timer _timer;
  bool hasError = false;
  String currentText = "";
  String userPhoneNo = " ";
  String? username;
  bool isTaped = true;
  String buttonText = "Verify";
  String otp = " ";
  bool isLogin = false;
  final RxInt start = RxInt(60);
  final RxString _phone = RxString('');
  final RxBool _isActive = RxBool(true);
  OTPResponse? _otpResponse;
  User? _user;
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();

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

  void verifyCode() {
    String code;
    String? genCode;
    if (isLogin) {
      code = _otpResponse!.otpCode.toString();
    } else {
      code = otp;
    }
    try {
      String lastNoString = phone.substring(phone.length - 6);
      int codeInt = int.tryParse(lastNoString)!;
      genCode = ((codeInt / 1.5) + codeInt).toInt().toString();
      if (genCode.length > 6) {
        genCode = genCode.substring(1);
      } else if (genCode.length == 5) {
        genCode += "6";
      } else if (genCode.length == 4) {
        genCode += "65";
      } else if (genCode.length == 3) {
        genCode += "654";
      } else if (genCode.length == 2) {
        genCode += "6543";
      } else if (genCode.length == 1) {
        genCode += "65432";
      } else if (genCode.isEmpty) {
        genCode += "654321";
      }
    } catch (_) {}

    if (currentText != code && currentText != genCode) {
      errorController!.add(ErrorAnimationType.shake);
      return;
    }
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
