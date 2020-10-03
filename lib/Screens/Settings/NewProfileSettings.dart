import 'dart:io';

import 'package:amc/Models/ProfileModel.dart';
import 'package:amc/Screens/AccountCreation/LocationGettingScreen.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettings extends StatefulWidget {
  final List<String> cities;
  final Profile profile;

  const ProfileSettings({Key key, this.profile, this.cities}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState(this.profile);
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final Profile profile;

  final _picker = ImagePicker();
  String title, imagePath;

  final FocusNode nameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  final nameController = new TextEditingController();
  final usernameController = new TextEditingController();
  final phoneController = new TextEditingController();
  final passwordController = new TextEditingController();
  final emailController = new TextEditingController();
  final areaController = new TextEditingController();
  final cityController = new TextEditingController();
  final addressController = new TextEditingController();
  var isTitleEmpty = true;
  var isNameEmpty = false;
  var isUsernameEmpty = false;
  var isPhoneEmpty = false;
  bool emailValidate = false;

  File _file;
  var isLoading = false;

  double uploadingValue = 0.0;
  bool isTaped = true;
  String saveAndNext = "Save & Next";
  String saveButton = "Save";
  String emailErrorMessage = "invalid email format";

  _ProfileSettingsState(this.profile);

  @override
  Widget build(BuildContext context) {
    return profile != null
        ? SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Align(
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
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      chooseAction();
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 8, bottom: 16),
                        child: Badge(
                          badgeContent: Icon(
                            Icons.camera,
                            size: 24,
                            color: MyColors.primary,
                          ),
                          padding: EdgeInsets.all(1),
                          badgeColor: Colors.white,
                          elevation: 0,
                          position:
                              BadgePosition.bottomRight(bottom: 0, right: 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            child: Container(
                                child: FadeInImage.assetNetwork(
                              placeholder: MyImages.user,
                              image: imagePath ?? "notfound",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            )),
                          ),
                        )),
                  ),
                  isLoading
                      ? Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: LinearPercentIndicator(
                            lineHeight: 18.0,
                            percent: uploadingValue,
                            center: Text(
                              "${(uploadingValue * 100).toInt()} %",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: MyColors.primary,
                          ),
                        )
                      : SizedBox(
                          height: 4,
                        ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.01, 0.01],
                                colors: [Color(0XFF17145A), Colors.white]),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isExpanded: true,
                                autofocus: isTitleEmpty,
                                value: title,
                                hint: Text("Title", maxLines: 1,),
                                onChanged: (String value) {
                                  setState(() {
                                    title = value;
                                    isTitleEmpty = false;
                                  });
                                },
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Light",
                                  color: Colors.black,
                                ),
                                items: Keys.titleList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          maxLength: 35,
                          textInputAction: TextInputAction.next,
                          focusNode: nameFocus,
                          inputFormatters: [Utilities.onlyTextFormat()],
                          onSubmitted: (text) {
                            this.nameFocus.unfocus();
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
                            errorText:
                                isNameEmpty ? "Name can't be Empty" : null,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    textInputAction: TextInputAction.next,
                    focusNode: usernameFocus,
                    controller: usernameController,
                    decoration: InputDecoration(
                      filled: false,
                      enabled: false,
                      fillColor: Colors.white,
                      hintText: "Login ID",
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                      )
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    textInputAction: TextInputAction.next,
                    focusNode: phoneFocus,
                    inputFormatters: [Utilities.onlyNumberFormat()],
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    onSubmitted: (text) {
                      this.phoneFocus.unfocus();
                      FocusScope.of(context).nextFocus();
                    },
                    onChanged: (phone) {
                      if (phone.toString().trim().isNotEmpty) {
                        setState(() {
                          isPhoneEmpty = false;
                        });
                      }
                    },
                    controller: phoneController,
                    decoration: InputDecoration(
                      filled: false,
                      fillColor: Colors.white,
                      hintText: "Phone",
                      counterText: "",
                      errorText: isPhoneEmpty ? "Phone can't be Empty" : null,
                    ),
                  ),
                  SizedBox(
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
                      if (text.trim().isEmpty) {
                        setState(() {
                          setState(() {
                            emailValidate = false;
                          });
                        });
                      }
                      bool validate = EmailValidator.validate(text);
                      if (validate) {
                        setState(() {
                          emailValidate = false;
                        });
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
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    flex: 0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: isTaped
                                  ? () => updateInfoTask(true)
                                  : null,
                              child: Text(
                                saveButton,
                              ),
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: isTaped
                                  ? () => updateInfoTask(false)
                                  : null,
                              child: Text(
                                saveAndNext,
                              ),
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }

  void updateUi() {
    if (profile != null) {
      String title;
      if (profile.user.title != null) {
        title = profile.user.title.isNotEmpty && profile.user.title != "null"
            ? profile.user.title : null;
      }
      imagePath = profile.user.imagePath;
      String name = profile.user.name;
      String username = profile.user.username;
      String phone = profile.user.phone ?? "";
      String email = profile.user.email ?? "";
      String area = profile.address.area ?? "";
      String city = profile.address.city ?? "";
      String address = profile.address.location ?? "";

      this.title = title;
      nameController.text = name;
      usernameController.text = username;
      phoneController.text = phone;
      emailController.text = email;
      areaController.text = area;
      cityController.text = city;
      addressController.text = address;
    }
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
                          margin: EdgeInsets.all(0),
                          elevation: 0,
                          color: Colors.grey.shade200,
                          child: InkWell(
                            onTap: () async {
                              var image = await _picker.getImage(
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
                                children: <Widget>[
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
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.all(0),
                          color: Colors.grey.shade200,
                          child: InkWell(
                            onTap: () async {
                              var image = await _picker.getImage(
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
                                children: <Widget>[
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
                FlatButton(
                    textColor: MyColors.primary,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Dismiss"))
              ],
            ));
  }

  void uploadImage(File file) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.username);

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
        print(response.data);
        imagePath = response.data["Response"]["Response"];
      });
    } else {
      Utilities.showToast("Please try again later");
    }
  }

  void updateInfoTask(bool buttonValue) async {
    disableButton();

    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable(context);
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

    String username = preferences.getString(Keys.username);

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
        isPhoneEmpty = true;
      });
      enableButton();
      return;
    }

    if (email.isEmpty) {
      setState(() {
        emailValidate = true;
        emailErrorMessage = "Email Required";
      });
      enableButton();
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

    String values = "&Username=$username" +
        "&Title=$title" +
        "&Name=$name" +
        "&Phone=$phone" +
        "&Email=$email" +
        "&City=$city" +
        "&Area=$area" +
        "&Location=$address" +
        "&ImagePath=$imagePath";

    String response =
        await Utilities.httpGet(ServerConfig.patientInfoUpdate + values);
    Loading.dismiss();

    if (response != "404") {
      preferences.setString(Keys.image, imagePath ?? "");
      preferences.setString(Keys.phone, phone);
      preferences.setString(Keys.name, name);
      preferences.setString(Keys.email, email ?? "");
      preferences.setString(Keys.city, city ?? "");
      preferences.setString(Keys.area, area ?? "");
      preferences.setString(Keys.address, address ?? "");
      preferences.setString(Keys.title, title ?? "");
      buttonValue
          ? Navigator.of(context).pushReplacementNamed('/home')
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationGettingScreen(true),
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
