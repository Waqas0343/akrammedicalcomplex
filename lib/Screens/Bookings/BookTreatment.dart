import 'dart:convert';

import 'package:amc/models/service_model.dart';
import 'package:amc/Screens/Bookings/ThankYouScreen.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/placeholder/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookTreatment extends StatefulWidget {
  const BookTreatment({Key key}) : super(key: key);

  @override
  _BookTreatmentState createState() => _BookTreatmentState();
}

class _BookTreatmentState extends State<BookTreatment> {
  List<ServiceModel> servicesList = [];
  List<ServiceModel> selectedList = [];

  List<ServiceModel> servicesModel = [];

  final nameController = TextEditingController();

  bool isLoading = true;
  SharedPreferences preferences;

  bool isTaped = true;
  String buttonText = "Confirm";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(Keys.homeServices),
      ),
      body: isLoading
          ? LoadingServicesList()
          : servicesModel.isNotEmpty
              ? view()
              : const Center(
                  child: Text(
                    "Services Not available",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
      floatingActionButton: selectedList.isNotEmpty
          ? FloatingActionButton.extended(
              backgroundColor: MyColors.primary,
              foregroundColor: Colors.white,
              splashColor: Colors.white.withOpacity(0.2),
              onPressed: isTaped ? () => confirmationDialog() : null,
              icon: const Icon(Icons.send),
              label: Text(
                buttonText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  void getTreatments() async {
    if (!await Utilities.isOnline()) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
        Utilities.internetNotAvailable(context);
      });
      return;
    }
    String response = await Utilities.httpGet(
        ServerConfig.getServices + "&searchParam=&location=${Keys.locationId}");
    if (response != "404") {
      if (!mounted) return;
      setState(() {
        servicesList.addAll(servicesModelFromJson(response).response.response);
        servicesModel.addAll(servicesList);
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      Utilities.showToast("Unable to get Services");
    }
  }

  void bookTreatment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.username);
    String name = preferences.getString(Keys.name);

    disableButton();
    if (!await Utilities.isOnline()) {
      enableButton();
      Utilities.internetNotAvailable(context);
      return;
    }

    String services =
        jsonEncode(List<dynamic>.from(selectedList.map((x) => x.toJson())))
            .replaceAll("'", "");

    DateTime dateTime = DateTime.now();
    String date = DateFormat("MM/dd/yyyy").format(dateTime).toString();
    String time = DateFormat("hh:mm a").format(dateTime);

    String newDate = date + " " + time.trim();

    String values = "&DoctorUsername=" "&Location=${Keys.locationId}" "&patname=" +
        name +
        "&PatientUsername=" +
        username +
        "&Status=Pending" +
        "&ScheduledDate_Short=" +
        newDate +
        "&ScheduledTime_Short=" +
        time +
        "&ScheduledEndTime_Short=" +
        time +
        "&AppointmentSource=Private" +
        "&Source=${Keys.source}" +
        "&Details=$services" +
        "&Reason=" +
        "&Type=Treatment";
    Navigator.pop(context);
    Loading.build(context, false);
    var response = await Utilities.httpPost(
        ServerConfig.appointmentTreatmentSave + values);
    Loading.dismiss();

    if (response != "404") {
      enableButton();
      Route route = MaterialPageRoute(builder: (_) => ThankYouScreen());
      Navigator.push(context, route);
    } else {
      Utilities.showToast("Unable to ${Keys.homeServices}");
    }
    enableButton();
  }

  void confirmationDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
                "Do you really want to confirm your Services booking ?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: isTaped ? () => bookTreatment() : null,
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getTreatments();
  }

  Widget view() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 8.0, bottom: 4.0),
          child: TextField(
            controller: nameController,
            maxLength: 60,
            onChanged: (text) {
              filterSearchResults(text);
            },
            decoration: InputDecoration(
                filled: false,
                hintText: "Search by Service Name",
                counterText: "",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      nameController.clear();
                      filterSearchResults("");
                    },
                    child: const Icon(Icons.close))),
          ),
        ),
        servicesList.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  itemBuilder: (BuildContext context, int index) {
                    ServiceModel serviceModel = servicesList[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(serviceModel.name),
                          subtitle: Text("PKR/- " + serviceModel.fee),
                          value: serviceModel.isSelected,
                          onChanged: (value) {
                            if (value) {
                              selectedList.add(serviceModel);
                            } else {
                              selectedList.remove(serviceModel);
                            }
                            setState(() {
                              servicesList[index].isSelected = value;
                            });
                          }),
                    );
                  },
                  itemCount: servicesList.length,
                ),
              )
            : Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "No Service Found",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              ),
      ],
    );
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<ServiceModel> dummyListData = <ServiceModel>[];
      for (var item in servicesModel) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
          return;
        }
      }
      setState(() {
        servicesList.clear();
        servicesList.addAll(dummyListData);
      });

      return;
    } else {
      setState(() {
        servicesList.clear();
        servicesList.addAll(servicesModel);
      });
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
}
