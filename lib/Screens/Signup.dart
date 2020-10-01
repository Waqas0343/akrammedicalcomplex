import 'dart:convert';

import 'package:amc/Models/LoginModel.dart';
import 'package:amc/Screens/AccountCreation/LocationGettingScreen.dart';
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

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FocusNode nameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final nameController = new TextEditingController();
  final usernameController = new TextEditingController();
  final phoneController = new TextEditingController();
  final passwordController = new TextEditingController();

  var isNameEmpty = false;
  var isUsernameEmpty = false;
  var isPhoneEmpty = false;
  var isPasswordEmpty = false;
  var isUsernameFind = false;

  String userNameError = "Username can't be empty";


  SharedPreferences preferences;
  bool visible = true;

  bool isTaped = true;
  String buttonText = "Create Account";

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
              Container(
                child: ClipOval(
                  child: Image.asset(
                    MyImages.AMCLogo,
                    height: 130.0,
                  ),
                ),
              ),
              Column(
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
                            "Register",
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
                            focusNode: nameFocus,
                            controller: nameController,
                            inputFormatters: [Utilities.onlyTextFormat()],
                            onChanged: (text){
                              if (text.isNotEmpty){
                                setState(() {
                                  isNameEmpty = false;
                                });
                              }
                            },
                            onSubmitted: (text){
                              nameFocus.unfocus();
                              FocusScope.of(context).requestFocus(phoneFocus);
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: "Full Name",
                              errorText: isNameEmpty ? "Can\'t be Empty" : null,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            inputFormatters: [Utilities.onlyNumberFormat()],
                            textInputAction: TextInputAction.next,
                            focusNode: phoneFocus,
                            controller: phoneController,
                            onChanged: (text){
                              if (text.isNotEmpty){
                                setState(() {
                                  isPhoneEmpty = false;
                                });
                              }
                            },
                            onSubmitted: (text){
                              phoneFocus.unfocus();
                              FocusScope.of(context).requestFocus(usernameFocus);
                            },
                            decoration: InputDecoration(
                              hintText: "Phone",
                              filled: false,
                              counterText: "",
                              errorText: isPhoneEmpty ? "Can\'t be Empty" : null,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Login ID
                          TextField(
                            inputFormatters: [
                              Utilities.bothFormat()
                            ],
                            textInputAction: TextInputAction.next,
                            focusNode: usernameFocus,
                            onSubmitted: (text){
                              this.usernameFocus.unfocus();
                              FocusScope.of(context).requestFocus(passwordFocus);
                            },
                            onChanged: (username){
                              if(username.toString().trim().isNotEmpty){
                                setState(() {
                                  isUsernameEmpty = false;
                                });
                              }

                              if(username.toString().trim().length < 8){
                                setState(() {
                                  isUsernameEmpty = true;
                                  userNameError = "UserName length must be greater than 8";
                                });
                                return;
                              } else {
                                setState(() {
                                  isUsernameEmpty = false;
                                  userNameError = "Username can't be empty";
                                });
                              }


                              if(!Utilities.validateStructure(username)){
                                setState(() {
                                  isUsernameEmpty = true;
                                  userNameError = "UserId must contain combination of alphabets and number";
                                });
                                return;
                              } else {
                                setState(() {
                                  isUsernameEmpty = false;
                                  userNameError = "Username can't be empty";
                                });
                              }
                              checkUserName(username);

                            },
                            controller: usernameController,
                            decoration: InputDecoration(
                              hintText: "Login ID",
                              filled: false,
                              errorMaxLines: 2,
                              errorText: isUsernameEmpty ? userNameError : null,
                              suffix: isUsernameFind ? Container(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2,)) : SizedBox.shrink(),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: visible,
                            focusNode: passwordFocus,
                            controller: passwordController,
                            onSubmitted: (text){
                              this.passwordFocus.unfocus();
                            },
                            onChanged: (text){
                              setState(() {
                                isPasswordEmpty = false;
                              });
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
                              errorText: isPasswordEmpty ? "Can\'t be Empty" : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: isTaped ?() =>registerPatient():null,
                        child: Text(
                          buttonText,
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
                    SizedBox(height: 8,),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(text: "Already a member? ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Login",
                                style: TextStyle(fontWeight: FontWeight.w600, color: MyColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(context, "/login");
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


  Future<void> registerPatient() async {
    disableButton();

    String name = nameController.text.toString().trim();
    String phone = phoneController.text.toString().trim();
    String username = usernameController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    nameFocus.unfocus();
    phoneFocus.unfocus();
    usernameFocus.unfocus();
    passwordFocus.unfocus();


    if (!await Utilities.isOnline()){
      enableButton();
      Utilities.internetNotAvailable(context);
      return;
    }
    if (name.isEmpty){
      enableButton();
      setState(() {
        isNameEmpty = true;
      });
      return;
    }

    if (phone.isEmpty){
      enableButton();
      setState(() {
        isPhoneEmpty = true;
      });
      return;
    }

    if (username.isEmpty || isUsernameEmpty){
      enableButton();
      setState(() {
        isUsernameEmpty = true;
      });
      return;
    }



    if (password.isEmpty) {
      enableButton();
      setState(() {
        isPasswordEmpty = true;
      });
      return;
    }

    Loading.build(context, false);

    String values = "&DateOfBirth=&salutation=" +
        "&Gender=&area=&city=&cnic=&Username=$username&height=&weight=" +
        "&profession=&Password=$password&Type=Patient&Name=$name&Phone=$phone&Email=";

    String response = await Utilities.httpPost(ServerConfig.signUp + values);
    Loading.dismiss();

    if (response != "404") {

      User user = loginFromJson(response).response.user;

      preferences.setString(Keys.username, user.username);
      preferences.setString(Keys.phone, user.phone);
      preferences.setString(Keys.name, user.name);
      preferences.setString(Keys.password, password);
      preferences.setBool(Keys.status, true);

      Route route = new MaterialPageRoute(builder: (context) => LocationGettingScreen(false));
      Navigator.pushAndRemoveUntil(context, route, (route) => false);

    } else {
      Utilities.showToast("Unable to create account, try again later.");
    }
    enableButton();
  }

  Future<void> checkUserName(String username) async {
    setState(() {
      isUsernameFind = true;
    });
    String response = await Utilities.httpGet(ServerConfig.check_username + "&Username=$username");
    setState(() {
      isUsernameFind = false;
    });
    print(response);
    if (response != "404"){
      if (jsonDecode(response)["Response"]["Response"] == true){
        setState(() {
          userNameError = "Username already exists";
          isUsernameEmpty = true;
        });
      } else {
        setState(() {
          userNameError = "Username can't be empty";
          isUsernameEmpty = false;
        });
      }
    }
  }

  @override
  void initState() {
    updateUi();
    super.initState();
  }

  void updateUi() async{
    preferences = await SharedPreferences.getInstance();
  }


  void disableButton() {
    setState(() {
      isTaped = false;
      buttonText = "Please Wait...";
    });
  }

  void enableButton() {
    setState(() {
      isTaped = true;
      buttonText = "Create Account";
    });
  }
}
