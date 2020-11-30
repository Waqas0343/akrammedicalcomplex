import 'dart:convert';
import 'dart:ui';

import 'package:amc/Models/LoginModel.dart';
import 'package:amc/Screens/AccountCreation/ActivationCode.dart';
import 'package:amc/Screens/Home.dart';
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

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final remindPhoneController = new TextEditingController();
  final phoneController = new TextEditingController();
  final passwordController = new TextEditingController();

  bool phoneValidate = false;
  bool passwordValidate = false;

  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool visible = true;

  SharedPreferences preferences;


  bool isTaped = true;
  String buttonText = "Login";

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  child: ClipOval(
                    child: Image.asset(
                      MyImages.AMCLogo,
                      height: 130.0,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                color: MyColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: phoneController,
                            focusNode: usernameFocus,
                            onSubmitted: (text){
                              this.usernameFocus.unfocus();
                              FocusScope.of(context).requestFocus(passwordFocus);
                            },
                            onChanged: (text){
                              if (text.isNotEmpty){
                                setState(() =>phoneValidate = false);
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: "Login ID / Phone",
                              errorText: phoneValidate ? "Can\'t be Empty" : null,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: visible,
                            controller: passwordController,
                            focusNode: passwordFocus,
                            onSubmitted: (text){
                              this.passwordFocus.unfocus();
                            },
                            onChanged: (text){
                              if (text.isNotEmpty){
                                setState(() =>passwordValidate = false);
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
                              errorText: passwordValidate ? "Can\'t be Empty" : null,
                            ),
                          ),

                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => forgotDialog(),
                              child: Text(
                                'Account Forgot?',
                                textAlign: TextAlign.right,
                                style: TextStyle(color: MyColors.primary, fontWeight: FontWeight.w600, letterSpacing: 0.4),
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed:isTaped? () =>login():null,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        padding: EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        color: MyColors.primary,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16,),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(text: "Don't have an Account? ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Get Registered",
                                style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(context, "/signup");
                                  }
                            )
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
                    Text("Smart Hospital App by ", style: TextStyle(fontSize: 16.0),),
                    Image.asset(MyImages.instaLogoBlue, height: 36.0,),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text("Reminder Account", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
            )),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                  "Enter your registered mobile number or Login ID to receive the password or contact our support. Once you receive your old password please use it to reset after logging in."),
              SizedBox(
                height: 16,
              ),
              TextField(
                textInputAction: TextInputAction.send,
                controller: remindPhoneController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: false,
                    hintText: "Login ID / Phone"),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              color: MyColors.primary,
              textColor: Colors.white,
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
              child: Text("Send")),
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              textColor: MyColors.primary,
              child: Text("Close")),

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

    String response = await Utilities.httpGet(ServerConfig.login +
        "&Username=$username&Password=$password");

    Loading.dismiss();

    if (response != "404") {
      User user = loginFromJson(response).response.user;
      
      preferences.setString(Keys.username, user.username);
      preferences.setString(Keys.phone, user.phone);
      preferences.setString(Keys.image, user.imagePath);
      preferences.setString(Keys.name, user.name);
      preferences.setString(Keys.email, user.email);
      preferences.setString(Keys.sessionToken, user.sessionToken);
      preferences.setString(Keys.address, user.huAddress.location);
      preferences.setString(Keys.city, user.huAddress.city);
      preferences.setString(Keys.area, user.huAddress.area);
      if(!user.activationStatus) {
        Route route = new MaterialPageRoute(builder: (context) => AccountActivation(user.phone));
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
        await Utilities.httpGet(ServerConfig.RESENT_CODE + '&user=$username');
      } else {
        preferences.setBool(Keys.status, true);
        Route route = new MaterialPageRoute(builder: (context) => Home());
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

  void updateUi() async{
    preferences = await SharedPreferences.getInstance();
  }

  Future<bool> sendPassword(String phone) async {
    if (await Utilities.isOnline()) {
      Loading.build(context, true);
      String response = await Utilities.httpPost(ServerConfig.remindAccount + "&resetphone=$phone");
      Loading.dismiss();
      if (response != "404") {
        print(response);
        String message = jsonDecode(response)["Response"]["Response"];
        Utilities.showToast(message.replaceAll("Invalid Phone number. ", ""));
        if (message.contains("User does not exit")){
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
