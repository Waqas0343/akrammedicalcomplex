import 'package:amc/models/login_model.dart';
import 'package:amc/Screens/account_creation/ActivationCode.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/routes/routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/loading_spinner.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var isNameEmpty = false;
  var isUsernameEmpty = false;
  var isPhoneEmpty = false;
  var isPasswordEmpty = false;
  var isEmailValidate = false;

  String userNameError = "Username can't be empty";
  String phoneError = "Phone can't be Empty";
  String emailErrorMessage = "invalid email format";

  late SharedPreferences preferences;
  bool visible = true;

  bool isTaped = true;
  String buttonText = "Create Account";

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
              ClipOval(
                child: Image.asset(
                  MyImages.logo,
                  height: 160.0,
                ),
              ),
              Column(
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
                            "Register",
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
                            focusNode: nameFocus,
                            controller: nameController,
                            inputFormatters: [Utilities.onlyTextFormat()],
                            onChanged: (text) {
                              if (text.isNotEmpty) {
                                setState(() {
                                  isNameEmpty = false;
                                });
                              }
                            },
                            onSubmitted: (text) {
                              nameFocus.unfocus();
                              FocusScope.of(context).requestFocus(phoneFocus);
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: "Full Name",
                              errorText: isNameEmpty ? "Can't be Empty" : null,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            inputFormatters: [
                              Utilities.onlyNumberFormat(),
                            ],
                            textInputAction: TextInputAction.next,
                            focusNode: phoneFocus,
                            controller: phoneController,
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
                          // Login ID
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            // textInputAction: TextInputAction.values,
                            focusNode: emailFocus,
                            controller: emailController,
                            onChanged: (text) {
                              if (text.isNotEmpty) {
                                if (EmailValidator.validate(text)) {
                                  setState(() {
                                    isEmailValidate = false;
                                  });
                                }
                              }
                            },
                            onSubmitted: (text) {
                              emailFocus.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(emailFocus);
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              filled: false,
                              counterText: "",

                              errorText: isEmailValidate ? emailErrorMessage : null,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: isTaped ? () => registerPatient() : null,
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Already a member? ",
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: "Login",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                   Get.toNamed(AppRoutes.login);
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

  Future<void> registerPatient() async {
    disableButton();
    String name = nameController.text.toString().trim();
    String phone = phoneController.text.toString().trim();
    String email = emailController.text.toString().trim();
    nameFocus.unfocus();
    phoneFocus.unfocus();
    emailFocus.unfocus();


    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable(context);
      return;
    }
    if (name.isEmpty) {
      enableButton();
      setState(() {
        isNameEmpty = true;
      });
      return;
    }

    if (phone.isEmpty) {
      enableButton();
      setState(() {
        isPhoneEmpty = true;
      });
      return;
    } else if (!Utilities.numberHasValid(phone)) {
      enableButton();
      setState(() {
        isPhoneEmpty = true;
        phoneError = "Invalid phone number";
      });
      return;
    }

    if (email.isEmpty) {
      bool validate = EmailValidator.validate(email);
      if (!validate) {
        setState(() {
          isEmailValidate = true;
          emailErrorMessage = "Enter email in format";
        });
        enableButton();
        return;
      }
    }

    Get.dialog(const LoadingSpinner());
    String values = "&Type=Patient&Name=$name&Phone=$phone&Email=$email";
    String response = await Utilities.httpPost(ServerConfig.signUp + values);
    print(response);
    Loading.dismiss();
    if (response != "404") {
      User user = loginFromJson(response).response!.user!;
      preferences.setString(Keys.phone, user.phone!);
      preferences.setString(Keys.otp, user.otpCode.toString());
      preferences.setString(Keys.email, user.email!);
      preferences.setString(Keys.name, user.name!);
      Get.to(() => AccountActivation(
          user.phone,user.otpCode.toString(),userList: null, isLogin:false
      ));
      // Route route = MaterialPageRoute(
      //     builder: (context) => AccountActivation(
      //           user.phone,user.otpCode.toString(),userList: null, isLogin:false
      //         ));
      // Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {
      Utilities.showToast("Unable to create account, try again later.");
    }
    enableButton();
  }

  // Future<void> checkUserName(String username) async {
  //   setState(() {
  //     isUsernameFind = true;
  //   });
  //   String response = await Utilities.httpGet(
  //       ServerConfig.checkUsername + "&email=$username");
  //   setState(() {
  //     isUsernameFind = false;
  //   });
  //   if (response != "404") {
  //     if (jsonDecode(response)["Response"]["Response"] == true) {
  //       setState(() {
  //         userNameError = "Username already exists";
  //         isUsernameEmpty = true;
  //       });
  //     } else {
  //       setState(() {
  //         userNameError = "Username can't be empty";
  //         isUsernameEmpty = false;
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    updateUi();
    super.initState();
  }

  void updateUi() async {
    preferences = await SharedPreferences.getInstance();
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
