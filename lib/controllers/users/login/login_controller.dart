import 'package:amc/Utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Server/api_fetch.dart';
import '../../../Widgets/loading_spinner.dart';
import '../../../models/otp_model.dart';
import '../../../routes/routes.dart';

class LoginController extends GetxController {
  String? phone;
  final formKey = GlobalKey<FormState>();


  Future login() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable();
      return;
    }
    Get.dialog(const LoadingSpinner());
    OTPResponse? user = await ApiFetch.loginWithPhone("&phone=$phone");
    Get.back();
    if (user == null || user.otpCode == 0) {
      Get.defaultDialog(
        title: 'User does not exist on this number.',
        middleText: 'Do you want to create new account',
        textCancel: 'No',
        textConfirm: 'Yes',
        onConfirm: () {
          Get.back();
          Get.toNamed(AppRoutes.signUp);
        },
      );
      return;
    }
    Get.offAllNamed(AppRoutes.accountActivation,
        arguments: {'Response': user, "isLogin": true});
  }

}
