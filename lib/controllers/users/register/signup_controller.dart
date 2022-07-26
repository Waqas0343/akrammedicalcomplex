import 'package:amc/app/debug.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../Server/ServerConfig.dart';
import '../../../Styles/Keys.dart';
import '../../../Utilities/Utilities.dart';
import '../../../Widgets/loading_dialog.dart';
import '../../../Widgets/loading_spinner.dart';
import '../../../models/login_model.dart';
import '../../../routes/routes.dart';
import '../../../services/preferences.dart';

class SignUpController extends GetxController {
  String? name, phone, email;
  final formKey = GlobalKey<FormState>();

  Future<void> registerPatient() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable;
      return;
    }
    Get.dialog(const LoadingSpinner());
    String values = "&Type=Patient&Name=$name&Phone=$phone&Email=$email";
    String response = await Utilities.httpPost(ServerConfig.signUp + values);
    Debug.log(response);
    Loading.dismiss();
    if (response != "404") {
      User user = loginFromJson(response).response!.user!;
      Get.find<Preferences>().setString(Keys.username, user.username);
      Get.find<Preferences>().setString(Keys.name, user.name);
      Get.find<Preferences>().setString(Keys.phone, user.phone);
      Get.find<Preferences>().setString(Keys.image, user.imagePath);
      Get.find<Preferences>().setString(Keys.email, user.email);
      Get.find<Preferences>().setString(Keys.mrNo, user.mrNo);
      Get.find<Preferences>().setString(Keys.sessionToken, user.sessionToken);
      Get.find<Preferences>().setString(Keys.address, user.huAddress!.location);
      Get.find<Preferences>().setString(Keys.city, user.huAddress!.city);
      Get.find<Preferences>().setString(Keys.area, user.huAddress!.area);

      Get.toNamed(
        AppRoutes.accountActivation,
        arguments: {
          "isLogin": false,
          "user": user,
        },
      );
    } else {
      Utilities.showToast("Unable to create account, try again later.");
    }
  }

}
