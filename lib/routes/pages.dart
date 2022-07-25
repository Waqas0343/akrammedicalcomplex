import 'package:get/get.dart';

import '../Screens/Bookings/BookTreatment.dart';
import '../Screens/Bookings/SelectTestType.dart';
import '../Screens/HealthRecords/MyHealthRecords.dart';
import '../Screens/MyBooking/MyBooking.dart';
import '../Screens/MyBooking/MyTreatments.dart';
import '../Screens/Orders/Medicines/MedicineOrderType.dart';
import '../Screens/Prescription/MyPrescriptions.dart';
import '../Screens/Settings/Settings.dart';
import '../Screens/account_creation/account_activation.dart';
import '../Screens/delete_user_account/delete_user_accounts.dart';
import '../Screens/home.dart';
import '../Screens/login.dart';
import '../Screens/signup.dart';
import '../Splash.dart';
import 'routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const Splash()),
    GetPage(name: AppRoutes.login, page: () => const Login()),
    GetPage(name: AppRoutes.signUp, page: () => const SignUp()),
    GetPage(name: AppRoutes.accountActivation, page: () => const AccountActivation()),
    GetPage(name: AppRoutes.home, page: () => const Home()),
    GetPage(name: AppRoutes.bookTreatment, page: () => const BookTreatment()),
    GetPage(name: AppRoutes.myTreatment, page: () => const MyTreatments()),
    GetPage(name: AppRoutes.labTestHome, page: () => const TestType()),
    GetPage(name: AppRoutes.medicineHome, page: () => const MedicineOrderType()),
    GetPage(name: AppRoutes.myBookings, page: () => const MyBooking()),
    GetPage(name: AppRoutes.myPrescriptions, page: () => const MyPrescriptions()),
    GetPage(name: AppRoutes.myHealthRecords, page: () => const MyHealthRecords()),
    GetPage(name: AppRoutes.settings, page: () => const Settings()),
    GetPage(name: AppRoutes.deleteAccounts, page: () => const DeleteUserAccounts()),
  ];
}
