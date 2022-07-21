import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/user_accounts/user_accounts_delete_controller.dart';

class DeleteUserAccounts extends StatelessWidget {
  const DeleteUserAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeleteUserAccountsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Accounts"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Alert!",
              style: Get.textTheme.headline5?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              '''
All your data will be deleted Profile Info, Appointments, Lab Tests, Medicines and Medical Records.
Tap on Delete Account to continue.
              ''',
              style: Get.textTheme.headline6,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Alert..!',
                  middleText: 'Do you really want to delete your account?',
                  textCancel: 'No',
                  textConfirm: 'Yes',
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.back();
                    controller.deleteRecord();
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text('Delete Account'),
            ),
          ),
        ),
      ),
    );
  }
}
