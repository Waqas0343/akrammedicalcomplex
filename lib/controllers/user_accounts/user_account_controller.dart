import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Server/api_fetch.dart';
import '../../Styles/Keys.dart';
import '../../Widgets/crypto_helper.dart';
import '../../Widgets/loading_spinner.dart';
import '../../models/login_model.dart';
import '../../models/otp_model.dart';
import '../../Screens/home.dart';

class UserAccountsController extends GetxController {
  RxList<UserShortModel> accounts = RxList<UserShortModel>();
  final RxString phone = RxString(''), email = RxString('');

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      accounts.assignAll(Get.arguments);
    }
  }

  Future login(UserShortModel userList) async {
    Get.dialog(const LoadingSpinner());
    String password = CryptoHelper.decryption(userList.password!); // loading spinner
    String values = '&Username=${userList.username}&Password=$password'; // query params
    User? user = await ApiFetch.login(values); // http request
    Get.back(); // loading spinner close
    setPreferences(user!);
    Get.offAll(()=> const Home());
  }
  Future<void> setPreferences(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Keys.username,  user.username??'');
    sharedPreferences.setString(Keys.name, user.name??'');
    sharedPreferences.setString(Keys.phone,user.phone??'');
    sharedPreferences.setString(Keys.image, user.imagePath??'');
    sharedPreferences.setString(Keys.email, user.email??'');
    sharedPreferences.setString(Keys.sessionToken,user.sessionToken??'');
    sharedPreferences.setString(Keys.address, user.huAddress!.location??'');
    sharedPreferences.setString(Keys.city, user.huAddress!.city??'');
    sharedPreferences.setString(Keys.area, user.huAddress!.area??'');
  }
  void getPreferences() async {
    phone(Get.find<SharedPreferences>().getString(Keys.username));
  }

}
