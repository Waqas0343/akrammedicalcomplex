class Keys {
  static const String database = "amc.db";
  static const String USERNAME = "Username";

  static const String notification = "notification";
  static const String ID = "ID";
  static const String title = "title";
  static const String description = "description";
  static const String time = "time";
  static const String date = "date";
  static const String onlyNumbers = "field accepts only numbers";

  static const String status = "status";
  static const String username = "Username";
  static const String password = "Password";
  static const String isFirstTime = "FirstTime";
  static const String email = "Email";
  static const String phone = "Phone";
  static const String otp = "OTP";

  static const String area = "Area";
  static const String address = "Address";
  static const String city = "City";
  static const String name = "Name";
  static const String image = "Image";
  static const String flag = "Flag";
  static const String prescription = "prescription";
  static const String sessionToken = "SessionToken";

  static const String labId = "chughtailab20180507020024";

  static const String labReport = "labReport";
  static const String labOrders = "labOrder";
  static const String appointment = "appointment";
  static const String treatments = "treatment";
  static const String actionType = "actionType";
  static const String homeServices = "Home Services";
  static const String medicines = "medicine";
  static const String googleMessageId = "googleMessageId";

  // static const String locationId = "AC20180602102453";

  static const String locationId = "A20200710021733";

  static const String source = "AMC";
  static const String cryptoKey = "fMhBu#\$%be\$5ek!1ULXO6z*iB4Nv03E1";

  static const String projectId = "amc-healthcare-services";

  static const List<String> titleList = ['Mr', 'Ms', 'Miss', 'Mrs'];

  static const String appName = "AMC Patient App";

  static const String imageNotFound =
      "https://instacare.pk/assets/img/Image-not-found.jpg";

  static const notificationSchema =
      "CREATE TABLE $notification ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, "
      "$description TEXT, $date TEXT, $time TEXT)";
}
