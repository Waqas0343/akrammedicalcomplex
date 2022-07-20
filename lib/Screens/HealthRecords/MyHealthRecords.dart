import 'package:amc/models/medical_record_model.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/placeholder/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddHealthRecord.dart';
import 'MyHealthRecordDetails.dart';

class MyHealthRecords extends StatefulWidget {
  const MyHealthRecords({Key? key}) : super(key: key);

  @override
  _MyHealthRecordsState createState() => _MyHealthRecordsState();
}

class _MyHealthRecordsState extends State<MyHealthRecords> {
  late SharedPreferences preferences;
  late List<HealthRecord> recordModel;
  List<HealthRecord> healthRecords = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Medical Records"),
        actions: <Widget>[
          IconButton(
            tooltip: "Add New",
            icon: const Icon(Icons.add),
            onPressed: () {
              openRoute();
            },
          )
        ],
      ),
      body: recordView(),
    );
  }

  Widget medicalRecordListView(BuildContext context, int index) {
    HealthRecord record = healthRecords[index];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 4,
      child: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Route route =
              MaterialPageRoute(builder: (_) => MyHealthRecordDetails(record));
          Navigator.push(context, route);
        },
        onLongPress: () {
          FocusScope.of(context).requestFocus(FocusNode());
          deleteDialog(record);
        },
        borderRadius: BorderRadius.circular(4),
        child: ListTile(
          leading: NetWorkImage(
            placeHolder: MyImages.instaFile,
            imagePath: record.filePath,
            width: 70,
            height: 70,
          ),
          title: Text(
            record.fileName!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(record.recordType!),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    recordModel = [];
    getRecords();
  }

  void filter(String query) {
    if (query.isNotEmpty) {
      List<HealthRecord> dummySearchList = <HealthRecord>[];
      dummySearchList.addAll(recordModel);
      List<HealthRecord> dummyListData = <HealthRecord>[];
      for (var item in dummySearchList) {
        String type = item.recordType!.toLowerCase();
        String file = item.fileName!.toLowerCase();
        if (type.contains(query.toLowerCase()) ||
            file.contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        healthRecords.clear();
        healthRecords.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        healthRecords.clear();
        healthRecords.addAll(recordModel);
      });
    }
  }

  void getRecords() async {
    preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString(Keys.username);
    if (await Utilities.isOnline()) {
      String response = await Utilities.httpGet(
          ServerConfig.medicalRecords + "&username=$username");

      if (response != "404") {
        if (!mounted) return;
        setState(() {
          recordModel.addAll(
              medicalRecordModelFromJson(response).healthRecordList!.records!);
          healthRecords.addAll(recordModel);
        });
      } else {
        Utilities.showToast("Something went wrong");
      }
    } else {
      await Utilities.internetNotAvailable(context);
    }
    setState(() => isLoading = false);
  }

  void deleteDialog(HealthRecord record) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Do you want to delete it?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    bool result = await deleteRecord(record.id);
                    if (result) {
                      Utilities.showToast("Removed");
                      setState(() {
                        healthRecords.remove(record);
                      });
                    } else {
                      Utilities.showToast("Something went wrong");
                    }
                  },
                  child: const Text("Delete"),

                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                )
              ],
            ));
  }

  Future<bool> deleteRecord(int? id) async {
    Loading.build(context, true);
    String response =
        await Utilities.httpPost(ServerConfig.medicalRecordDelete + "&Id=$id");
    Loading.dismiss();
    if (response != "404") {
      return true;
    } else {
      return false;
    }
  }

  void openRoute() async {
    Route route =
        MaterialPageRoute<HealthRecord>(builder: (_) => const AddHealthRecord());
    HealthRecord? record = await Navigator.push(context, route as Route<HealthRecord>);

    if (record != null) {
      setState(() {
        recordModel.insert(0, record);
        healthRecords.insert(0, record);
      });
    }
  }

  Widget recordView() {
    return recordModel.isNotEmpty
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  maxLength: 60,
                  onChanged: (text) {
                    filter(text);
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search by File Name, File Type",
                    counterText: "",
                  ),
                ),
              ),
              healthRecords.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 4),
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            medicalRecordListView(context, index),
                        itemCount: healthRecords.length,
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "No Health Record Found",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                    ),
            ],
          )
        : healthRecords.isEmpty && !isLoading
            ? const Center(
                child: Text(
                  "No Health Records",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )
            : const LoadingHealthRecord();
  }
}
