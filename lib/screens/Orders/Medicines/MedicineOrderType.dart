import 'package:amc/Styles/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'MedicineOrderPlace.dart';

class MedicineOrderType extends StatelessWidget {
  const MedicineOrderType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Select Medicine Type"),
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
                  "Select Medicines",
                  style: TextStyle(
                    fontFamily: "SemiBold",
                    fontSize: 18,
                  ),
                ),
                leading: const Icon(
                  MdiIcons.medicalBag,
                  color: MyColors.primary,
                  size: 38,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Get.to(
                    () => const MedicineOrderPlace(false),
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
                leading: const Icon(
                  MdiIcons.upload,
                  color: MyColors.primary,
                  size: 38,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  Get.to(
                    () => const MedicineOrderPlace(true),
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
