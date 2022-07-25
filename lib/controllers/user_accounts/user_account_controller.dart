import 'package:get/get.dart';
import '../../Server/api_fetch.dart';
import '../../Styles/Keys.dart';
import '../../Widgets/crypto_helper.dart';
import '../../Widgets/loading_spinner.dart';
import '../../models/login_model.dart';
import '../../models/otp_model.dart';
import '../../Screens/home.dart';
import '../../services/preferences.dart';

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
    Get.find<Preferences>().setString(Keys.phone, user.phone!);
    Get.find<Preferences>().setString(Keys.username,  user.username??'');
    Get.find<Preferences>().setString(Keys.name, user.name??'');
    Get.find<Preferences>().setString(Keys.image, user.imagePath??'');
    Get.find<Preferences>().setString(Keys.email, user.email??'');
    Get.find<Preferences>().setString(Keys.sessionToken,user.sessionToken??'');
    Get.find<Preferences>().setString(Keys.address, user.huAddress!.location??'');
    Get.find<Preferences>().setString(Keys.city, user.huAddress!.city??'');
    Get.find<Preferences>().setString(Keys.area, user.huAddress!.area??'');
  }
  void getPreferences() async {
    phone(Get.find<Preferences>().getString(Keys.username));
  }

}
