import 'package:amc/models/medicine_order_model.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MedicineOrderDetails.dart';

class MyMedicineOrders extends StatefulWidget {
  final List<Order> orders;

  const MyMedicineOrders({Key key, this.orders}) : super(key: key);

  @override
  _MyMedicineOrdersState createState() => _MyMedicineOrdersState();
}

class _MyMedicineOrdersState extends State<MyMedicineOrders> {
  List<Order> orders;
  SharedPreferences preferences;
  String username;
  final nameController = TextEditingController();
  List<Order> ordersModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ordersModel.isNotEmpty
          ? view()
          : const Center(
              child: Text(
                "No Medicines",
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
    if (!mounted) return;
    setState(() {});
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
              hintText: "Search by Medicine Name",
              counterText: "",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  nameController.clear();
                  // filterSearchResults("");
                },
                child: const Icon(Icons.close),
              ),
            ),
          ),
        ),
        orders.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemBuilder: (BuildContext context, int index) =>
                      makeOrdersList(context, index),
                  itemCount: orders.length,
                  shrinkWrap: true,
                ),
              )
            : Utilities.emptyScreen(),
      ],
    );
  }

  Widget makeOrdersList(BuildContext context, int index) {
    Order order = orders[index];
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          Route route =
              MaterialPageRoute(builder: (_) => MedicineOrderDetails(order));
          Navigator.push(context, route);
        },
        child: ListTile(
          isThreeLine: true,
          title: Text(
            "Order ID # " + order.orderId,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 4,
              ),
              Text(
                order.orderDate,
              ),
              const SizedBox(
                height: 4,
              ),
              AutoSizeText(
                order.status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: order.getColor(),
                ),
              ),
            ],
          ),
          leading: NetWorkImage(
              placeHolder: MyImages.instaFile,
              imagePath:
                order.prescriptionPath,
              height: 90,
              width: 70,
              // height: MediaQuery.of(context).size.height,
            ),
        ),
      ),
    );
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Order> dummyListData = <Order>[];
      bool isAdded = false;
      for (var item in ordersModel) {
        if (item.medicines != null) {
          for (var element in item.medicines) {
            String name = element.productName.toString().toLowerCase();
            if (name == null) {
              return;
            }
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
