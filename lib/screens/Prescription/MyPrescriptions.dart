import 'package:amc/Screens/Prescription/PrescriptionWebView.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/models/prescription_model.dart';
import 'package:amc/placeholder/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPrescriptions extends StatefulWidget {
  const MyPrescriptions({Key? key}) : super(key: key);

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<MyPrescriptions> {
  List<Prescription> prescriptions = [];
  late List<Prescription> prescriptionmodels;
  bool isLoading = true;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("My Prescriptions"),
      ),
      body: prescriptionmodels.isNotEmpty
          ? prescriptionView()
          : prescriptionmodels.isEmpty && !isLoading ? const Center(
              child: Text(
                "No Prescriptions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ) : const LoadingMyPrescription(),
    );
  }

  Widget prescriptionListView(BuildContext context, int index) {
    Prescription prescription = prescriptions[index];
    DateFormat dateFormat = DateFormat("MM/dd/yyyy HH:mm:ss a");
    DateTime dateTime = dateFormat.parse(prescription.timeStamp!);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 4,
      child: ListTile(
        isThreeLine: true,
        leading: const Icon(
          MdiIcons.prescription,
          color: MyColors.primary,
          size: 38,
        ),
        title: Text(
          prescription.title ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              prescription.doctorName!,
              style: const TextStyle(fontSize: 12),
              softWrap: false,
            ),
            const SizedBox(height: 4,),
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
    prescriptionmodels = [];
    updateUi();
  }

  void updateUi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString(Keys.USERNAME);
    String response = await Utilities.httpGet(
        ServerConfig.prescriptions + "&Username=$username");
    if (response != "404") {
      setState(() {
        prescriptionmodels
            .addAll(prescriptionModelFromJson(response).response!.prescriptions!);
        prescriptions.addAll(prescriptionmodels);
      });
    } else {
      Utilities.showToast("Something went wrong");
    }
    setState(() => isLoading = false);
  }

  void filter(String query) {
    if (query.isNotEmpty) {
      List<Prescription> dummyListData = <Prescription>[];
      for (var item in prescriptionmodels) {
        String title = item.title != null ? item.title!.toLowerCase() : "";
        String drName = item.doctorName!.toLowerCase();
        String date = item.timeStamp!.toLowerCase();
        if (drName.contains(query.toLowerCase()) ||
            date.contains(query.toLowerCase()) ||
            title.contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        prescriptions.clear();
        prescriptions.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        prescriptions.clear();
        prescriptions.addAll(prescriptionmodels);
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
            maxLength: 60,
            onChanged: (text) {
              filter(text);
            },
            decoration: InputDecoration(
              filled: false,
              hintText: "Search by Dr Name",
              counterText: "",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  textController.clear();
                  filter("");
                },
                child: const Icon(Icons.close),
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
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) =>
                        prescriptionListView(context, index),
                    itemCount: prescriptions.length,
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "No Prescription Found",
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
