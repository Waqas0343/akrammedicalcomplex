import 'dart:convert';
import 'package:amc/Screens/Signup.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/login_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final remindPhoneController = TextEditingController();
  bool phoneValidate = false;
  bool passwordValidate = false;
  final FocusNode phoneFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  var isPhoneEmpty = false;
  final loginController = Get.put(LoginController());
  bool visible = true;
  late SharedPreferences preferences;
  bool isTaped = true;
  String buttonText = "Login";
  String phoneError = "Phone can't be Empty";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 0,
                child: ClipOval(
                  child: Image.asset(
                    MyImages.logo,
                    height: 160.0,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                                color: MyColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextField(
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            inputFormatters: [
                              Utilities.onlyNumberFormat(),
                            ],
                            textInputAction: TextInputAction.next,
                            focusNode: phoneFocus,
                            controller: loginController.phoneController,
                            onChanged: (text) {
                              if (text.isNotEmpty) {
                                if (Utilities.numberHasValid(text)) {
                                  setState(() {
                                    isPhoneEmpty = false;
                                  });
                                }
                              }
                            },
                            onSubmitted: (text) {
                              phoneFocus.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(usernameFocus);
                            },
                            decoration: InputDecoration(
                              hintText: "Phone",
                              filled: false,
                              counterText: "",
                              errorText: isPhoneEmpty ? phoneError : null,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: GestureDetector(
                          //     onTap: () => forgotDialog(),
                          //     child: const Text(
                          //       'Account Forgot?',
                          //       textAlign: TextAlign.right,
                          //       style: TextStyle(
                          //           color: MyColors.primary,
                          //           fontWeight: FontWeight.w600,
                          //           letterSpacing: 0.4),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed:
                            isTaped ? () => loginController.login() : null,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Don't have an Account? ",
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: "Get Registered",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.signUp);
                                  })
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Smart Hospital App by ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Image.asset(
                      MyImages.instaLogoBlue,
                      height: 36.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void forgotDialog() {
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Container(
            color: MyColors.primary,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                "Reminder Account",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                  "Enter your registered mobile number or Login ID to receive the password or contact our support. Once you receive your old password please use it to reset after logging in."),
              const SizedBox(
                height: 16,
              ),
              TextField(
                textInputAction: TextInputAction.send,
                controller: remindPhoneController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    filled: false, hintText: "Login ID / Phone"),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () async {
                String phone = remindPhoneController.text.trim().toString();
                if (phone.isNotEmpty) {
                  bool result = await sendPassword(phone);
                  if (result) {
                    Navigator.pop(context);
                  }
                } else {
                  Utilities.showToast("Please Enter Your Phone / Login ID");
                }
              },
              child: const Text("Send")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close")),
        ],
      ),
    );
  }

  @override
  void initState() {
    updateUi();
    super.initState();
  }

  void updateUi() async {
    preferences = await SharedPreferences.getInstance();
  }

  void userDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text(
            "User Not Exist Do you want to create new account",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(const SignUp());
              },
              child: const Text(
                "Yes",
              ),
            ),
          ],
        ),
      );

  Future<bool> sendPassword(String phone) async {
    if (await Utilities.isOnline()) {
      Loading.build(context, true);
      String response = await Utilities.httpPost(
          ServerConfig.remindAccount + "&resetphone=$phone");
      Loading.dismiss();
      if (response != "404") {
        String message = jsonDecode(response)["Response"]["Response"];
        Utilities.showToast(message.replaceAll("Invalid Phone number. ", ""));
        if (message.contains("User does not exit")) {
          return false;
        }
        return true;
      }
    }
    return false;
  }

}
