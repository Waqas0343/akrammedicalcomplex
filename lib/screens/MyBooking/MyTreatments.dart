import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/models/service_model.dart';
import 'package:amc/models/treatment_model.dart';
import 'package:amc/placeholder/custom_shimmer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTreatments extends StatefulWidget {
  const MyTreatments({Key? key}) : super(key: key);

  @override
  _MyTreatmentsState createState() => _MyTreatmentsState();
}

class _MyTreatmentsState extends State<MyTreatments> {
  late List<TreatmentData> treatments;
  final List<TreatmentData> treatmentsModel = [];
  bool treatmentLoading = true;

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          "My Home Services",
        ),
      ),
      body: treatmentsModel.isNotEmpty
          ? treatmentsView()
          : !treatmentLoading && treatmentsModel.isEmpty
              ? const Center(
                  child: Text(
                    "No Service Found",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )
              : const MyServicesLoading(),
    );
  }

  Widget treatmentsView() {
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
        treatments.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  itemBuilder: (BuildContext context, int index) {
                    TreatmentData treatmentData = treatments[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 4),
                      elevation: 4,
                      child: Column(
                        children: [
                          ListTile(
                            title: AutoSizeText(
                              "Order Id # " + treatmentData.id!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              treatmentData.status!,
                              style: TextStyle(
                                color: treatmentData.getStatusColor(),
                              ),
                            ),
                            trailing: Icon(treatmentData.isExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up),
                            onTap: () {
                              setState(() {
                                treatments[index].isExpanded =
                                    !treatmentData.isExpanded;
                              });
                            },
                          ),
                          Visibility(
                              visible: treatmentData.isExpanded,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  ServiceModel model =
                                      treatmentData.details![index];
                                  return ListTile(
                                    dense: true,
                                    title: Text(model.name!),
                                    subtitle: Text("PKR/- " + model.fee!),
                                  );
                                },
                                itemCount: treatmentData.details!.length,
                              ))
                        ],
                      ),
                    );
                  },
                  itemCount: treatments.length,
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
      List<TreatmentData> dummyListData = <TreatmentData>[];

      bool isAdded = false;
      for (var item in treatmentsModel) {
        if (item.details != null) {
          for (var element in item.details!) {
            String name = element.name!.toLowerCase();

            if (name.contains(query.toLowerCase()) && !isAdded) {
              dummyListData.add(item);
              isAdded = true;
              return;
            }
          }
        }
        isAdded = false;
      }
      setState(() {
        treatments.clear();
        treatments.addAll(dummyListData);
      });

      return;
    } else {
      setState(() {
        treatments.clear();
        treatments.addAll(treatmentsModel);
      });
    }
  }

  void getTreatments() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString(Keys.username);
    if (!await Utilities.isOnline()) {
      Future.delayed(const Duration(seconds: 1), () {
        Utilities.internetNotAvailable();
      });
      setState(() => treatmentLoading = false);
      return;
    }

    String treatmentResponse = await Utilities.httpGet(ServerConfig.treatments +
        "&LocationId=${Keys.locationId}&PatientUsername=$username");
    if (treatmentResponse != "404") {
      if (!mounted) return;
      setState(() {
        var list =
            treatmentModelFromJson(treatmentResponse).response!.response!;
        treatments.addAll(list);
        treatmentsModel.addAll(treatments);
      });
    } else {
      Utilities.showToast("Unable to load Services, try again later.");
    }
    setState(() => treatmentLoading = false);
  }

  @override
  void initState() {
    treatments = <TreatmentData>[];
    getTreatments();
    super.initState();
  }
}
