import 'package:amc/Screens/Prescription/MyPrescriptions.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Screens/Bookings/BookTreatment.dart';
import 'package:amc/Screens/Bookings/SelectTestType.dart';
import 'package:amc/Screens/Login.dart';
import 'package:amc/Screens/MyBooking/MyBooking.dart';
import 'package:amc/Screens/Settings/Settings.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Widgets/drawer_list.dart';
import 'package:amc/Screens/Orders/Medicines/MedicineOrderType.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/routes.dart';
import 'Doctors/find_doctor.dart';
import 'LabReports/LabReports.dart';

class AppDrawer extends StatefulWidget {
  final String? name, email, imagePath;

  const AppDrawer({Key? key, this.name, this.email, this.imagePath})
      : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late SharedPreferences preferences;

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
                        MaterialPageRoute(builder: (_) => const Settings());
                    Navigator.push(context, route);
                  },
                  child: DrawerHeader(
                    padding: const EdgeInsets.only(
                        bottom: 16, top: 6, right: 8, left: 16),
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
                              SizedBox(
                                height: 65,
                                width: 65,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  child: NetWorkImage(
                                    imagePath: widget.imagePath,
                                    placeHolder: MyImages.imageNotFound,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
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
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      AutoSizeText(widget.email ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black)),
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
                  title: "Delete Accounts",
                  icon: MyIcons.icProfile,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Get.toNamed(AppRoutes.deleteAccounts);
                  },
                ),
                DrawerList(
                  title: "Find Doctor",
                  icon: MyIcons.icDoctorColored,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (_) => const FindDoctor(
                              isSearching: false,
                            ));
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Home Services",
                  icon: MyIcons.icHomeService,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (_) => const BookTreatment());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Book Lab Test",
                  icon: MyIcons.icLabColored,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => const TestType());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Book Medicine",
                  icon: MyIcons.icMedicineColored,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (_) => const MedicineOrderType());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "My Prescriptions",
                  icon: MyIcons.icPrescriptionColored,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (_) => const MyPrescriptions());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Lab Reports",
                  icon: MyIcons.icLabReportColored,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => const LabReports());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "My bookings",
                  icon: MyIcons.icPharmacyColored,
                  isBottomBorder: true,
                  isDropdown: false,
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => const MyBooking());
                    Navigator.push(context, route);
                  },
                ),
                DrawerList(
                  title: "Profile Settings",
                  icon: MyIcons.icSettingsColored,
                  isBottomBorder: true,
                  isDropdown: true,
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => const Settings());
                    Navigator.push(context, route);
                  },
                ),
                // DrawerList(
                //   title: "Change Password",
                //   icon: MyIcons.icPassword,
                //   isBottomBorder: true,
                //   isDropdown: true,
                //   onTap: () {
                //     Route route = MaterialPageRoute(
                //         builder: (_) => const AccountSettings());
                //     Navigator.push(context, route);
                //   },
                // ),
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
                        MaterialPageRoute(builder: (_) => const Login());
                    Navigator.pushAndRemoveUntil(
                        context, newRoute, (route) => false);
                  },
                ),
              ],
            ),
          ),
          // Expanded(
          //     flex: 0,
          //     child: Container(
          //       padding: EdgeInsets.only(bottom: 24, top: 14),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           // Column(
          //           //   crossAxisAlignment: CrossAxisAlignment.center,
          //           //   mainAxisAlignment: MainAxisAlignment.end,
          //           //   children: [
          //           //     Text(
          //           //       "Smart Hospital App by ",
          //           //       style: TextStyle(fontSize: 14.0),
          //           //     ),
          //           //     Image.asset(
          //           //       MyImages.instaLogoBlue,
          //           //       height: 22.0,
          //           //     )
          //           //   ],
          //           // ),
          //           // SizedBox(
          //           //   height: 8,
          //           // ),
          //           // Container(
          //           //   height: 40,
          //           //   child: Row(
          //           //     mainAxisAlignment: MainAxisAlignment.center,
          //           //     children: [
          //           //       FloatingActionButton(
          //           //         heroTag: "facebooktag",
          //           //         backgroundColor: Colors.grey,
          //           //         elevation: 2,
          //           //         child: Icon(
          //           //           MdiIcons.facebook,
          //           //           color: Colors.white,
          //           //           size: 22,
          //           //         ),
          //           //         onPressed: () async {
          //           //           try {
          //           //             bool launched = await launch(
          //           //                 "fb://page/340935203163369",
          //           //                 forceSafariVC: false);
          //           //             if (!launched) {
          //           //               await launch(
          //           //                   "https://www.facebook.com/AMClhrofficial/",
          //           //                   forceSafariVC: false);
          //           //             }
          //           //           } catch (e) {
          //           //             await launch(
          //           //                 "https://www.facebook.com/AMClhrofficial/",
          //           //                 forceSafariVC: false);
          //           //           }
          //           //         },
          //           //       ),
          //           //       // FloatingActionButton(
          //           //       //   heroTag: 'whatsappTag',
          //           //       //   backgroundColor: Colors.grey,
          //           //       //   elevation: 2,
          //           //       //   child: Icon(
          //           //       //     MdiIcons.whatsapp,
          //           //       //     color: Colors.white,
          //           //       //     size: 22,
          //           //       //   ),
          //           //       //   onPressed: () async {
          //           //       //     try{
          //           //       //       await launch("whatsapp://send?phone=+923024124705" , forceSafariVC: false);
          //           //       //     }catch(e){
          //           //       //       Utilities.showToast('WhatsApp not installed');
          //           //       //     }
          //           //       //   },
          //           //       // ),
          //           //       FloatingActionButton(
          //           //         heroTag: 'linkeninTag',
          //           //         backgroundColor: Colors.grey,
          //           //         elevation: 2,
          //           //         child: Icon(
          //           //           MdiIcons.linkedin,
          //           //           color: Colors.white,
          //           //           size: 22,
          //           //         ),
          //           //         onPressed: () async {
          //           //           try {
          //           //             bool launched = await launch(
          //           //                 "linkedin://amclhrofficial",
          //           //                 forceSafariVC: false);
          //           //             if (!launched) {
          //           //               await launch(
          //           //                   "https://www.linkedin.com/in/amclhrofficial",
          //           //                   forceSafariVC: false);
          //           //             }
          //           //           } catch (e) {
          //           //             await launch(
          //           //                 "https://www.linkedin.com/in/amclhrofficial",
          //           //                 forceSafariVC: false);
          //           //           }
          //           //         },
          //           //       ),
          //           //       FloatingActionButton(
          //           //         heroTag: 'twitterTag',
          //           //         backgroundColor: Colors.grey,
          //           //         elevation: 2,
          //           //         child: Icon(
          //           //           MdiIcons.twitter,
          //           //           color: Colors.white,
          //           //           size: 22,
          //           //         ),
          //           //         onPressed: () async {
          //           //           try {
          //           //             bool launched = await launch(
          //           //                 "https://twitter.com/amclhrofficial",
          //           //                 forceSafariVC: false);
          //           //             if (!launched) {
          //           //               await launch(
          //           //                   "https://twitter.com/amclhrofficial",
          //           //                   forceSafariVC: false);
          //           //             }
          //           //           } catch (e) {
          //           //             await launch(
          //           //                 "https://twitter.com/amclhrofficial",
          //           //                 forceSafariVC: false);
          //           //           }
          //           //         },
          //           //       ),
          //           //       FloatingActionButton(
          //           //         heroTag: 'instagramTag',
          //           //         backgroundColor: Colors.grey,
          //           //         elevation: 2,
          //           //         child: Icon(
          //           //           MdiIcons.instagram,
          //           //           color: Colors.white,
          //           //           size: 22,
          //           //         ),
          //           //         onPressed: () async {
          //           //           try {
          //           //             bool launched = await launch(
          //           //                 "https://www.instagram.com/jakramaimc",
          //           //                 forceSafariVC: false);
          //           //             if (!launched) {
          //           //               await launch(
          //           //                   "https://www.instagram.com/jakramaimc",
          //           //                   forceSafariVC: false);
          //           //             }
          //           //           } catch (e) {
          //           //             await launch(
          //           //                 "https://www.instagram.com/jakramaimc",
          //           //                 forceSafariVC: false);
          //           //           }
          //           //         },
          //           //       ),
          //           //     ],
          //           //   ),
          //           // )
          //         ],
          //       ),
          //     ))
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
    return DropdownButton(
        items: <String>["Change Password", "Profile Setting"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
            onTap: () {},
          );
        }).toList(),
        onChanged: null);
  }


  void updateUi() async {
    preferences = await SharedPreferences.getInstance();
  }
}
