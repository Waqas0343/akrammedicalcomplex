import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final newConPassController = TextEditingController();

  final FocusNode currentFocus = FocusNode();
  final FocusNode newPassFocus = FocusNode();
  final FocusNode newConPassFocus = FocusNode();

  bool isCurrentEmpty = false;
  bool isNewEmpty = false;
  bool isNewConEmpty = false;

  bool isTaped = true;
  String buttonText = "Update";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          "Change Password",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            TextField(
              focusNode: currentFocus,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              controller: currentPassController,
              decoration: InputDecoration(
                hintText: "Current Password",
                errorText: isCurrentEmpty ? "Required" : null,
              ),
              onSubmitted: (text) {
                currentFocus.unfocus();
                FocusScope.of(context).requestFocus(newPassFocus);
              },
              onChanged: (text) {
                if (text.trim().isNotEmpty) {
                  setState(() {
                    isCurrentEmpty = false;
                  });
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              focusNode: newPassFocus,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              controller: newPassController,
              decoration: InputDecoration(
                hintText: "New Password",
                errorText: isNewEmpty ? "Required" : null,
              ),
              onSubmitted: (text) {
                newPassFocus.unfocus();
                FocusScope.of(context).requestFocus(newConPassFocus);
              },
              onChanged: (text) {
                if (text.trim().isNotEmpty) {
                  setState(() {
                    isNewEmpty = false;
                  });
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              focusNode: newConPassFocus,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              controller: newConPassController,
              decoration: InputDecoration(
                hintText: "New Confirm Password",
                errorText: isNewConEmpty ? "Required" : null,
              ),
              onChanged: (text) {
                if (text.trim().isNotEmpty) {
                  setState(() {
                    isNewConEmpty = false;
                  });
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: isTaped ? () => update() : null,
                  child: Text(buttonText),
                ))
          ],
        ),
      ),
    );
  }

  void update() async {
    disableButton();
    String currentPassword = currentPassController.text.trim();
    String newPassword = newPassController.text.trim();
    String newConfirmPassword = newConPassController.text.trim();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? phone = preferences.getString(Keys.phone);
    String? username = preferences.getString(Keys.username);

    currentFocus.unfocus();
    newPassFocus.unfocus();
    newConPassFocus.unfocus();

    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable();
      return;
    }

    if (currentPassword.isEmpty) {
      enableButton();
      setState(() {
        isCurrentEmpty = true;
      });

      return;
    }
    if (newPassword.isEmpty) {
      enableButton();
      setState(() {
        isNewEmpty = true;
      });
      return;
    }
    if (newConfirmPassword.isEmpty) {
      enableButton();
      setState(() {
        isNewConEmpty = true;
      });
      return;
    }

    if (newPassword != newConfirmPassword) {
      enableButton();
      Utilities.showToast("Confirm Password does not match with New Password");
      return;
    }

    Loading.build(context, false);
    String values =
        "&phone=$phone&userid=$username&current_password=$currentPassword&new_password=$newPassword";

    String response =
        await Utilities.httpPost(ServerConfig.changePassword + values);
    Loading.dismiss();

    if (response != "404") {
      setState(() {
        currentPassController.clear();
        newPassController.clear();
        newConPassController.clear();
      });
      Utilities.showToast("Your Password has been updated");
    } else {
      Utilities.showToast("Unable to change password, try again later");
    }
    enableButton();
  }

  void disableButton() {
    setState(() {
      isTaped = false;
    });
  }

  void enableButton() {
    setState(() {
      isTaped = true;
    });
  }
}
