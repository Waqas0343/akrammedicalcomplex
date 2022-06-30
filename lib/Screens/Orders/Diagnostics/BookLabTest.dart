import 'dart:convert';
import 'dart:io';

import 'package:amc/models/image_model.dart';
import 'package:amc/models/lab_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/models/test_search_model.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/Screens/Bookings/ThankYouScreen.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookLabTest extends StatefulWidget {
  final bool isPrescription;

  const BookLabTest(this.isPrescription, {Key key}) : super(key: key);


  @override
  _BookLabTestState createState() => _BookLabTestState();
}

class _BookLabTestState extends State<BookLabTest> {
  File file;
  String prescriptionPath, username;

  List<Test> chooseTest = [];
  List<Lab> labs = [];

  final _picker = ImagePicker();

  Lab lab;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final medicController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode locaFocus = FocusNode();
  String phoneError = "Phone can't be Empty";
  bool isNameEmpty = false;
  bool isPhoneEmpty = false;
  bool isLocationEmpty = false;
  bool isLoading = true;
  bool isTaped = true;
  bool emailValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              labView(),
              const SizedBox(
                height: 8,
              ),
              lab != null ? selectTest() : const SizedBox.shrink(),
              testList(),
              imageViewLayout(),
              uploadPrescriptionActions(),
              bookingDetails(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: isTaped ? () => placeOrder() : null,
                  child: const Text("Place Order"),
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
            height: 200,
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
                    file,
                  ),
                )),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.topRight,
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        file = null;
                        isLoading = true;
                      });
                    },
                  ),
                ),
                isLoading
                    ? const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: LinearProgressIndicator(),
                        ))
                    : const SizedBox.shrink(),
              ],
            ))
        : const SizedBox.shrink();
  }

  Widget uploadPrescriptionActions() {
    return widget.isPrescription && file == null
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
                    uploadImage(file);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const <Widget>[
                      Icon(
                        Icons.camera,
                        size: 38,
                        color: MyColors.accent,
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
                    uploadImage(file);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const <Widget>[
                      Icon(
                        Icons.image,
                        size: 38,
                        color: MyColors.accent,
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
        const Padding(
          padding: EdgeInsets.all(14.0),
          child: Text(
            "Booking Details",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
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
          inputFormatters: [
            Utilities.onlyNumberFormat(),
          ],
          controller: phoneController,
          maxLength: 11,
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
          onChanged: (String text) {
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
          decoration: const InputDecoration(
              filled: true, fillColor: Colors.white, hintText: "Email"),
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
    return !widget.isPrescription
        ? Card(
            elevation: 2,
            margin: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: medicController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: "Search LabTest")),
                    suggestionsCallback: (name) async {
                      return await searchTest(name.isNotEmpty ? name : "a");
                    },
                    noItemsFoundBuilder: (context) {
                      return const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text(
                          "No Test Found.",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    },
                    itemBuilder: (context, Test suggestion) {
                      return ListTile(
                        dense: true,
                        subtitle: Text(suggestion.fee),
                        title: AutoSizeText(
                          suggestion.testName,
                          maxLines: 1,
                        ),
                      );
                    },
                    onSuggestionSelected: (Test suggestion) {
                      setState(() {
                        medicController.clear();
                        chooseTest.add(suggestion);
                      });
                    }),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  Widget testList() {
    return chooseTest.isNotEmpty
        ? Card(
            margin: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  dense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  title: AutoSizeText(
                    chooseTest[index].testName,
                    maxLines: 1,
                  ),
                  subtitle: Text(chooseTest[index].fee),
                  trailing: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          chooseTest.removeAt(index);
                        });
                      }),
                  leading: SizedBox(
                      width: 30,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ))),
                );
              },
              itemCount: chooseTest.length,
            ),
          )
        : const SizedBox.shrink();
  }

  Future<List<Test>> searchTest(String name) async {
    String response = await Utilities.httpGet(ServerConfig.searchTest +
        "&q=$name&pageLimit=15&page=0&labid=${lab.username}");
    List<Test> list = [];
    if (response != "404") {
      list = searchLabTestModelFromJson(response).response.response.testsList;
    }
    return list;
  }

  void uploadImage(File file) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.USERNAME);

    Dio dio = Dio();

    FormData imageFormData = FormData.fromMap({
      "Systemkey": ServerConfig.systemKey,
      "userid": username,
      "file": await MultipartFile.fromFile(file.path, filename: 'file.jpg'),
    });

    var response =
        await dio.post(ServerConfig.uploadImages, data: imageFormData);

    if (response.statusCode == 200) {
      prescriptionPath = imageModelFromJson(response.toString()).response.path;
    } else {
      Utilities.showToast("Unable to upload Prescription");
    }

    setState(() {
      isLoading = false;
    });
  }

  void getPrefrences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString(Keys.USERNAME);
    nameController.text = preferences.getString(Keys.name);
    phoneController.text = preferences.getString(Keys.phone);
    emailController.text = preferences.getString(Keys.email);
    locationController.text = preferences.getString(Keys.address);
  }

  Widget labView() {
    return labs.isNotEmpty
        ? Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.01, 0.01],
                  colors: [MyColors.primary, Colors.white]),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 16),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: const Text("Select Lab"),
                    isExpanded: true,
                    value: lab,
                    items: labs.map((e) {
                      return DropdownMenuItem(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          dense: true,
                          title: Text(e.name),
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                e.imagePath,
                                width: 32,
                                height: 32,
                              )),
                          subtitle:
                              Text("Available Tests (${e.testsAvailable})"),
                        ),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (lab) {
                      setState(() {
                        chooseTest.clear();
                        this.lab = lab;
                      });
                    }),
              ),
            ),
          )
        : const CircularProgressIndicator();
  }

  @override
  void initState() {
    super.initState();
    getPrefrences();
    getLab();
  }

  Future<void> getLab() async {
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable(context);
      return;
    }

    String response = await Utilities.httpGet(ServerConfig.labs);
    if (response != "404") {
      var list = labModelFromJson(response);
      setState(() {
        labs.addAll(list.response.labs);
        lab = labs[0];
      });
    } else {
      Utilities.showToast("Unable to get Labs, try again latter");
    }
  }

  void placeOrder() async {
    disableButton();

    SharedPreferences preferences = await SharedPreferences.getInstance();

    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String location = locationController.text.trim();
    String username = preferences.getString(Keys.USERNAME);
    String testString;

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

    if (location.isEmpty) {
      enableButton();
      setState(() {
        isLocationEmpty = true;
      });
      return;
    }
    if (widget.isPrescription) {
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
      if (chooseTest.isEmpty) {
        enableButton();
        Utilities.showToast(
            "Please search and select Test(s) from provided list");
        return;
      }

      // medicines ki list ko json list mein convert karna hai...
      testString =
          jsonEncode(List<dynamic>.from(chooseTest.map((x) => x.toJson())))
              .replaceAll("'", "");
    }

    Loading.build(context, false);
    if (!await Utilities.isOnline()) {
      enableButton();
      Navigator.pop(context);
      Utilities.internetNotAvailable(context);
      return;
    }

    FormData formData = FormData.fromMap({
      "OrderList": testString,
    });

    String values = "&LabId=${lab.username}&Name=$name&username=$username"
        "&Location=$location&Phone=$phone&Email=$email&Area=&City="
        "&SessionToken=&RefferedBy=&fetchtype=mobile&attachment=$prescriptionPath&Amount=";


    Dio dio = Dio();

    Response response;
    try {
      response =
          await dio.post(ServerConfig.labTestBook + values, data: formData);
    } catch (e) {
      print(e);
    }

    Loading.dismiss();
    if (response == null) {
      enableButton();
      Utilities.showToast("Something went wrong");
      return;
    }

    if (response.statusCode == 200) {
      enableButton();
      Route route = MaterialPageRoute(builder: (_) => ThankYouScreen());
      await Navigator.of(context).push(route);
    } else {
      enableButton();
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
