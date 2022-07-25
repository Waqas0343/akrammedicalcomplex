import 'package:amc/Screens/MyBooking/LabOrderDetails.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:amc/models/test_order_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabOrders extends StatefulWidget {
  final List<TestModel>? orders;

  const LabOrders({Key? key, this.orders}) : super(key: key);

  @override
  _LabOrdersState createState() => _LabOrdersState();
}

class _LabOrdersState extends State<LabOrders> {
  late List<TestModel> orders;
  List<TestModel> ordersModel = [];
  late SharedPreferences preferences;
  String? username;
  int offset = 0;

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ordersModel.isNotEmpty
          ? view()
          :  const Center(
              child: Text(
                "No Tests",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
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
    orders.addAll(widget.orders!);
    ordersModel.addAll(orders);
    setState(() {});
  }

  void getOrders() async {
    Loading.build(context, true);
    if (!await Utilities.isOnline()) {
      Future.delayed(const Duration(seconds: 1), () {
        Loading.dismiss();
      });
      return;
    }

    String values = "&username=$username";

    String response =
        await Utilities.httpGet(ServerConfig.myTestOrders + values);
    Loading.dismiss();
    if (response != "404") {
      var list = testOrderResponseModelFromJson(response).response!.response!;

      for (var element in list) {
        if (element.attachmentsResults != null) {
          orders.add(element);
        }
      }
      ordersModel.addAll(orders);
      setState(() {});
    }
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
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          "Order ID # ${testModel.orderId}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              testModel.datetime!,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            AutoSizeText(testModel.status!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: testModel.getColor()))
                          ],
                        ),
                        leading: NetWorkImage(
                          placeHolder: MyImages.instaFile,
                          imagePath:
                            testModel.prescriptionPath,
                          height: 90,
                          width: 70,
                        ),
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (_) => LabOrderDetails(
                                    testModel: testModel,
                                  ));
                          Navigator.push(context, route);
                        },
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
