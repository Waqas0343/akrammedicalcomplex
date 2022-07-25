import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Styles/Keys.dart';
import '../Styles/MyColors.dart';
import '../Styles/MyImages.dart';
import '../Utilities/Utilities.dart';
import '../Widgets/text_format.dart';
import '../controllers/users/register/signup_controller.dart';
import '../routes/routes.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
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
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: Get.textTheme.subtitle1?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: MyColors.primary,
                                fontSize: 24.0,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onSaved: (text) => controller.name = text,
                              validator: (text) {
                                if (text!.trim().isEmpty) {
                                  return "Can't be empty";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Full Name',
                                counterText: "",
                                filled: false,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.phone,
                              maxLength: 11,
                              inputFormatters: [
                                Utilities.onlyNumberFormat(),
                              ],
                              textInputAction: TextInputAction.next,
                              onSaved: (text) => controller.phone = text,
                              validator: (text) {
                                if (text!.trim().isEmpty) {
                                  return "Can't be empty";
                                } else if (!GetUtils.hasMatch(
                                    text, MyTextFormats.validNumber.pattern)) {
                                  return "Phone ${Keys.onlyNumbers}";
                                } else if (!MyTextFormats.phoneHasValid(text)) {
                                  return "Invalid phone number";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                counterText: "",
                                filled: false,
                                labelText: 'Phone',
                                hintText: "e.g 03XXXXXXXXX",
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // Login ID
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (text) => controller.email = text,
                              validator: (text) {
                                if (text!.trim().isEmpty) {
                                  return "Can't be empty";
                                } else if (text.isEmpty) {
                                  return null;
                                } else if (text.isNotEmpty &&
                                    !GetUtils.hasMatch(text,
                                        MyTextFormats.validEmail.pattern)) {
                                  return "Invalid Email";
                                } else if (!GetUtils.isEmail(text)) {
                                  return "Invalid Email";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                counterText: "",
                                filled: false,
                                labelText: 'Email',
                                hintText: "e.g 03XXXXXXXXX",
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
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
                        onPressed: controller.registerPatient,
                        child: Text(
                          "Create Account",
                          style: Get.textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
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
                          style: Get.textTheme.subtitle1?.copyWith(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: "Login",
                                style: Get.textTheme.subtitle1?.copyWith(
                                  color: MyColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
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
}
