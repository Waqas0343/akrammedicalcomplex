import 'dart:convert';

import 'package:amc/models/login_model.dart';
import 'package:amc/Screens/account_creation/ActivationCode.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final remindPhoneController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool phoneValidate = false;
  bool passwordValidate = false;

  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool visible = true;

  late SharedPreferences preferences;

  bool isTaped = true;
  String buttonText = "Login";

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
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: phoneController,
                            focusNode: usernameFocus,
                            onSubmitted: (text) {
                              usernameFocus.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(passwordFocus);
                            },
                            onChanged: (text) {
                              if (text.isNotEmpty) {
                                setState(() => phoneValidate = false);
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: "Login ID / Phone",
                              errorText:
                                  phoneValidate ? "Can't be Empty" : null,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: visible,
                            controller: passwordController,
                            focusNode: passwordFocus,
                            onSubmitted: (text) {
                              passwordFocus.unfocus();
                            },
                            onChanged: (text) {
                              if (text.isNotEmpty) {
                                setState(() => passwordValidate = false);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              filled: false,
                              suffixIcon: IconButton(
                                  icon: Icon(visible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      visible = !visible;
                                    });
                                  }),
                              errorText:
                                  passwordValidate ? "Can't be Empty" : null,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => forgotDialog(),
                              child: const Text(
                                'Account Forgot?',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: MyColors.primary,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.4),
                              ),
                            ),
                          ),
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
                        onPressed: isTaped ? () => login() : null,
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
                                    Navigator.pushReplacementNamed(
                                        context, "/signup");
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

  void login() async {
    disableButton();
    String username = phoneController.text.trim().replaceAll(" ", "");
    String password = passwordController.text.trim();

    usernameFocus.unfocus();
    passwordFocus.unfocus();

    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable(context);
      return;
    }

    if (username.isEmpty) {
      enableButton();
      setState(() {
        phoneValidate = true;
      });
      return;
    }

    if (password.isEmpty) {
      enableButton();
      setState(() {
        passwordValidate = true;
      });
      return;
    }

    Loading.build(context, false);

    String response = await Utilities.httpGet(
        ServerConfig.login + "&Username=$username&Password=$password");

    Loading.dismiss();

    if (response != "404") {
      User user = loginFromJson(response).response!.user!;

      preferences.setString(Keys.username, user.username!);
      preferences.setString(Keys.phone, user.phone!);
      preferences.setString(Keys.image, user.imagePath!);
      preferences.setString(Keys.name, user.name!);
      preferences.setString(Keys.email, user.email!);
      preferences.setString(Keys.sessionToken, user.sessionToken!);
      preferences.setString(Keys.address, user.huAddress!.location!);
      preferences.setString(Keys.city, user.huAddress!.city!);
      preferences.setString(Keys.area, user.huAddress!.area!);
      if (!user.activationStatus!) {
        Route route = MaterialPageRoute(
            builder: (context) => AccountActivation(user.phone));
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
        await Utilities.httpGet(ServerConfig.resentCode + '&user=$username');
      } else {
        preferences.setBool(Keys.status, true);
        Route route = MaterialPageRoute(builder: (context) => Home());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      }
    } else {
      Utilities.showToast("Authentication Denied");
    }
    enableButton();
  }

  @override
  void initState() {
    updateUi();
    super.initState();
  }

  void updateUi() async {
    preferences = await SharedPreferences.getInstance();
  }

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
