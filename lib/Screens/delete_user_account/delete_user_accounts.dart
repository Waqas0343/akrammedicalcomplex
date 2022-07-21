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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const Text(
            "Alert..!",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "All your data will be deleted Profile Info, "
                "Appointments, Lab Tests, Medicines and Medical Records.",
                style: TextStyle(fontSize: 16.0,),
              ),
            ),
          ),
          const SizedBox(
            height: 450,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Alert..!',
                        middleText:
                            'Do you really want to delete your account?',
                        textCancel: 'No',
                        textConfirm: 'Yes',
                        onConfirm: () {
                          Get.back();
                          controller.deleteRecord();
                        });
                  },
                  child: const Text('Delete Accounts'),
                )),
          ),
        ],
      ),
    );
  }
}
