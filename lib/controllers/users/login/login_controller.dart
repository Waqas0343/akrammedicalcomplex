import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Server/api_fetch.dart';
import '../../../Widgets/loading_dialog.dart';
import '../../../Widgets/loading_spinner.dart';
import '../../../models/otp_model.dart';
import '../../../routes/routes.dart';
class LoginController extends GetxController {
  String? loginID;
  final bool isLogin = false;
  bool isTaped = true;
  final formKey = GlobalKey<FormState>();
  final RxBool buttonAction = RxBool(true);
  final phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();




  void login() async {

    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    buttonAction(false);
    Get.dialog(const LoadingSpinner());
    loginID = phoneController.text.trim().replaceAll(" ", "");
    OTPResponse? user = await ApiFetch.loginWithPhone("&phone=$loginID");
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
          }
      );
      return;
    }
    Get.offAllNamed(AppRoutes.accountActivation,
        arguments: {'Response': user, "isLogin": true});
  }
}
