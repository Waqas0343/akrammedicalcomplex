import 'package:amc/Widgets/cache_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Models/TestOrderResponseModel.dart';
import 'package:amc/Screens/MyBooking/LabOrderDetails.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabOrders extends StatefulWidget {
  final List<TestModel> orders;

  const LabOrders({Key key, this.orders}) : super(key: key);

  @override
  _LabOrdersState createState() => _LabOrdersState();
}

class _LabOrdersState extends State<LabOrders> {
  List<TestModel> orders;
  List<TestModel> ordersModel = [];
  SharedPreferences preferences;
  String username;
  int offset = 0;

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ordersModel.isNotEmpty
          ? view()
          :  Center(
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
    orders.addAll(widget.orders);
    ordersModel.addAll(orders);
    setState(() {});
  }

  void getOrders() async {
    Loading.build(context, true);
    if (!await Utilities.isOnline()) {
      Future.delayed(Duration(seconds: 1), () {
        Loading.dismiss();
      });
      return;
    }

    String values = "&username=$username";

    String response =
        await Utilities.httpGet(ServerConfig.myTestOrders + values);
    Loading.dismiss();
    if (response != "404") {
      var list = testOrderResponseModelFromJson(response).response.response;

      list.forEach((element) {
        if (element.attachmentsResults != null) {
          orders.add(element);
        }
      });
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
        orders.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  itemBuilder: (BuildContext context, int index) {
                    TestModel testModel = orders[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      elevation: 4,
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          "Order ID # ${testModel.orderId}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              testModel.datetime,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            AutoSizeText(testModel.status,
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
                          Route route = new MaterialPageRoute(
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
                margin: EdgeInsets.only(top: 20),
                child: Text(
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
      List<TestModel> dummyListData = List<TestModel>();
      bool isAdded = false;
      ordersModel.forEach((item) {
        if (item.testList != null) {
          item.testList.forEach((element) {
            String name = element.testName.toLowerCase();

            if (name.contains(query.toLowerCase()) && !isAdded) {
              isAdded = true;
              dummyListData.add(item);
              return;
            }
          });
        }
        isAdded = false;
      });
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
