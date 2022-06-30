import 'package:amc/models/lab_test_order_model.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Screens/Orders/Diagnostics/LabTestOrderDetails.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LabTestOrderDetails.dart';

class MyLabTestOrders extends StatefulWidget {
  const MyLabTestOrders({Key key}) : super(key: key);

  @override
  _MyLabTestOrdersState createState() => _MyLabTestOrdersState();
}

class _MyLabTestOrdersState extends State<MyLabTestOrders> {

  List<TestOrder> orders;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index)=>makeOrdersList(context, index),
          itemCount: orders.length,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    orders = <TestOrder>[];
    getOrders();
  }

  void getOrders() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString(Keys.USERNAME);
    if (!await Utilities.isOnline()){
      Utilities.internetNotAvailable(context);
      return;
    }
    
    Loading.build(context, true);
    
    String response = await Utilities.httpGet(ServerConfig.myTestOrders +"&username=$username");

    if (response != "404"){

      var list = labTestOrdersModelFromJson(response);

      setState(() {
        orders.addAll(list.response.tests);
      });
    } else {
      Utilities.showToast("Someting went Wrong, try again latter");
    }
    
    
    Loading.dismiss();
  }

  Widget makeOrdersList(BuildContext context, int index) {
    TestOrder order = orders[index];
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: (){
          Route route = MaterialPageRoute(builder: (_) => LabTestOrderDetails(order));
          Navigator.push(context, route);

        },
        child: ListTile(
          title: Text("Order #: "+order.orderId, softWrap: false ,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          subtitle: Row(
            children: <Widget>[
              Flexible(child: Text(order.status, softWrap: false ,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
              const Icon(MdiIcons.circleSmall, color: Colors.blue,),
              Text(order.datetime, style: const TextStyle(fontSize: 12),),
            ],
          ),
          leading: NetWorkImage(
            placeHolder: MyImages.instaFile,
            imagePath: order.prescriptionPath,
            width: 60,
            height: MediaQuery.of(context).size.height,
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18,),
        ),
      ),
    );
  }
}
