import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Server/ServerConfig.dart';
import '../../../Styles/Keys.dart';
import '../../../Utilities/Utilities.dart';
import '../../../Widgets/loading_dialog.dart';
import '../../../Widgets/loading_spinner.dart';
import '../../../models/login_model.dart';
import '../../../routes/routes.dart';

class SignUpController extends GetxController {
  String? name, phone, email;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String buttonText = "Create Account";
  final RxBool buttonAction = RxBool(true);
  bool isTaped = true;

  Future<void> registerPatient() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    buttonAction(false);
    name = nameController.text.toString().trim();
    phone = phoneController.text.toString().trim();
    email = emailController.text.toString().trim();
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable;
      enableButton();
      return;
    }
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable;
      return;
    }
    Get.dialog(const LoadingSpinner());
    String values = "&Type=Patient&Name=$name&Phone=$phone&Email=$email";
    String response = await Utilities.httpPost(ServerConfig.signUp + values);
    if (kDebugMode) {
      print(response);
    }
    Loading.dismiss();
    if (response != "404") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User user = loginFromJson(response).response!.user!;
      preferences.setString(Keys.phone, user.phone!);
      preferences.setString(Keys.otp, user.otpCode.toString());
      preferences.setString(Keys.email, user.email!);
      preferences.setString(Keys.name, user.name!);

      Get.toNamed(AppRoutes.accountActivation,
          arguments: { "isLogin": false, "userPhone": user.phone, "userOTP": user.otpCode.toString()});
    } else {
      Utilities.showToast("Unable to create account, try again later.");
    }
    enableButton();
  }

  void disableButton() {
    isTaped = false;
  }

  void enableButton() {
    isTaped = true;
  }
}
