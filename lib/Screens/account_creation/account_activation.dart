import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../controllers/users/account_activation/account_activation_controller.dart';

class AccountActivation extends StatelessWidget {
  const AccountActivation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountActivationController());
    return Scaffold(
      backgroundColor: Colors.white,
      key: controller.scaffoldKey,
      body: GestureDetector(
        onTap: () {
          Get.focusScope?.unfocus();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: const FlareActor(
                  "assets/animation/otp.flr",
                  animation: "otp",
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Phone Number Verification',
                  style: Get.textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                    text: "Enter the code sent to ",
                    children: [
                      TextSpan(
                        text: controller.userPhoneNo,
                        style: Get.textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                    style: Get.textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: controller.formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 80),
                    child: PinCodeTextField(
                      keyboardType: TextInputType.number,
                      length: 6,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 30,
                      ),
                      animationDuration: const Duration(milliseconds: 100),
                      errorAnimationController: controller.errorController,
                      controller: controller.textEditingController,
                      onCompleted: (v) {
                        if (controller.currentText.length == 6) {
                          controller.verifyCode();
                        }
                      },
                      onChanged: (value) {
                        controller.currentText = value;
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  controller.hasError
                      ? "Please enter valid verification code"
                      : "",
                  style: Get.textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Didn't receive the code? ",
                      style: Get.textTheme.subtitle1?.copyWith(
                        color: Colors.black54,
                        fontSize: 15.0,
                      ),
                      children: [
                        TextSpan(
                          text: controller.isActive
                              ? ' ${controller.start} s'
                              : " RESEND",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => controller.reSend(),
                          style: Get.textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: controller.isActive
                                ? Colors.black54
                                : Colors.blue,
                            fontSize: 16.0,
                          ),
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.currentText.length == 6) {
                        controller.verifyCode();
                      }
                    },
                    child: Center(
                      child: Text(
                        controller.buttonText.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
