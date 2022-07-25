import 'dart:convert';

import 'package:amc/Screens/Bookings/ThankYouScreen.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointment extends StatefulWidget {
  final String name;
  final String speciality;
  final String fee;
  final String? imagePath;
  final String username;
  final bool isTeleMedicineProvider;

  const BookAppointment({
    Key? key,
    required this.name,
    required this.isTeleMedicineProvider,
    required this.username,
    required this.fee,
    required this.speciality,
    this.imagePath,
  }) : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool isOnline = false;

  List<String> slotsInDay = [];
  String? selectedSlot;

  List<DateTime> days = [];
  late DateTime selectedDay;

  bool isTaped = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Confirm Appointment"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// profile card
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 10, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: NetWorkImage(
                    imagePath: widget.imagePath,
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
                          widget.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.speciality,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: MyColors.accent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "PKR/- ${widget.fee.replaceAll("PKR/- ", "")}",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          /// select Date
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 10),
            child: Text(
              "Select Date",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

          /// days
          SizedBox(
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                vertical: 6,
              ),
              itemCount: days.length,
              itemBuilder: (context, index) {
                DateTime date = days[index];
                String day = DateFormat("E").format(date);
                String finalDate = DateFormat("d").format(date);
                bool isSelected = selectedDay == date;
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = date;
                        selectedSlot = null;
                      });
                      getSlots();
                    },
                    child: Card(
                      elevation: isSelected ? 4 : 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: isSelected ? Colors.indigo[900] : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              finalDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: isSelected
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
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// select time
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
            child: Text(
              "Select Time",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

          /// slots
          Expanded(
            child: slotsInDay.isNotEmpty
                ? GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.height / 400,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    scrollDirection: Axis.vertical,
                    children: slotsInDay.map((e) {
                      bool timeSelected = selectedSlot == e;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSlot = e;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                timeSelected ? MyColors.primary : Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 8,
                              ),
                              child: Text(
                                e,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: timeSelected
                                          ? Colors.white
                                          : MyColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList())
                : Center(
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text("No Time slot available."),
                  ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isTeleMedicineProvider)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOnline = !isOnline;
                    });
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: isOnline,
                        onChanged: (value) {
                          setState(() {
                            isOnline = value!;
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
                          if (selectedSlot == null) {
                            Utilities.showToast("Select Slot");
                            return;
                          }
                          confirmationDialog();
                        }
                      : null,
                  child: const Text(
                    "Confirm Appointment",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // saving next 10 days dates
    for (int i = 0; i < 10; i++) {
      days.add(DateTime.now().add(Duration(days: i)));
    }
    // select today's date as selected date
    selectedDay = days.first;

    // get time slots of selected date
    getSlots();
    super.initState();
  }

  /// To get time slots [selectedDay]
  Future getSlots() async {
    slotsInDay.clear();
    setState(() {
      isLoading = true;
    });
    String day = DateFormat("EEEE").format(selectedDay);
    String formattedDate = DateFormat("MM/dd/yyyy").format(selectedDay);
    String response = await Utilities.httpPost(ServerConfig.timeSlots +
        "&doctor=${widget.username}&day=$day&date=$formattedDate&Location=${Keys.locationId}");

    if (response == "404") {
      Utilities.showToast("Unable to get timings");
      return;
    }

    Map<String, dynamic> json = jsonDecode(response);
    var slots = json["Response"]["Response"]["TimeSlots"];
    if (slots != null) {
      slotsInDay = List<String>.from(slots.map((e) => e)).toList();
    }

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  /// before calling [bookAppointment] show the confirmation dialog
  void confirmationDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text(
            "Do you really want to confirm this appointment?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                bookAppointment();
              },
              child: const Text(
                "Yes",
              ),
            ),
          ],
        ),
      );

  /// after confirmation book appointment
  Future bookAppointment() async {
    setState(() {
      isTaped = false;
    });

    String date = DateFormat("MM/dd/yyyy").format(selectedDay);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.username)!;
    String name = preferences.getString(Keys.name)!;
    String time = selectedSlot!;
    String newDate = date + " " + time;
    String checkUp = isOnline ? "Online" : "Regular Checkup";

    String values =
        "&DoctorUsername=${widget.username}&Location=${Keys.locationId}&patname=$name&PatientUsername=$username&Status=Pending&"
        "ScheduledDate_Short=$newDate&ScheduledTime_Short=$time&ScheduledEndTime_Short=$time&AppointmentSource=Private"
        "&Source=${Keys.source}&Reason=&Type=$checkUp";

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
    if (!mounted) return;
    setState(() {
      isTaped = true;
    });
  }
}
