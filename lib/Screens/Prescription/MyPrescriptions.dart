import 'package:amc/Models/PrescriptionModel.dart';
import 'package:amc/Screens/Prescription/PrescriptionWebView.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPrescriptions extends StatefulWidget {
  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<MyPrescriptions> {
  List<Prescription> prescriptions = [];
  List<Prescription> prescriptionModels;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("My Prescriptions"),
      ),
      body: prescriptionModels.isNotEmpty
          ? prescriptionView()
          : Center(
              child: Text(
                "No Prescriptions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
    );
  }

  Widget prescriptionListView(BuildContext context, int index) {
    Prescription prescription = prescriptions[index];
    DateFormat dateFormat = DateFormat("MM/dd/yyyy HH:mm:ss a");
    DateTime dateTime = dateFormat.parse(prescription.timeStamp);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 4,
      child: ListTile(
        isThreeLine: true,
        leading: Icon(
          MdiIcons.prescription,
          color: MyColors.primary,
          size: 38,
        ),
        title: Text(
          prescription.title ?? "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              prescription.doctorName,
              style: TextStyle(fontSize: 12),
              softWrap: false,
            ),
            SizedBox(height: 4,),
            Text('${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Route route = MaterialPageRoute(
              builder: (_) => PrescriptionWebView(
                  prescription.prescriptionUrl, prescription.title));
          Navigator.push(context, route);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    prescriptionModels = [];
    updateUi();
  }

  void updateUi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.USERNAME);

    Loading.build(context, true);
    String response = await Utilities.httpGet(
        ServerConfig.PRESCRIPTION + "&Username=$username");
    Loading.dismiss();
    if (response != "404") {
      setState(() {
        prescriptionModels
            .addAll(prescriptionModelFromJson(response).response.prescriptions);
        prescriptions.addAll(prescriptionModels);
      });
    } else {
      Utilities.showToast("Something went wrong");
    }
  }

  void filter(String query) {
    if (query.isNotEmpty) {
      List<Prescription> dummyListData = List<Prescription>();
      prescriptionModels.forEach((item) {
        String title = item.title != null ? item.title.toLowerCase() : "";
        String drName = item.doctorName.toLowerCase();
        String date = item.timeStamp.toLowerCase();
        if (drName.contains(query.toLowerCase()) ||
            date.contains(query.toLowerCase()) ||
            title.contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        prescriptions.clear();
        prescriptions.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        prescriptions.clear();
        prescriptions.addAll(prescriptionModels);
      });
    }
  }

  Widget prescriptionView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0, bottom: 4.0),
          child: TextField(
            controller: textController,
            onChanged: (text) {
              filter(text);
            },
            decoration: InputDecoration(
              filled: false,
              hintText: "Search by Dr Name, Date",
              prefixIcon: Icon(Icons.search),
              suffixIcon: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  textController.clear();
                  filter("");
                },
                child: Icon(Icons.close),
              ),
            ),
          ),
        ),
        prescriptions.isNotEmpty
            ? Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) =>
                        prescriptionListView(context, index),
                    itemCount: prescriptions.length,
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Prescription not found",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              ),
      ],
    );
  }
}
