import 'package:amc/Screens/Bookings/BookTreatment.dart';
import 'package:amc/Screens/Bookings/SelectTestType.dart';
import 'package:amc/Screens/MyBooking/MyBooking.dart';
import 'package:amc/Screens/Orders/Medicines/MedicineOrderType.dart';
import 'package:amc/Screens/Prescription/MyPrescriptions.dart';
import 'package:amc/Screens/Settings/Settings.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/Widgets/drawer_list.dart';
import 'package:amc/services/preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../routes/routes.dart';
import 'Doctors/find_doctor.dart';
import 'LabReports/LabReports.dart';

class AppDrawer extends StatefulWidget {
  final String? name, imagePath, mrNumber;

  const AppDrawer({Key? key, this.name, this.imagePath, this.mrNumber})
      : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          GestureDetector(
            onTap: () {
              Route route = MaterialPageRoute(builder: (_) => const Settings());
              Navigator.push(context, route);
            },
            child: DrawerHeader(
              padding:
                  const EdgeInsets.only(bottom: 16, top: 6, right: 8, left: 16),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AutoSizeText(
                                  widget.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                AutoSizeText(widget.mrNumber ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        const TextStyle(color: Colors.black)),
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
              Route route =
                  MaterialPageRoute(builder: (_) => const BookTreatment());
              Navigator.push(context, route);
            },
          ),
          DrawerList(
            title: "Book Lab Test",
            icon: MyIcons.icLabColored,
            isBottomBorder: true,
            isDropdown: false,
            onTap: () {
              Route route = MaterialPageRoute(builder: (_) => const TestType());
              Navigator.push(context, route);
            },
          ),
          DrawerList(
            title: "Book Medicine",
            icon: MyIcons.icMedicineColored,
            isBottomBorder: true,
            isDropdown: false,
            onTap: () {
              Route route =
                  MaterialPageRoute(builder: (_) => const MedicineOrderType());
              Navigator.push(context, route);
            },
          ),
          DrawerList(
            title: "My Prescriptions",
            icon: MyIcons.icPrescriptionColored,
            isBottomBorder: true,
            isDropdown: false,
            onTap: () {
              Route route =
                  MaterialPageRoute(builder: (_) => const MyPrescriptions());
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
              Route route = MaterialPageRoute(builder: (_) => const Settings());
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
            title: "Delete Account",
            icon: MyIcons.icProfile,
            isBottomBorder: true,
            isDropdown: false,
            onTap: () {
              Get.toNamed(AppRoutes.deleteAccounts);
            },
          ),

          DrawerList(
            title: "Logout",
            icon: MyIcons.icLogout,
            isBottomBorder: true,
            isDropdown: false,
            onTap: () {
              Get.find<Preferences>().clear();
              Get.offAllNamed(AppRoutes.login);
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Version: 1.0.4",
            style: Get.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
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
}
