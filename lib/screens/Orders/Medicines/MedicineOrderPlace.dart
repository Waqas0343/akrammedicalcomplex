import 'dart:convert';
import 'dart:io';

import 'package:amc/Screens/Bookings/ThankYouScreen.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/models/medicine_order_model.dart';
import 'package:amc/models/otc_medicine_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineOrderPlace extends StatefulWidget {
  final bool isPrescription;

  const MedicineOrderPlace(this.isPrescription, {Key? key}) : super(key: key);

  @override
  _MedicineOrderPlaceState createState() => _MedicineOrderPlaceState();
}

class _MedicineOrderPlaceState extends State<MedicineOrderPlace> {
  File? file;
  String? prescriptionPath, username, buttonText = "Place Order";
  bool isTaped = true;
  List<PrescriptionConverterModel> medicines = [];
  String phoneError = "Phone can't be Empty";
  final _picker = ImagePicker();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final medicController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode locaFocus = FocusNode();
  double uploadingValue = 0.0;
  bool isNameEmpty = false;
  bool emailValidate = false;
  bool isPhoneEmpty = false;
  bool isLocationEmpty = false;
  bool isLoading = true;

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
              selectMedicines(),
              medicineList(),
              imageViewLayout(),
              uploadPrescriptionActions(),
              bookingDetails(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: isTaped ? () => placeOrder() : null,
                  child: Text(
                    buttonText!,
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
            height: 200,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10),
                      ],
                    ),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Image.file(
                      file!,
                    ),
                  ),
                ),
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
                        uploadingValue = 0.0;
                      });
                    },
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
            ),
          )
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
                          Text("Camera"),
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
                          Text("Gallery"),
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
          inputFormatters: [Utilities.onlyTextFormat()],
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
          controller: phoneController,
          maxLength: 11,
          onSubmitted: (text) {
            phoneFocus.unfocus();
            FocusScope.of(context).requestFocus(emailFocus);
          },
          focusNode: phoneFocus,
          inputFormatters: [
            Utilities.onlyNumberFormat(),
          ],
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

  Widget selectMedicines() {
    return !widget.isPrescription
        ? Card(
            margin: EdgeInsets.zero,
            elevation: 2,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: medicController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: "Search Medicines",
                ),
              ),
              noItemsFoundBuilder: (context) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("No Medicine Found"),
                );
              },
              suggestionsCallback: otcMedicines,
              itemBuilder: (_, ProductDetail suggestion) {
                return ListTile(
                  dense: true,
                  subtitle: Text("PKR/- " + suggestion.price!),
                  title: AutoSizeText(
                    suggestion.name!,
                    maxLines: 1,
                  ),
                );
              },
              onSuggestionSelected: (ProductDetail suggestion) {
                setState(() {
                  medicController.text = "";
                  PrescriptionConverterModel model =
                      PrescriptionConverterModel();
                  model.productName = suggestion.name;
                  model.productPrice = suggestion.price;
                  model.productId = suggestion.id;
                  model.productImage = suggestion.img ??
                      "/assets/img/online-medicines-image-not-found.png";
                  model.uniqueKey = 1588004799022;
                  model.productQuantity = 1;
                  medicines.add(model);
                });
              },
              keepSuggestionsOnLoading: false,
              hideSuggestionsOnKeyboardHide: false,
              debounceDuration: const Duration(
                milliseconds: 300,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Future<List<ProductDetail>> otcMedicines(String name) async {
    String response =
        await Utilities.httpGet(ServerConfig.otcMedicines + "&name=$name");
    List<ProductDetail> list = [];
    if (response != "404") {
      list = otcMedicinesFromJson(response).response!.otcMedicines!;
    }
    return list;
  }

  Widget medicineList() {
    return medicines.isNotEmpty
        ? Card(
            margin: const EdgeInsets.only(
              top: 8.0,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  dense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  title: AutoSizeText(
                    medicines[index].productName!,
                    maxLines: 1,
                  ),
                  subtitle: Text("PKR " + medicines[index].productPrice!),
                  trailing: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          medicines.removeAt(index);
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
              itemCount: medicines.length,
            ),
          )
        : const SizedBox.shrink();
  }

  void placeOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    disableButton();
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String location = locationController.text.trim();
    String? username = preferences.getString(Keys.USERNAME);
    String? medicinesString;

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
        Utilities.showToast("Please Upload Prescription");
        enableButton();
        return;
      } else {
        if (isLoading) {
          Utilities.showToast("Image Uploading...");
          enableButton();
          return;
        }
      }
    } else {
      if (medicines.isEmpty) {
        Utilities.showToast("Please Select Medicine(s)");
        enableButton();
        return;
      }

      // medicines ki list ko json list mein convert karna hai...
      medicinesString =
          jsonEncode(List<dynamic>.from(medicines.map((x) => x.toJson())));
    }

    Loading.build(context, false);

    Dio dio = Dio();

    FormData data = FormData.fromMap({
      "OrderList": medicinesString,
    });

    Response? response;

    String values =
        "&FullName=$name&username=$username&address=$location&Phone=$phone"
        "&Email=$email&PaymentMethod=Cash On Delivery&Source=${Keys.source}&attachment=$prescriptionPath"
        "&ReferanceBy=${Keys.locationId}";
    try {
      response =
          await dio.post(ServerConfig.medicineOrderPlace + values, data: data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    Loading.dismiss();
    if (response == null) {
      Utilities.showToast("Unable to Place Order, try again later");
      enableButton();
      return;
    }

    if (response.statusCode == 200) {
      Route route = MaterialPageRoute(builder: (_) => const ThankYouScreen());
      Navigator.push(context, route);
    } else {
      Utilities.showToast("Unable to Place Order, try again later");
      enableButton();
    }
    enableButton();
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

  void isOnline() async {
    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable();
      return;
    }
  }

  void getPrefrences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString(Keys.USERNAME);
    nameController.text = preferences.getString(Keys.name) ?? "";
    phoneController.text = preferences.getString(Keys.phone) ?? "";
    emailController.text = preferences.getString(Keys.email) ?? "";
    locationController.text = preferences.getString(Keys.address) ?? "";
  }

  @override
  void initState() {
    super.initState();
    getPrefrences();
  }
}
