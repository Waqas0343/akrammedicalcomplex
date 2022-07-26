import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Styles/Keys.dart';
import '../Styles/MyColors.dart';
import '../Styles/MyImages.dart';
import '../Widgets/text_format.dart';
import '../controllers/users/login/login_controller.dart';
import '../routes/routes.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
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
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: Get.textTheme.headlineSmall?.copyWith(
                          color: Get.theme.primaryColor,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Form(
                        key: loginController.formKey,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          maxLength: 11,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (text) => Get.focusScope!.unfocus(),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return 'Can\'t be Empty';
                            } else if (!GetUtils.hasMatch(
                                text, MyTextFormats.validNumber.pattern)) {
                              return "Phone ${Keys.onlyNumbers}";
                            } else if (!GetUtils.hasMatch(
                                text, MyTextFormats.phonePattern.pattern)) {
                              return 'Invalid number';
                            }
                            return null;
                          },
                          onSaved: (text) => loginController.phone = text,
                          decoration: const InputDecoration(
                            hintText: "Phone",
                            counterText: "",
                            filled: false,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: loginController.login,
                        child: Text(
                          "Login",
                          style: Get.textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
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
                        style: Get.textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Get Registered",
                            style: Get.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: MyColors.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed(AppRoutes.signUp);
                              },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Smart Hospital App by ",
                      style: Get.textTheme.subtitle1?.copyWith(
                        fontSize: 16.0,
                      ),
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
