import 'dart:convert';
import 'package:amc/Screens/Bookings/ThankYouScreen.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../placeholder/custom_shimmer.dart';

class BookAppointment extends StatefulWidget {
  final String? drName;
  final String? category;
  final String? fee;
  final String? image;
  final String? drUsername;
  final bool? isTeleMedicineProvider;

  const BookAppointment(
      {Key? key,
      this.drName,
      this.isTeleMedicineProvider,
      this.drUsername,
      this.fee,
      this.image,
      this.category})
      : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  int selected = 0;
  int? timeSelect;
  bool? isChecked = false;
  List<String> timeSlots = [];
  String? timeSlot;
  String? date;
  List dateLength = [];
  DateTime selectedDateTime = DateTime.now();

  String get day => DateFormat("EEEE").format(selectedDateTime);

  String get finalDate => DateFormat("MM/dd/yyyy").format(selectedDateTime);
  bool isTaped = true;
  String buttonText = "Confirm Appointment";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Confirm Appointment"),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
        child: timeSlots.isNotEmpty ? view() : const AppointmentShimmer(),
      ),
    );
  }

  @override
  void initState() {
    timeSlots = [];
    updateUi();
    addDate();
    super.initState();
  }

  void updateUi() async {
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable(context);
      return;
    }
    String response = await Utilities.httpPost(ServerConfig.timeSlots +
        "&doctor=${widget.drUsername}&day=$day&date=$finalDate&Location=${Keys.locationId}");
    if (kDebugMode) {
      print(response);
    }
    if (response != "404") {
      timeSlots = List<String>.from(jsonDecode(response)["Response"]["Response"]
              ["TimeSlots"]
          .map((e) => e)).toList();
      date = jsonDecode(response)["Response"]["Response"]["Date"];
      if (timeSlots.isNotEmpty) {
        timeSlot = timeSlots[0];
        if (!mounted) return;
        setState(() {});
      } else {
        Utilities.showToast("No Time Slots available");
        Navigator.pop(context);
      }
    } else {
      Utilities.showToast("Unable to get timings");
      Navigator.pop(context);
    }
  }

  Widget view() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: NetWorkImage(
                imagePath: widget.image,
                placeHolder: MyImages.imageNotFound,
                height: 100,
                width: 110,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.drName!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.category!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                          color: MyColors.accent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "${widget.fee!} PKR ",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Select Date",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          height: MediaQuery.of(context).size.height * 0.18,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dateLength.length,
              itemBuilder: (context, index) {
                String date = dateLength[index];
                DateTime dateObj = DateFormat("yyyy-MM-dd").parse(date);
                DateTime nowDateTime =
                    DateTime(dateObj.year, dateObj.month, dateObj.day);
                String day = DateFormat("E").format(nowDateTime);
                String finalDate = DateFormat("d").format(nowDateTime);
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: GestureDetector(
                    onTap: () {
                      updateUi();
                      timeSlots.clear();
                      setDayAndDate(nowDateTime);
                      setState(() {
                        selected = index;
                      });
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color:
                          index == selected ? Colors.indigo[900] : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              finalDate,
                              style: TextStyle(
                                fontSize: 30.0,
                                color: index == selected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              day,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: index == selected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Select Time",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: MediaQuery.of(context).size.height / 400,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              scrollDirection: Axis.vertical,
              children: timeSlots.map((e) {
                int index = timeSlots.indexOf(e);
                bool timeSelected = timeSelect == index ? true : false;
                return GestureDetector(
                  onTap: () {
                    timeSelect = timeSlots.indexOf(e);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: timeSelected ? MyColors.primary : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        child: Text(
                          e.toString().replaceAll(":00 ", " "),
                          style: TextStyle(
                              color: timeSelected
                                  ? Colors.white
                                  : MyColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList()),
        ),
        if (widget.isTeleMedicineProvider == true)
          GestureDetector(
            onTap: () {
              setState(() {
                isChecked = !isChecked!;
              });
            },
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                  activeColor: MyColors.primary,
                  checkColor: Colors.white,
                ),
                const Text(
                  "Online Consultation",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.primary,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: isTaped
                ? () {
                    if (timeSlot == null) {
                      Utilities.showToast("Select Date");
                      return;
                    }
                    if (timeSelect == null) {
                      Utilities.showToast("Select Time");
                      return;
                    }
                    confirmationDialog();
                  }
                : null,
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  void confirmationDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content:
                const Text("Do you really want to confirm this appointment ?"),
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
                  onPressed: () => bookAppointment(),
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          );
        });
  }

  void addDate() {
    for (int i = 0; i < 10; i++) {
      dateLength.add(DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(Duration(days: i))));
    }
  }

  void bookAppointment() async {
    disableButton();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.username)!;
    String name = preferences.getString(Keys.name)!;
    String time = timeSlots[timeSelect!];
    String newDate = date! + " " + time;
    String checkUp = isChecked! ? "Online" : "Regular Checkup";

    String values =
        "&DoctorUsername=${widget.drUsername}&Location=${Keys.locationId}&patname=$name&PatientUsername=$username&Status=Pending&ScheduledDate_Short=$newDate&ScheduledTime_Short=$time&ScheduledEndTime_Short=$time&AppointmentSource=Private&Source=${Keys.source}&Reason=&Type=$checkUp";

    isOnline();
    Navigator.pop(context);

    Loading.build(context, false);
    var response =
        await Utilities.httpPost(ServerConfig.appointmentSave + values);
    Loading.dismiss();

    if (response != "404") {
      Route route = MaterialPageRoute(builder: (_) => const ThankYouScreen());
      Navigator.push(context, route);
    } else {
      Utilities.showToast("Unable to create appointment");
    }
    enableButton();
  }

  void setDayAndDate(DateTime dateTime) {
    selectedDateTime = dateTime;
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
      Utilities.internetNotAvailable(context);
      enableButton();
      return;
    }
  }
}
