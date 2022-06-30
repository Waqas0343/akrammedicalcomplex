import 'dart:math';

import 'package:amc/Screens/AppDrawer.dart';
import 'package:amc/Screens/HealthRecords/MyHealthRecords.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/Widgets/home_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bookings/BookTreatment.dart';
import 'Bookings/SelectTestType.dart';
import 'Doctors/FindDoctor.dart';
import 'LabReports/LabReports.dart';
import 'MyBooking/MyBooking.dart';
import 'MyBooking/MyTreatments.dart';
import 'Orders/Medicines/MedicineOrderType.dart';
import 'Prescription/MyPrescriptions.dart';
import 'Settings/Settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name, email, imagePath, oldId;
  late SharedPreferences preferences;
  DateTime? currentBackPressTime;

  var rng = Random();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: AppDrawer(
            name: name,
            imagePath: imagePath,
            email: email,
          ),
          body: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 50),
                color: MyColors.primary,
                child: Column(
                  children: [
                    AppBar(
                      elevation: 0,
                      title: const Text(Keys.appName),
                      actions: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 10)
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
                            child: NetWorkImage(
                              imagePath: imagePath,
                              placeHolder: MyImages.imageNotFound,
                              width: 40,
                              height: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 20.0, left: 16.0, right: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (_) => const FindDoctor(
                                    isSearching: true,
                                  ));
                          Navigator.push(context, route);
                        },
                        child: TextFormField(
                          enabled: false,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                gapPadding: 0.0,
                              ),
                              isDense: true,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.only(top: 10.0),
                              hintText: "Search Doctors",
                              prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                transform: Matrix4.translationValues(0.0, -45, 0.0),
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 16, bottom: 16, left: 4),
                      child: Text(
                        'Hello!', // TODO: add greeting
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeWidget(
                          title: "Book Home \nServices",
                          icon: MyIcons.icHomeService,
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const BookTreatment());
                            Navigator.push(context, route);
                          },
                        ),
                        HomeWidget(
                          title: "Find the Best \nSpecialist",
                          icon: MyIcons.icDoctorColored,
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const FindDoctor(
                                      isSearching: false,
                                    ));
                            Navigator.push(context, route);
                          },
                        ),
                        HomeWidget(
                          title: "My Home \nServices",
                          icon: MyIcons.icHomeService,
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const MyTreatments());
                            Navigator.push(context, route);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeWidget(
                          title: "Diagnostics",
                          icon: MyIcons.icLabColored,
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const TestType());
                            Navigator.push(context, route);
                          },
                        ),
                        HomeWidget(
                          title: "Medicines",
                          icon: MyIcons.icMedicineColored,
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const MedicineOrderType());
                            Navigator.push(context, route);
                          },
                        ),
                        HomeWidget(
                          title: "My Bookings",
                          icon: MyIcons.icPharmacyColored,
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const MyBooking());
                            Navigator.push(context, route);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeWidget(
                          title: "My Prescriptions",
                          icon: MyIcons.icPrescriptionColored,
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const MyPrescriptions());
                            Navigator.push(context, route);
                          },
                        ),
                        HomeWidget(
                          title: "My Health \nRecords",
                          icon: MyIcons.icHealthRecordColored,
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const MyHealthRecords());
                            Navigator.push(context, route);
                          },
                        ),
                        HomeWidget(
                          title: "Settings",
                          icon: MyIcons.icSettingsColored,
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (_) => const Settings());
                            Navigator.push(context, route);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 56,
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Smart Hospital App by ",
                  style: TextStyle(fontSize: 14.0),
                ),
                Image.asset(
                  MyImages.instaLogoBlue,
                  height: 22.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getUpdate() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString(Keys.name);
      email = preferences.getString(Keys.email);
      imagePath = preferences.getString(Keys.image);
    });
  }

  @override
  void initState() {
    super.initState();
    getUpdate();
    notificationSetup();
  }

  void notificationSetup() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    /*_firebaseMessaging.configure(
      // foreground
      onMessage: (Map<String, dynamic> message) async {
        print("OnMessage::: $message");

        var notification = message["notification"];
        var data = message["data"] ?? message;
        String type = data[Keys.actionType];

        String title = notification["title"];
        String body = notification["body"];

        if (type != "others") {
          alertOnNotification(title: title, description: body, action: type);
        } else {
          showNotification(title: title, body: body);
        }
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("OnLaunch::: $message");
        print(
            "Old Message Id::: ${preferences.getString(Keys.googleMessageId)}");
        var data = message["data"] ?? message;
        if (!checkMessageId(data['google.message_id'])) {
          return;
        }
        String type = data[Keys.actionType];
        navigate(type);
      },
      onResume: (Map<String, dynamic> message) async {
        print("OnResume::: $message");

        var data = message["data"] ?? message;
        if (!checkMessageId(data['google.message_id'])) {
          return;
        }
        String type = data[Keys.actionType];
        navigate(type);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });*/

    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      saveTokenTask(token: token);
    });
  }

  static saveTokenTask({required String? token}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString(Keys.username);

    String response = await Utilities.httpPost(ServerConfig.saveToken +
        '&deviceType=Flutter&username=$username&token=$token&ProjectId=${Keys.projectId}');

    if (response != '404') {
      print("Token was saved Successfully");
    } else {
      print("Unable to save firebase token");
    }
  }

  showNotification({String? title, String? body}) async {
    var android = const AndroidNotificationDetails("Updates", "Updates",
        importance: Importance.defaultImportance,
        styleInformation: BigTextStyleInformation(""));
    var ios = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin.show(
        rng.nextInt(100), title, body, platform);
  }

  void navigate(String? type) {
    if (type == Keys.labOrders) {
      Route route = MaterialPageRoute(
          builder: (_) => const MyBooking(
                initialIndex: 0,
              ));
      Navigator.push(context, route);
    } else if (type == Keys.appointment) {
      Route route = MaterialPageRoute(
          builder: (_) => const MyBooking(
                initialIndex: 2,
              ));
      Navigator.push(context, route);
    } else if (type == Keys.medicines) {
      Route route = MaterialPageRoute(
          builder: (_) => const MyBooking(
                initialIndex: 1,
              ));
      Navigator.push(context, route);
    } else if (type == Keys.labReport) {
      Route route = MaterialPageRoute(builder: (_) => const LabReports());
      Navigator.push(context, route);
    } else if (type == Keys.treatments || type == Keys.homeServices) {
      Route route = MaterialPageRoute(builder: (_) => const MyTreatments());
      Navigator.push(context, route);
    } else if (type == Keys.prescription) {
      Route route = MaterialPageRoute(builder: (_) => const MyPrescriptions());
      Navigator.push(context, route);
    }
  }

  void alertOnNotification({String? title, String? description, String? action}) {
    showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: Container(
                color: MyColors.primary,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: AutoSizeText(
                    title!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )),
            content: Text(description!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  navigate(action);
                },
                child: const Text("VIEW"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("DISMISS"),
              ),
            ],
          );
        });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utilities.showToast("Press back again to Exit.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  bool checkMessageId(String messageId) {
    String oldId = preferences.getString(Keys.googleMessageId) ?? "";
    if (oldId == messageId) {
      return false;
    } else {
      preferences.setString(Keys.googleMessageId, messageId);
      return true;
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }
}
