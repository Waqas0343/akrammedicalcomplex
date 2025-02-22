import 'dart:io';

import 'package:amc/Screens/account_creation/LocationGettingScreen.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/models/profile_model.dart';
import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettings extends StatefulWidget {
  final Profile profile;

  const ProfileSettings({Key? key, required this.profile}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _picker = ImagePicker();
  String? title, imagePath;

  final FocusNode nameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  var isTitleEmpty = true;
  var isNameEmpty = false;
  var isUsernameEmpty = false;
  var isPhoneEmpty = false;
  bool emailValidate = false;

  late File _file;
  var isLoading = false;
  String phoneError = "Phone can't be Empty";
  double uploadingValue = 0.0;
  bool isTaped = true;
  String buttonText = "Save & Next";
  String emailErrorMessage = "invalid email format";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Basic Information",
              style: TextStyle(
                height: 1.5,
                fontWeight: FontWeight.bold,
                color: MyColors.primary,
                fontSize: 28.0,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: chooseAction,
            child: Container(
              margin: const EdgeInsets.only(
                top: 8,
                bottom: 16,
              ),
              child: Badge(
                badgeContent: const Icon(
                  Icons.camera,
                  size: 24,
                  color: MyColors.primary,
                ),
                padding: const EdgeInsets.all(1),
                badgeColor: Colors.white,
                elevation: 0,
                position: BadgePosition.bottomEnd(bottom: 0, end: 0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: NetWorkImage(
                    placeHolder: MyImages.user,
                    imagePath: imagePath,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: LinearPercentIndicator(
                lineHeight: 18.0,
                percent: uploadingValue,
                center: Text(
                  "${(uploadingValue * 100).toInt()} %",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                barRadius: const Radius.circular(8),
                progressColor: MyColors.primary,
              ),
            ),
          DropdownButtonFormField(
            autofocus: isTitleEmpty,
            value: title,
            decoration: const InputDecoration(
              filled: false,
            ),
            items: Keys.titleList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                title = value;
                isTitleEmpty = false;
              });
            },
          ),
          const SizedBox(
            height: 8,
          ),

          TextField(
            maxLength: 35,
            textInputAction: TextInputAction.next,
            focusNode: nameFocus,
            onSubmitted: (text) {
              nameFocus.unfocus();
              FocusScope.of(context).requestFocus(phoneFocus);
            },
            onChanged: (name) {
              if (name.toString().trim().isNotEmpty) {
                setState(() {
                  isNameEmpty = false;
                });
              }
            },
            textCapitalization: TextCapitalization.words,
            controller: nameController,
            decoration: InputDecoration(
              counterText: "",
              filled: false,
              hintText: "Full Name",
              errorText: isNameEmpty ? "Name can't be Empty" : null,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            textInputAction: TextInputAction.next,
            focusNode: usernameFocus,
            controller: usernameController,
            decoration: const InputDecoration(
              filled: false,
              enabled: false,
              fillColor: Colors.white,
              hintText: "Login ID",
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            textInputAction: TextInputAction.next,
            focusNode: phoneFocus,
            inputFormatters: [
              Utilities.onlyNumberFormat(),
            ],
            keyboardType: TextInputType.phone,
            maxLength: 11,
            onSubmitted: (text) {
              phoneFocus.unfocus();
              FocusScope.of(context).nextFocus();
            },
            onChanged: (phone) {
              if (phone.toString().trim().isNotEmpty) {
                if (Utilities.numberHasValid(phone)) {
                  setState(() {
                    isPhoneEmpty = false;
                  });
                }
              }
            },
            controller: phoneController,
            decoration: InputDecoration(
              filled: false,
              fillColor: Colors.white,
              hintText: "Phone",
              counterText: "",
              errorText: isPhoneEmpty ? phoneError : null,
            ),
          ),
          const SizedBox(
            height: 8,
          ),

          // email
          TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            onSubmitted: (text) {
              emailFocus.unfocus();
              FocusScope.of(context).nextFocus();
            },
            onChanged: (text) {
              if (text.trim().isNotEmpty) {
                bool validate = EmailValidator.validate(text);
                if (validate) {
                  setState(() {
                    emailValidate = false;
                  });
                }
              }
            },
            focusNode: emailFocus,
            decoration: InputDecoration(
              filled: false,
              fillColor: Colors.white,
              hintText: "Email",
              errorText: emailValidate ? emailErrorMessage : null,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: isTaped ? () => updateInfoTask() : null,
              child: Text(
                buttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateUi() {
    String? title;
    if (widget.profile.user!.title != null) {
      title = widget.profile.user!.title!.isNotEmpty &&
              widget.profile.user!.title != "null"
          ? widget.profile.user!.title!.replaceAll(".", "")
          : null;
    }
    imagePath = widget.profile.user!.imagePath;
    String name = widget.profile.user!.name!;
    String mrNo = widget.profile.mrNo;
    String phone = widget.profile.user!.phone ?? "";
    String email = widget.profile.user!.email ?? "";
    String area = widget.profile.address!.area ?? "";
    String city = widget.profile.address!.city ?? "";
    String address = widget.profile.address!.location ?? "";

    this.title = title;
    nameController.text = name;
    usernameController.text = mrNo;
    phoneController.text = phone;
    emailController.text = email;
    areaController.text = area;
    cityController.text = city;
    addressController.text = address;
  }

  @override
  void initState() {
    super.initState();
    updateUi();
    title != null ? isTitleEmpty = false : isTitleEmpty = true;
  }

  void chooseAction() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          elevation: 0,
                          color: Colors.grey.shade200,
                          child: InkWell(
                            onTap: () async {
                              var image = await _picker.pickImage(
                                  source: ImageSource.camera);
                              if (image != null) {
                                Navigator.pop(context);
                                setState(() {
                                  _file = File(image.path);
                                });
                                uploadImage(_file);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const <Widget>[
                                  Icon(
                                    Icons.camera,
                                    size: 38,
                                    color: MyColors.primary,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text("Camera")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: 0,
                          margin: const EdgeInsets.all(0),
                          color: Colors.grey.shade200,
                          child: InkWell(
                            onTap: () async {
                              var image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                Navigator.pop(context);
                                setState(() {
                                  _file = File(image.path);
                                });
                                uploadImage(_file);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const <Widget>[
                                  Icon(
                                    Icons.image,
                                    size: 38,
                                    color: MyColors.primary,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text("Gallery")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Dismiss"))
              ],
            ));
  }

  void uploadImage(File file) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString(Keys.username);

    setState(() {
      isLoading = true;
    });

    Dio dio = Dio();
    FormData imageFormData = FormData.fromMap({
      "Systemkey": ServerConfig.systemKey,
      "userid": username,
      "file": await MultipartFile.fromFile(file.path, filename: 'file.jpg'),
    });

    var response = await dio.post(
      ServerConfig.uploadImages,
      data: imageFormData,
      onSendProgress: (int sent, int total) {
        setState(() {
          uploadingValue = (sent / total);
        });
        print('progress: $uploadingValue');
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        imagePath = response.data["Response"]["Response"];
      });
    } else {
      Utilities.showToast("Please try again later");
    }
  }

  void updateInfoTask() async {
    disableButton();

    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable();
      return;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();

    nameFocus.unfocus();
    phoneFocus.unfocus();
    emailFocus.unfocus();

    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String area = areaController.text.trim();
    String city = cityController.text.trim();
    String address = addressController.text.trim();

    String? username = preferences.getString(Keys.username);

    if (title == null) {
      setState(() {
        isTitleEmpty = true;
      });
      enableButton();
      Utilities.showToast("Select title");
      return;
    }

    if (name.isEmpty) {
      setState(() {
        isNameEmpty = true;
      });
      enableButton();
      return;
    }

    if (phone.isEmpty) {
      setState(() {
        phoneError = "Phone can't be Empty";
        isPhoneEmpty = true;
      });
      enableButton();
      return;
    } else if (!Utilities.numberHasValid(phone)) {
      enableButton();
      setState(() {
        isPhoneEmpty = true;
        phoneError = "Invalid phone number";
      });
      return;
    }

    if (email.isNotEmpty) {
      bool validate = EmailValidator.validate(email);
      if (!validate) {
        setState(() {
          emailValidate = true;
          emailErrorMessage = "invalid email format";
        });
        enableButton();
        return;
      }
    }

    if (isLoading) {
      enableButton();
      Utilities.showToast("Image Uploading...");
      return;
    }

    Loading.build(context, true);

    String values = "&Username=$username"
        "&Title=$title"
        "&Name=$name"
        "&Phone=$phone"
        "&Email=$email"
        "&City=$city"
        "&Area=$area"
        "&Location=$address"
        "&ImagePath=$imagePath";

    String response =
        await Utilities.httpGet(ServerConfig.patientInfoUpdate + values);
    print(response);
    Loading.dismiss();

    if (response != "404") {
      preferences.setString(Keys.image, imagePath!);
      preferences.setString(Keys.phone, phone);
      preferences.setString(Keys.name, name);
      preferences.setString(Keys.email, email);
      preferences.setString(Keys.city, city);
      preferences.setString(Keys.area, area);
      preferences.setString(Keys.address, address);
      preferences.setString(Keys.title, title ?? "");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LocationGettingScreen(true),
        ),
      );
      Utilities.showToast("Update successfully");
    } else {
      Utilities.showToast("Something went wrong");
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
