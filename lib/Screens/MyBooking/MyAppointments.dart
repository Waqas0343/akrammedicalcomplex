import 'package:amc/Widgets/cache_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Models/AppointmentModel.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MyAppointments extends StatefulWidget {
  final List<Appointment> appointments;

  const MyAppointments({Key key, this.appointments}) : super(key: key);

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState(this.appointments);
}

class _MyAppointmentsState extends State<MyAppointments> {

  final List<Appointment> appointments;

  List<Appointment> appointmentsModel = [];

  _MyAppointmentsState(this.appointments);

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: appointmentsModel.isNotEmpty
          ? appointmentView()
          : Center(child: Text("No Appointments", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
    );
  }

  Widget appointmentView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 4.0),
          child: TextField(
            controller: nameController,
            maxLength: 60,
            onChanged: (text){
              filterSearchResults(text);
            },
            decoration: InputDecoration(
                filled: false,
                hintText: "Search by Doctor Name",
                counterText: "",
                prefixIcon: Icon(Icons.search),
                suffixIcon: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      nameController.clear();
                      filterSearchResults("");
                    },
                    child: Icon(Icons.close))),
          ),
        ),
        appointments.isNotEmpty ?
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            itemBuilder: (BuildContext context, int index){
              Appointment appointment = appointments[index];

              DateTime dateObj = new DateFormat("MM/dd/yyyy").parse(appointment.dateFormatted);
              DateTime nowDateTime = DateTime(dateObj.year, dateObj.month, dateObj.day);

              String day =  new DateFormat("EE").format(nowDateTime);
              String finalDate =  new DateFormat("d MMM yy").format(dateObj);
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                elevation: 4,
                child: ListTile(
                  leading: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: NetWorkImage(placeHolder: MyImages.doctorPlace,
                      imagePath: appointment.doctorImage,
                      width: 60,
                      height: 60,),
                  ),
                  title: AutoSizeText('$day, $finalDate At ${appointment.time}',style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointment.doctorName, softWrap: false,),
                      SizedBox(height: 8,),
                      Text(appointment.status, softWrap: false,style: TextStyle(fontWeight: FontWeight.bold, color: appointment.getStatusColor())),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },itemCount: appointments.length,
          ),
        ) : Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            "No Appointment Found",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.grey),
          ),
        ),
      ],
    );
  }

  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      List<Appointment> dummyListData = List<Appointment>();
      appointmentsModel.forEach((item) {

        String name = item.doctorName.toLowerCase();
        String status = item.status.toLowerCase();
        if(name.contains(query.toLowerCase()) || status.contains(query.toLowerCase())) {
          dummyListData.add(item);
          return;

        }

      });
      setState(() {
        appointments.clear();
        appointments.addAll(dummyListData);
      });

      return;
    } else {
      setState(() {
        appointments.clear();
        appointments.addAll(appointmentsModel);
      });
    }

  }

  @override
  void initState() {
    appointmentsModel.addAll(appointments);
    super.initState();
  }
}