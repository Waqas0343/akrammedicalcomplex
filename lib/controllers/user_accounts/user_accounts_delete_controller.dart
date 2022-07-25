import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/routes/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Server/api_fetch.dart';
import '../../Styles/Keys.dart';
import '../../Widgets/loading_spinner.dart';
import '../../services/preferences.dart';

class DeleteUserAccountsController extends GetxController {

  Future<bool> deleteRecord() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString(Keys.username);
    String? phone = preferences.getString(Keys.phone);
    String values = "&Username=$username&Phone=$phone";
    Get.dialog(const LoadingSpinner());
    bool response = await ApiFetch.deleteAccounts(values);
    Get.back();
    if (response) {
      Utilities.showToast("Your Accounts Delete Successfully");
      Get.find<Preferences>().clear();
      Get.offAllNamed(AppRoutes.login);





    }
    return response;
  }
}
