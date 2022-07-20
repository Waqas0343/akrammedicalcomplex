import 'dart:async';
import 'dart:convert';
import 'package:amc/Screens/account_creation/LocationGettingScreen.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/loading_spinner.dart';
import '../../models/otp_model.dart';
import '../accounts/user_accounts.dart';

class AccountActivation extends StatefulWidget {
  final String? phoneNumber, otpCode;
  final OTPResponse? userList;
  final bool isLogin;

  const AccountActivation(this.phoneNumber, this.otpCode,
      {Key? key, required this.userList, required this.isLogin})
      : super(key: key);

  @override
  _AccountActivationState createState() => _AccountActivationState();
}

class _AccountActivationState extends State<AccountActivation> {
  TextEditingController textEditingController = TextEditingController();
  late SharedPreferences preferences;
  String? username;
  bool isTaped = true;
  String buttonText = "Verify";
  StreamController<ErrorAnimationType>? errorController;
  late Timer _timer;
  int _start = 60;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getPreferences();
    startTimer();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Phone Number Verification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
                            text: widget.phoneNumber,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 15)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
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
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        onCompleted: (v) {
                          if (currentText.length == 6) {
                            verify(currentText);
                          }
                          setState(() {
                            hasError = false;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
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
                    hasError ? "Please enter valid verification code" : "",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Didn't receive the code? ",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                      children: [
                        TextSpan(
                            text: _timer.isActive ? ' $_start s' : " RESEND",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => reSend(),
                            style: TextStyle(
                                color: _timer.isActive
                                    ? Colors.black54
                                    : Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ]),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isTaped
                          ? () {
                              if (currentText.length == 6) {
                                verify(currentText);
                              } else {
                                setState(() {
                                  hasError = true;
                                });
                                errorController!.add(ErrorAnimationType
                                    .shake); // Triggering error shake animation
                              }
                            }
                          : null,
                      child: Center(
                        child: Text(
                          buttonText.toUpperCase(),
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
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void reSend() async {
    if (widget.otpCode == currentText) {
      Route route = MaterialPageRoute(
          builder: (context) => const LocationGettingScreen(false));
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    }
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable(context);
      return;
    }

    if (_timer.isActive) {
      return;
    } else {
      _timer.cancel();
      startTimer();
      _start = 60;
      setState(() {});
    }

    String response = await Utilities.httpPost(
        ServerConfig.resendCode + '&phone=${widget.phoneNumber}');
    if (response != "404") {
      if (jsonDecode(response)["Response"]["Response"] == "Success") {
        enableButton();
        if (kDebugMode) {
          print("Pin code has been sent");
        }
      } else {
        Utilities.showToast("Unable to send");
      }
    } else {
      Utilities.showToast("Unable to send");
    }
    enableButton();
  }

  void verify(String code) async {
    disableButton();
    if (widget.isLogin == true) {
      Get.dialog(const LoadingSpinner());
      Get.to(()=> UserAccounts(list: widget.userList),);
    } else if (widget.isLogin == false) {
      Get.to(()=> const LocationGettingScreen(false));
    }
    disableButton();
    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable(context);
      return;
    }
    Loading.build(context, false);
    Loading.dismiss();
    enableButton();
  }

  void getPreferences() async {
    preferences = await SharedPreferences.getInstance();
    username = preferences.getString(Keys.USERNAME);
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
