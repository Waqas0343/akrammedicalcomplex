import 'package:amc/Screens/LabReports/ViewReport.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/models/test_order_model.dart';
import 'package:amc/models/test_search_model.dart';
import 'package:amc/placeholder/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabReports extends StatefulWidget {
  const LabReports({Key? key}) : super(key: key);

  @override
  _LabReportsState createState() => _LabReportsState();
}

class _LabReportsState extends State<LabReports> {
  late List<TestModel> orders;
  List<TestModel> ordersModel = [];
  late SharedPreferences preferences;
  bool isLoading = true;
  String? username;
  int offset = 0;

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text("My Lab Reports")),
      body: ordersModel.isNotEmpty
          ? view()
          : ordersModel.isEmpty && !isLoading ? const Center(
              child: Text(
                "No Reports",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ) : const MyLabReportsShimmer(),
    );
  }

  @override
  void initState() {
    orders = [];
    getPreferences();
    super.initState();
  }

  void getPreferences() async {
    preferences = await SharedPreferences.getInstance();
    username = preferences.getString(Keys.username);
    getOrders();
  }

  void getOrders() async {
    if (!await Utilities.isOnline()) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
        Utilities.internetNotAvailable(context);
      });
      return;
    }

    String values = "&username=$username&Attachments=true";

    String response =
        await Utilities.httpGet(ServerConfig.myTestOrders + values);
    if (response != "404") {
      var list = testOrderResponseModelFromJson(response).response!.response!;

      if (list.isNotEmpty) {
        list[0].isExpanded = true;
      }
      orders.addAll(list);
      ordersModel.addAll(orders);
    }
    setState(() {
      isLoading = false;
    });
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
                hintText: "Search by Test Name",
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
        orders.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemBuilder: (BuildContext context, int index) {
                    TestModel testModel = orders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      elevation: 4,
                      child: Column(
                        children: [
                          ListTile(
                            subtitle: Text(
                              testModel.status!,
                              style: TextStyle(color: testModel.getColor()),
                            ),
                            title: Text(
                              "Order ID # ${testModel.orderId}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(testModel.isExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up),
                            onTap: () {
                              setState(() {
                                orders[index].isExpanded =
                                    !testModel.isExpanded;
                              });
                            },
                          ),
                          Visibility(
                              visible: testModel.isExpanded,
                              child: testModel.isPrescription()
                                  ? ListTile(
                                      onTap: () {
                                        Route route = MaterialPageRoute(
                                            builder: (context) => ViewReport(
                                                  path: testModel
                                                      .attachmentsResults,
                                                  name: testModel.orderId,
                                                ));
                                        Navigator.push(context, route);
                                      },
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 8,
                                          left: 16,
                                          right: 16,
                                          top: 8),
                                      title: Container(
                                          margin: const EdgeInsets.only(left: 8),
                                          alignment: Alignment.centerLeft,
                                          child: NetWorkImage(
                                            placeHolder: MyImages.instaFile,
                                            imagePath:
                                                testModel.prescriptionPath,
                                            height: 50,
                                            width: 70,
                                          )),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Test test = testModel.testList![index];
                                        return ListTile(
                                          onTap: () {
                                            Route route = MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewReport(
                                                      path: testModel
                                                          .attachmentsResults,
                                                      name: testModel.orderId,
                                                    ));
                                            Navigator.push(context, route);
                                          },
                                          title: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 16, bottom: 6),
                                              child: Text(
                                                test.testName!.trim(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          subtitle: Container(
                                              margin: const EdgeInsets.only(left: 16),
                                              child: Text(test.fee!)),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                          ),
                                        );
                                      },
                                      itemCount: testModel.testList!.length,
                                    ))
                        ],
                      ),
                    );
                  },
                  itemCount: orders.length,
                ),
              )
            : Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  "No Test Found",
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
      List<TestModel> dummyListData = <TestModel>[];
      bool isAdded = false;
      for (var item in ordersModel) {
        if (item.testList != null) {
          for (var element in item.testList!) {
            String name = element.testName!.toLowerCase();

            if (name.contains(query.toLowerCase()) && !isAdded) {
              isAdded = true;
              dummyListData.add(item);
              return;
            }
          }
        }
        isAdded = false;
      }
      setState(() {
        orders.clear();
        orders.addAll(dummyListData);
      });

      return;
    } else {
      setState(() {
        orders.clear();
        orders.addAll(ordersModel);
      });
    }
  }
}
