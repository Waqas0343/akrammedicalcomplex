import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Server/api_fetch.dart';
import '../../../Styles/Keys.dart';
import '../../../Widgets/loading_dialog.dart';
import '../../../Widgets/loading_spinner.dart';
import '../../../models/login_model.dart';
import '../../../models/otp_model.dart';
import '../../../routes/routes.dart';
import '../../../services/preferences.dart';

class LoginController extends GetxController {
  String? phone;
  final formKey = GlobalKey<FormState>();

  Future login() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    Get.dialog(const LoadingSpinner());
    Get.find<Preferences>().setBool(Keys.status, true);
    OTPResponse? user = await ApiFetch.loginWithPhone("&phone=$phone");
    Loading.dismiss();
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
    Get.offAllNamed(
      AppRoutes.accountActivation,
      arguments: {
        'Response': user,
        "isLogin": true,
      },
    );
  }
}
