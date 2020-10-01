import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:amc/Screens/AppDrawer.dart';
import 'package:amc/Screens/Bookings/BookTreatment.dart';
import 'package:amc/Screens/Doctors/FindDoctor.dart';
import 'package:amc/Screens/HealthRecords/MyHealthRecords.dart';
import 'package:amc/Screens/LabReports/LabReports.dart';
import 'package:amc/Screens/MyBooking/MyBooking.dart';
import 'package:amc/Screens/MyBooking/MyTreatments.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/home_card.dart';
import 'package:amc/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Screens/Orders/Medicines/MedicineOrderType.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bookings/SelectTestType.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime currentBackPressTime;
  SharedPreferences preferences;
  String name, email, imagePath;
  var rng = new Random();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(Keys.appName),
          centerTitle: true,
        ),
        drawer: AppDrawer(
          name: name,
          email: email,
          imagePath: imagePath,
        ),
        body: ListView(
          padding: EdgeInsets.only(
            bottom: 16.0,
          ),
          children: [
            Card(
              elevation: 6,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: MyColors.primary,
              child: InkWell(
                highlightColor: Colors.white.withOpacity(0.1),
                splashColor: Colors.white.withOpacity(0.2),
                onTap: () {
                  Route route =
                      new MaterialPageRoute(builder: (_) => BookTreatment());
                  Navigator.push(context, route);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 28,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Book",
                              style: TextStyle(
                                  fontFamily: "SemiBold",
                                  fontSize: 38,
                                  color: Colors.white,
                                  letterSpacing: 1.4),
                            ),
                            AutoSizeText(
                              "Home Services",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            MyIcons.icTreatment,
                            color: Colors.white,
                            height: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: HomeCard(
                      title: "Find Doctor",
                      description: "Find The Best Specialist",
                      icon: MyIcons.icSearchDoctor,
                      onTap: () {
                        Route route =
                            new MaterialPageRoute(builder: (_) => FindDoctor());
                        Navigator.push(context, route);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      flex: 1,
                      child: HomeCard(
                          title: "Home Services",
                          description: "Booked Home Services",
                          icon: MyIcons.icTreatment,
                          onTap: () {
                            Route route = new MaterialPageRoute(
                                builder: (_) => MyTreatments());
                            Navigator.push(context, route);
                          })),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: HomeCard(
                          title: "Diagnostics",
                          description: "Book Lab Test",
                          icon: MyIcons.icDiagnostics,
                          onTap: () {
                            Route route = new MaterialPageRoute(
                                builder: (_) => TestType());
                            Navigator.push(context, route);
                          })),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 1,
                    child: HomeCard(
                      title: "Medicines",
                      description: "Get Medicine At Your Doorstep",
                      icon: MyIcons.icMedicine,
                      onTap: () {
                        Route route = new MaterialPageRoute(
                            builder: (_) => MedicineOrderType());
                        Navigator.push(context, route);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                children: [

                  Expanded(
                      flex: 1,
                      child: HomeCard(
                          title: "My Bookings",
                          description: "Your whole Bookings",
                          icon: MyIcons.icBookings,
                          onTap: () {
                            Route route = new MaterialPageRoute(
                                builder: (_) => MyBooking());
                            Navigator.push(context, route);
                          })),
                  // Expanded(
                  //     flex: 1,
                  //     child: HomeCard(
                  //         title: "Settings",
                  //         description: "Manage your Profile and Account Settings",
                  //         icon: MyIcons.icSettings,
                  //         onTap: () {
                  //           Route route = new MaterialPageRoute(
                  //               builder: (_) => Settings());
                  //           Navigator.push(context, route);
                  //         })),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      flex: 1,
                      child: HomeCard(
                          title: "Health Records",
                          description: "Upload your Health Records",
                          icon: MyIcons.icRecords,
                          onTap: () {
                            Route route = new MaterialPageRoute(
                                builder: (_) => MyHealthRecords());
                            Navigator.push(context, route);
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    notificationSetup();
    getUpdate();
    super.initState();
  }

  void getUpdate() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      name = preferences.getString(Keys.name);
      email = preferences.getString(Keys.email);
      imagePath = preferences.getString(Keys.image);
    });
  }

  void notificationSetup() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _firebaseMessaging.configure(
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
        var data = message["data"] ?? message;
        String type = data[Keys.actionType];
        navigate(type);
      },
      onResume: (Map<String, dynamic> message) async {
        print("OnResume::: $message");
        var data = message["data"] ?? message;
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
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      saveTokenTask(token: token);
      print("Firebase Token::: $token");
    });
  }

  static saveTokenTask({@required String token}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.username);

    String response = await Utilities.httpPost(ServerConfig.SAVE_TOKEN +
        '&deviceType=Flutter&username=$username&token=$token&ProjectId=${Keys.projectId}');

    if (response != '404') {
      print(response);
    } else {
      print("Unable to save firebase token");
    }
  }

  showNotification({String title, String body}) async {
    var android = AndroidNotificationDetails("Updates", "Updates", "",
        importance: Importance.Default,
        styleInformation: BigTextStyleInformation(""));
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android, ios);

    await flutterLocalNotificationsPlugin.show(
        rng.nextInt(100), title, body, platform);
  }

  void navigate(String type) {
    if (type == Keys.labOrders) {
      Route route = new MaterialPageRoute(
          builder: (_) => MyBooking(
                initialIndex: 0,
              ));
      Navigator.push(context, route);
    } else if (type == Keys.appointment) {
      Route route = new MaterialPageRoute(
          builder: (_) => MyBooking(
                initialIndex: 2,
              ));
      Navigator.push(context, route);
    } else if (type == Keys.medicines) {
      Route route = new MaterialPageRoute(
          builder: (_) => MyBooking(
                initialIndex: 1,
              ));
      Navigator.push(context, route);
    } else if (type == Keys.labReport) {
      Route route = new MaterialPageRoute(builder: (_) => LabReports());
      Navigator.push(context, route);
    } else if (type == Keys.treatments || type == Keys.homeServices) {
      Route route = new MaterialPageRoute(builder: (_) => MyTreatments());
      Navigator.push(context, route);
    }
  }

  void alertOnNotification({String title, String description, String action}) {
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
                  child: Text(
                    title,
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )),
            content: Text(description),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  navigate(action);
                },
                child: Text("VIEW"),
                color: MyColors.primary,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("DISMISS"),
                textColor: MyColors.primary,
              ),
            ],
          );
        });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utilities.showToast("Press back again to Exit.");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
