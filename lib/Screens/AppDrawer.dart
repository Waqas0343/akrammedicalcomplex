import 'package:amc/Screens/Prescription/MyPrescriptions.dart';
import 'package:amc/Screens/Settings/AccountSettings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Screens/Bookings/BookTreatment.dart';
import 'package:amc/Screens/Bookings/SelectTestType.dart';
import 'package:amc/Screens/Login.dart';
import 'package:amc/Screens/MyBooking/MyBooking.dart';
import 'package:amc/Screens/Privacy/PrivacyPolicy.dart';
import 'package:amc/Screens/Settings/Settings.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Widgets/drawer_list.dart';
import 'package:amc/Screens/Orders/Medicines/MedicineOrderType.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Doctors/FindDoctor.dart';
import 'LabReports/LabReports.dart';

class AppDrawer extends StatefulWidget {
  final String name, email, imagePath;

  const AppDrawer({Key key, this.name, this.email, this.imagePath})
      : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () {
                    Route route =
                        new MaterialPageRoute(builder: (_) => Settings());
                    Navigator.push(context, route);
                  },
                  child: DrawerHeader(
                    padding:
                        EdgeInsets.only(bottom: 16, top: 6, right: 8, left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ClipOval(
                            child: Image.asset(
                              MyImages.logo,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  child: FadeInImage.assetNetwork(
                                    image:
                                        widget.imagePath ?? Keys.imageNotFound,
                                    fit: BoxFit.cover,
                                    placeholder: MyImages.imageNotFound,
                                    fadeInDuration: Duration(milliseconds: 100),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 16),
                                  height: 65,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AutoSizeText(
                                        widget.name ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      AutoSizeText(widget.email ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                DrawerList(
                  title: "Home",
                  icon: MyIcons.icHome,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                DrawerList(
                  title: "Find Doctor",
                  icon: MyIcons.icSearchDoctor,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route =
                        new MaterialPageRoute(builder: (_) => FindDoctor());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Home Services",
                  icon: MyIcons.icTreatment,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route =
                        new MaterialPageRoute(builder: (_) => BookTreatment());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Book Lab Test",
                  icon: MyIcons.icLabTestResult,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route =
                        new MaterialPageRoute(builder: (_) => TestType());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Book Medicine",
                  icon: MyIcons.icMedicine,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route = new MaterialPageRoute(
                        builder: (_) => MedicineOrderType());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "My Prescriptions",
                  icon: MyIcons.icPrescription,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route = new MaterialPageRoute(
                        builder: (_) => MyPrescriptions());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Lab Reports",
                  icon: MyIcons.icReports,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route =
                        new MaterialPageRoute(builder: (_) => LabReports());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "My Bookings",
                  icon: MyIcons.icBookings,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route =
                        new MaterialPageRoute(builder: (_) => MyBooking());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Profile Settings",
                  icon: MyIcons.icProfile,
                  isBottomBorder: true,
                  isDropdown: true,
                  onTap: () {
                    Route route = new MaterialPageRoute(builder: (_) => Settings());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Change Password",
                  icon: MyIcons.icPassword,
                  isBottomBorder: true,
                  isDropdown: true,
                  onTap: () {
                    Route route = new MaterialPageRoute(builder: (_) => AccountSettings());
                    Navigator.push(context, route);
                  },
                ),
                // DrawerList(
                //   title: "About Us",
                //   icon: MyIcons.icInfo,
                //   isBottomBorder: true,
                //   isDropdown: false,
                //   onTap: () {
                //     Route route =
                //         new MaterialPageRoute(builder: (_) => PrivacyPolicy());
                //     Navigator.push(context, route);
                //   },
                // ),
                DrawerList(
                  title: "Logout",
                  icon: MyIcons.icLogout,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    preferences.setBool(Keys.status, false);
                    Route newRoute =
                        new MaterialPageRoute(builder: (_) => Login());
                    Navigator.pushAndRemoveUntil(
                        context, newRoute, (route) => false);
                  },
                ),
              ],
            ),
          ),
          Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: 24, top: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Smart Hospital App by ",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Image.asset(
                          MyImages.instaLogoBlue,
                          height: 22.0,
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Container(
                    //   height: 40,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       FloatingActionButton(
                    //         heroTag: "facebooktag",
                    //         backgroundColor: Colors.grey,
                    //         elevation: 2,
                    //         child: Icon(
                    //           MdiIcons.facebook,
                    //           color: Colors.white,
                    //           size: 22,
                    //         ),
                    //         onPressed: () async {
                    //           try {
                    //             bool launched = await launch(
                    //                 "fb://page/340935203163369",
                    //                 forceSafariVC: false);
                    //             if (!launched) {
                    //               await launch(
                    //                   "https://www.facebook.com/AMClhrofficial/",
                    //                   forceSafariVC: false);
                    //             }
                    //           } catch (e) {
                    //             await launch(
                    //                 "https://www.facebook.com/AMClhrofficial/",
                    //                 forceSafariVC: false);
                    //           }
                    //         },
                    //       ),
                    //       // FloatingActionButton(
                    //       //   heroTag: 'whatsappTag',
                    //       //   backgroundColor: Colors.grey,
                    //       //   elevation: 2,
                    //       //   child: Icon(
                    //       //     MdiIcons.whatsapp,
                    //       //     color: Colors.white,
                    //       //     size: 22,
                    //       //   ),
                    //       //   onPressed: () async {
                    //       //     try{
                    //       //       await launch("whatsapp://send?phone=+923024124705" , forceSafariVC: false);
                    //       //     }catch(e){
                    //       //       Utilities.showToast('WhatsApp not installed');
                    //       //     }
                    //       //   },
                    //       // ),
                    //       FloatingActionButton(
                    //         heroTag: 'linkeninTag',
                    //         backgroundColor: Colors.grey,
                    //         elevation: 2,
                    //         child: Icon(
                    //           MdiIcons.linkedin,
                    //           color: Colors.white,
                    //           size: 22,
                    //         ),
                    //         onPressed: () async {
                    //           try {
                    //             bool launched = await launch(
                    //                 "linkedin://amclhrofficial",
                    //                 forceSafariVC: false);
                    //             if (!launched) {
                    //               await launch(
                    //                   "https://www.linkedin.com/in/amclhrofficial",
                    //                   forceSafariVC: false);
                    //             }
                    //           } catch (e) {
                    //             await launch(
                    //                 "https://www.linkedin.com/in/amclhrofficial",
                    //                 forceSafariVC: false);
                    //           }
                    //         },
                    //       ),
                    //       FloatingActionButton(
                    //         heroTag: 'twitterTag',
                    //         backgroundColor: Colors.grey,
                    //         elevation: 2,
                    //         child: Icon(
                    //           MdiIcons.twitter,
                    //           color: Colors.white,
                    //           size: 22,
                    //         ),
                    //         onPressed: () async {
                    //           try {
                    //             bool launched = await launch(
                    //                 "https://twitter.com/amclhrofficial",
                    //                 forceSafariVC: false);
                    //             if (!launched) {
                    //               await launch(
                    //                   "https://twitter.com/amclhrofficial",
                    //                   forceSafariVC: false);
                    //             }
                    //           } catch (e) {
                    //             await launch(
                    //                 "https://twitter.com/amclhrofficial",
                    //                 forceSafariVC: false);
                    //           }
                    //         },
                    //       ),
                    //       FloatingActionButton(
                    //         heroTag: 'instagramTag',
                    //         backgroundColor: Colors.grey,
                    //         elevation: 2,
                    //         child: Icon(
                    //           MdiIcons.instagram,
                    //           color: Colors.white,
                    //           size: 22,
                    //         ),
                    //         onPressed: () async {
                    //           try {
                    //             bool launched = await launch(
                    //                 "https://www.instagram.com/jakramaimc",
                    //                 forceSafariVC: false);
                    //             if (!launched) {
                    //               await launch(
                    //                   "https://www.instagram.com/jakramaimc",
                    //                   forceSafariVC: false);
                    //             }
                    //           } catch (e) {
                    //             await launch(
                    //                 "https://www.instagram.com/jakramaimc",
                    //                 forceSafariVC: false);
                    //           }
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  @override
  void initState() {
    updateUi();
    super.initState();
  }

  Widget subMenu() {
    return DropdownButton(items: <String>["Change Password", "Profile Setting"].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
        onTap: (){},
      );}).toList(), onChanged: null);
  }

  void updateUi() async {
    preferences = await SharedPreferences.getInstance();
  }
}
