import 'package:amc/Screens/Bookings/bookTest.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TestType extends StatelessWidget {
  const TestType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Select Test Type"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 24,
        ),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text(
                  "Select Test",
                  style: TextStyle(
                    fontFamily: "SemiBold",
                    fontSize: 18,
                  ),
                ),
                leading: SvgPicture.asset(
                  MyIcons.icCheckList,
                  color: MyColors.primary,
                  height: 28,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Get.to(
                    () => const BookTest(
                      isPrescription: false,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text(
                  "Upload Prescription",
                  style: TextStyle(
                    fontFamily: "SemiBold",
                    fontSize: 18,
                  ),
                ),
                leading: SvgPicture.asset(
                  MyIcons.icUploadDocs,
                  color: MyColors.primary,
                  height: 28,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Get.to(
                    () => const BookTest(
                      isPrescription: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
