import 'package:amc/Screens/Signup.dart';
import 'package:amc/Screens/account_creation/ActivationCode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Server/api_fetch.dart';
import '../Widgets/loading_dialog.dart';
import '../Widgets/loading_spinner.dart';
import '../models/otp_model.dart';
class LoginController extends GetxController {

  String? loginID, password;
  final bool isLogin = false;
  final usernameFocus = FocusNode();
  bool isTaped = true;
  final RxBool buttonAction = RxBool(true);
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void login() async {
    Get.dialog(const LoadingSpinner());
    String values = phoneController.text.trim().replaceAll(" ", "");
    OTPResponse? user = await ApiFetch.loginWithPhone("&phone=$values");
    Loading.dismiss();
    if (user == null || user.otpCode == 0) {
      Get.defaultDialog(
          title: 'User does not exist on this number.',
          middleText: 'Do you want to create new account',
          textCancel: 'No',
          textConfirm: 'Yes',
          onConfirm: () {
            Get.back();
            Get.to(()=> const SignUp());
          }
      );
      return;
    }
    Get.to(()=> AccountActivation(values, null, userList: user,isLogin:true));

  }
  void disableButton() {
      isTaped = false;
  }
  void enableButton() {
      isTaped = true;
  }
}
