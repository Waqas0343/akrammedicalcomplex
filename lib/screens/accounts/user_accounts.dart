import 'package:amc/controllers/user_accounts/user_account_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/otp_model.dart';

class UserAccounts extends StatelessWidget {
  final OTPResponse? list;

  const UserAccounts({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserAccountsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Accounts"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
          itemCount: list?.userList?.length,
          itemBuilder: (BuildContext context, int index) {
            UserShortModel? userShortModel = list?.userList![index];
            return GestureDetector(
              onTap: () {
                controller.login(userShortModel!);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                child: Card(
                  child: ListTile(
                    leading: Text("${index + 1}"),
                    title: Text(
                      userShortModel?.name ?? '',
                      style: Get.textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
