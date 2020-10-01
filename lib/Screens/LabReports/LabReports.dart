import 'package:amc/Models/SearchTeshModel.dart';
import 'package:amc/Models/TestOrderResponseModel.dart';
import 'package:amc/Screens/LabReports/ViewReport.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabReports extends StatefulWidget {
  const LabReports({Key key}) : super(key: key);

  @override
  _LabReportsState createState() => _LabReportsState();
}

class _LabReportsState extends State<LabReports> {

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
      appBar: AppBar(title: Text("My Lab Reports")),
      body: ordersModel.isNotEmpty
          ? view()
          : Center(child: Text("No Reports", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
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

    Loading.build(context, true);
    if (!await Utilities.isOnline()){
      Future.delayed(Duration(seconds: 1),(){
        Loading.dismiss();
        Utilities.internetNotAvailable(context);
      });
      return;
    }

    String values = "&username=$username&Attachments=true";

    String response = await Utilities.httpGet(ServerConfig.myTestOrders+values);
    Loading.dismiss();
    if (response != "404"){
      var list = testOrderResponseModelFromJson(response).response.response;

      if (list.isNotEmpty){
        list[0].isExpanded = true;
      }
      orders.addAll(list);
      ordersModel.addAll(orders);
      setState(() {
      });
    }
  }

  Widget view() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 4.0),
          child: TextField(
            controller: nameController,
            onChanged: (text){
              filterSearchResults(text);
            },
            decoration: InputDecoration(
                filled: false,
                hintText: "Search by test Name",
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
        orders.isNotEmpty ?
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 4),
            itemBuilder: (BuildContext context, int index){
              TestModel testModel = orders[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                elevation: 4,
                child: Column(
                  children: [
                    ListTile(
                      subtitle: Text(testModel.status, style: TextStyle(color: testModel.getColor()),),
                      title: Text("Order ID # ${testModel.orderId}", style: TextStyle(fontWeight: FontWeight.bold),),
                      trailing: Icon(testModel.isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                      onTap: (){
                        setState(() {
                          orders[index].isExpanded = !testModel.isExpanded;
                        });
                      },
                    ),
                    Visibility(
                      visible: testModel.isExpanded,
                        child: testModel.isPrescription()
                            ? ListTile(
                          onTap: (){
                            Route route = new MaterialPageRoute(builder: (context)=>ViewReport(path: testModel.attachmentsResults,name: testModel.orderId,));
                            Navigator.push(context, route);
                          },
                          contentPadding: EdgeInsets.only(bottom: 8, left: 16, right: 16,top: 8),
                          title: Container(
                            margin: EdgeInsets.only(left: 8),
                              alignment: Alignment.centerLeft,
                              child: FadeInImage(placeholder: AssetImage(MyImages.instaFile), image: NetworkImage(testModel.prescriptionPath ??"notfound"), height: 50, width: 70,)),
                          trailing: Icon(Icons.arrow_forward_ios, size: 18,),
                        )
                            : ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true, itemBuilder: (BuildContext context, int index){
                              Test test = testModel.testList[index];
                              return ListTile(
                                onTap: (){
                                  Route route = new MaterialPageRoute(builder: (context)=>ViewReport(path: testModel.attachmentsResults,name: testModel.orderId,));
                                  Navigator.push(context, route);
                                },
                                title: Container(
                                  margin: EdgeInsets.only(left: 16,bottom: 6),
                                    child: Text(test.testName.trim(),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                subtitle: Container(
                                  margin: EdgeInsets.only(left: 16),
                                    child: Text(test.fee)),
                                trailing: Icon(Icons.arrow_forward_ios, size: 18,),
                              );
                            },itemCount: testModel.testList.length,)
                    )
                  ],
                ),
              );
            },
            itemCount: orders.length,
          ),
        ): Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            "Test not found",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.grey),
          ),
        ),
      ],
    );
  }

  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      List<TestModel> dummyListData = List<TestModel>();
      bool isAdded= false;
      ordersModel.forEach((item) {

        if (item.testList != null){
          item.testList.forEach((element) {
            String name = element.testName.toLowerCase();

            if(name.contains(query.toLowerCase()) && !isAdded) {
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