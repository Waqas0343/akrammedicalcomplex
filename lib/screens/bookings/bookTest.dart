import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:amc/Screens/Bookings/ThankYouScreen.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/models/test_search_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookTest extends StatefulWidget {
  final bool? isPrescription;

  const BookTest({Key? key, this.isPrescription}) : super(key: key);

  @override
  _BookTestState createState() => _BookTestState();
}

class _BookTestState extends State<BookTest> {
  File? file;
  String? prescriptionPath, username;
  late SharedPreferences preferences;

  List<Test> chooseTestList = [];

  final _picker = ImagePicker();

  String title = "", hint = "", book = "", patientDetails = "";

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final medicController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode locaFocus = FocusNode();

  bool isNameEmpty = false;
  bool isPhoneEmpty = false;
  bool isLocationEmpty = false;
  bool isLoading = false;
  bool emailValidate = false;
  String phoneError = "Phone can't be Empty";
  double uploadingValue = 0.0;
  bool isTaped = true;
  String buttonText = "Place Order";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              selectTest(),
              testList(),
              imageViewLayout(),
              uploadPrescriptionActions(),
              bookingDetails(),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: isTaped ? () => placeOrder() : null,
                  child: Text(
                    buttonText,
                    // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget imageViewLayout() {
    return file != null
        ? SizedBox(
            height: 220,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10)
                    ]),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Image.file(
                      file!,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        file = null;
                        isLoading = false;
                        uploadingValue = 0.0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      color: Colors.grey.withOpacity(0.8),
                      child: const Icon(Icons.close),
                    ),
                  ),
                ),
                isLoading
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: LinearPercentIndicator(
                          lineHeight: 18.0,
                          percent: uploadingValue,
                          center: Text(
                            "${(uploadingValue * 100).toInt()} %",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          barRadius: const Radius.circular(8),
                          progressColor: MyColors.primary,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ))
        : const SizedBox.shrink();
  }

  Widget uploadPrescriptionActions() {
    return widget.isPrescription! && file == null
        ? Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Card(
                  margin: const EdgeInsets.all(0),
                  elevation: 2,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () async {
                      var image =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        setState(() {
                          file = File(image.path);
                        });
                        uploadImage(file!);
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
                  elevation: 2,
                  margin: const EdgeInsets.all(0),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () async {
                      var image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          file = File(image.path);
                        });
                        uploadImage(file!);
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
        : const SizedBox.shrink();
  }

  Widget bookingDetails() {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            patientDetails,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        TextField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: nameController,
          onSubmitted: (text) {
            nameFocus.unfocus();
            FocusScope.of(context).requestFocus(phoneFocus);
          },
          onChanged: (text) {
            if (text.trim().isNotEmpty) {
              setState(() {
                isNameEmpty = false;
              });
            }
          },
          focusNode: nameFocus,
          inputFormatters: [Utilities.onlyTextFormat()],
          decoration: InputDecoration(
            hintText: "Name",
            errorText: isNameEmpty ? "Required" : null,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          controller: phoneController,
          inputFormatters: [Utilities.onlyNumberFormat()],
          onSubmitted: (text) {
            phoneFocus.unfocus();
            FocusScope.of(context).requestFocus(emailFocus);
          },
          focusNode: phoneFocus,
          onChanged: (text) {
            if (text.trim().isNotEmpty) {
              if (Utilities.numberHasValid(text)) {
                setState(() {
                  isPhoneEmpty = false;
                });
              }
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Mobile No",
            counterText: "",
            errorText: isPhoneEmpty ? phoneError : null,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          onSubmitted: (text) {
            emailFocus.unfocus();
            FocusScope.of(context).requestFocus(locaFocus);
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
            filled: true,
            fillColor: Colors.white,
            hintText: "Email",
            errorText: emailValidate ? "invalid email format" : null,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          minLines: 3,
          maxLines: 5,
          controller: locationController,
          onChanged: (text) {
            if (text.trim().isNotEmpty) {
              setState(() {
                isLocationEmpty = false;
              });
            }
          },
          focusNode: locaFocus,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Ex: Location, Area, City",
            errorText: isLocationEmpty ? "Required" : null,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }

  Widget selectTest() {
    if (!widget.isPrescription!) {
      return Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: medicController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              hintText: "Search Lab Test",
            ),
          ),
          noItemsFoundBuilder: (context) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("No Test Found"),
            );
          },
          suggestionsCallback: searchTest,
          itemBuilder: (_, Test test) {
            return ListTile(
              dense: true,
              subtitle: Text(
                "PKR/- ${test.fee}",
              ),
              title: AutoSizeText(
                test.testName!,
                maxLines: 1,
              ),
            );
          },
          onSuggestionSelected: (Test suggestion) {
            setState(() {
              medicController.clear();
              chooseTestList.add(suggestion);
            });
          },
          keepSuggestionsOnLoading: false,
          hideSuggestionsOnKeyboardHide: false,
          debounceDuration: const Duration(
            milliseconds: 300,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget testList() {
    return chooseTestList.isNotEmpty
        ? Card(
            margin: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, int index) {
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  title: AutoSizeText(
                    chooseTestList[index].testName!,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    "PKR/- ${chooseTestList[index].fee}",
                  ),
                  trailing: IconButton(
                      color: Colors.red,
                      icon: const Icon(
                        Icons.cancel,
                      ),
                      onPressed: () {
                        setState(() {
                          chooseTestList.removeAt(index);
                        });
                      }),
                  leading: SizedBox(
                    width: 30,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              },
              itemCount: chooseTestList.length,
            ),
          )
        : const SizedBox.shrink();
  }

  Future<List<Test>> searchTest(String name) async {
    String response = await Utilities.httpGet(ServerConfig.searchTest +
        "&searchTest=$name&offset=0&nextFetch=10&labID=${Keys.labId}");
    if (response != "404") {
      return List<Test>.from(jsonDecode(response)['Response']['Response']
          .map((e) => Test.fromJson(e))
          .toList());
    }
    return <Test>[];
  }

  void uploadImage(File file) async {
    setState(() {
      isLoading = true;
    });
    Dio dio = Dio();

    FormData imageFormData = FormData.fromMap({
      "Systemkey": ServerConfig.systemKey,
      "userid": username,
      "file": await MultipartFile.fromFile(file.path, filename: 'file.jpg'),
    });

    Response? response;
    try {
      response = await dio.post(
        ServerConfig.uploadImages,
        data: imageFormData,
        onSendProgress: (int sent, int total) {
          setState(() {
            uploadingValue = (sent / total);
          });
          print('progress: $uploadingValue');
        },
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });

    if (response == null) {
      Utilities.showToast("Unable to upload Prescription");
      return;
    }

    if (response.statusCode == 200) {
      prescriptionPath = response.data["Response"]["Response"];
    } else {
      Utilities.showToast("Unable to upload Prescription");
    }
  }

  void getPreferences() async {
    preferences = await SharedPreferences.getInstance();
    username = preferences.getString(Keys.username);
    nameController.text = preferences.getString(Keys.name)!;
    phoneController.text = preferences.getString(Keys.phone)!;
    emailController.text = preferences.getString(Keys.email)!;
    locationController.text = preferences.getString(Keys.address)!;
  }

  @override
  void initState() {
    super.initState();
    title = "Order Details";
    hint = "Search LabTest";
    book = "Place Order";
    patientDetails = "Booking Details";

    getPreferences();
  }

  int get totalAmount => chooseTestList.fold(
      0,
      (previousValue, element) =>
          previousValue + (double.parse(element.discountedPrice!).round()));

  void placeOrder() async {
    disableButton();
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String location = locationController.text.trim();
    String? username = this.username;
    String? testString;

    nameFocus.unfocus();
    phoneFocus.unfocus();
    emailFocus.unfocus();
    locaFocus.unfocus();

    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable();
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

    if (email.isNotEmpty) {
      bool validate = EmailValidator.validate(email);
      if (!validate) {
        enableButton();
        setState(() {
          emailValidate = true;
        });
        return;
      }
    }

    if (location.isEmpty) {
      enableButton();
      setState(() {
        isLocationEmpty = true;
      });
      return;
    }

    if (widget.isPrescription!) {
      if (file == null) {
        enableButton();
        Utilities.showToast("Please Upload Prescription");
        return;
      } else {
        if (isLoading) {
          enableButton();
          Utilities.showToast("Image Uploading...");
          return;
        }
      }
    } else {
      if (chooseTestList.isEmpty) {
        enableButton();
        Utilities.showToast(
            "Please search and select Test(s) from provided list");
        return;
      }

      // medicines ki list ko json list mein convert karna hai...
      testString =
          jsonEncode(List<dynamic>.from(chooseTestList.map((x) => x.toJson())))
              .replaceAll("'", "");
    }

    Loading.build(context, true);
    FormData formData = FormData.fromMap({
      "OrderList": testString,
    });

    String values = "&LabId=${Keys.labId}&Name=$name&username=$username"
        "&Location=$location&Phone=$phone&Email=$email&Area=&City="
        "&SessionToken=&Source=${Keys.source}&attachment=$prescriptionPath&Amount=$totalAmount&projectID=${Keys.projectId}&locationID=${Keys.locationId}"
        "&RefferedBy=${Keys.locationId}";

    Dio dio = Dio();
    Response? response;
    try {
      debugPrint(ServerConfig.bookLabTest + values);
      response =
          await dio.post(ServerConfig.bookLabTest + values, data: formData);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    Loading.dismiss();
    if (response == null) {
      enableButton();
      Utilities.showToast("Something went wrong");
      return;
    }

    if (response.statusCode == 200) {
      Route route = MaterialPageRoute(builder: (_) => const ThankYouScreen());
      Navigator.of(context).push(route);
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
