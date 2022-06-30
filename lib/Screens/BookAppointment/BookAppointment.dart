import 'package:amc/models/time_slot_model.dart';
import 'package:amc/Screens/Bookings/ThankYouScreen.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/placeholder/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointment extends StatefulWidget {
  final String drName;
  final String category;
  final String fee;
  final String image;
  final String drUsername;

  const BookAppointment(
      {Key key,
      this.drName,
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
  int timeSelect;
  bool isChecked = false;

  List<TimeSlot> timeSlots;
  TimeSlot timeSlot;

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
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
        child: timeSlots.isNotEmpty
            ? view()
            : AppointmentShimmer(),
      ),
    );
  }

  @override
  void initState() {
    timeSlots = [];
    updateUi();
    super.initState();
  }

  void updateUi() async {

    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable(context);
      return;
    }

    String response = await Utilities.httpGet(ServerConfig.timeSlots +
        "&DoctorUsername=${widget.drUsername}&DaysCount=4");

    if (response != "404") {
      timeSlots = timeSlotModelFromJson(response).response.response;
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
                      widget.drName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.category,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                          color: MyColors.accent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        widget.fee,
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
          height: 12 ,
        ),
        SizedBox(
          height: 65.0,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              bool select = selected == index ? true : false;
              TimeSlot date = timeSlots[index];
              DateTime dateObj = DateFormat("MM/dd/yyyy").parse(date.date);
              DateTime nowDateTime =
                  DateTime(dateObj.year, dateObj.month, dateObj.day);

              String day = DateFormat("EEEE").format(nowDateTime);
              String finalDate = DateFormat("d MMM").format(dateObj);

              return GestureDetector(
                onTap: () {
                  timeSlot = date;
                  timeSelect = null;
                  selected = index;
                  setState(() {});
                },
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              finalDate,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      select ? MyColors.primary : Colors.black),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              day,
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      select ? MyColors.primary : Colors.black),
                            ),
                            select
                                ? const SizedBox(
                                    width: 40,
                                    child: Divider(
                                      color: MyColors.primary,
                                      height: 10,
                                      thickness: 3,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: timeSlots.length,
            scrollDirection: Axis.horizontal,
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
              children: timeSlot.timeSlots.map((e) {
                int index = timeSlot.timeSlots.indexOf(e);
                bool timeSelected = timeSelect == index ? true : false;
                return GestureDetector(
                  onTap: () {
                    timeSelect = timeSlot.timeSlots.indexOf(e);
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
                          e.replaceAll(":00 ", " "),
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

        GestureDetector(
          onTap: (){
            setState(() {
              isChecked = !isChecked;
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
              const Text("Online Consultation", style: TextStyle(fontSize: 16, color: MyColors.primary,),),
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
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
            content: const Text("Do you really want to confirm this appointment ?"),
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

  void bookAppointment() async {
    disableButton();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.username);
    String name = preferences.getString(Keys.name);

    String time = timeSlot.timeSlots[timeSelect];
    String newDate = timeSlot.date + " " + time;
    String checkUp = isChecked ? "Online" : "Regular Checkup";

    String values = "&DoctorUsername=${widget.drUsername}" "&Location=${Keys.locationId}" "&patname=" +
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
        "&Reason=" +
        "&Type=$checkUp";

    isOnline();
    Navigator.pop(context);

    Loading.build(context, false);
    var response = await Utilities.httpPost(
        ServerConfig.appointmentTreatmentSave + values);
    Loading.dismiss();

    if (response != "404") {
      Route route = MaterialPageRoute(builder: (_) => ThankYouScreen());
      Navigator.push(context, route);
    } else {
      Utilities.showToast("Unable to create appointment");
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

  void isOnline() async {
    if (!await Utilities.isOnline()) {
    Utilities.internetNotAvailable(context);
    enableButton();
    return;
    }
  }
}
