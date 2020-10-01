import 'package:amc/Screens/Orders/Diagnostics/TestType.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:amc/Screens/Orders/Diagnostics/MyLabTestOrders.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class DiagnosticsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Diagnostics"),
      ),
      body: ListView(children: [
        Card(
          margin: EdgeInsets.all(0),
          elevation: 6,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            leading: SvgPicture.asset(MyIcons.icBookLabTest, height: 45, width: 45,),
            title: Text("Book Lab Test", style: TextStyle(fontWeight: FontWeight.bold),),
            trailing: Icon(Icons.arrow_forward_ios,size: 18,),
            onTap: (){
              Route route = new MaterialPageRoute(builder: (_)=> LabTestType());
              Navigator.push(context, route);
            },
          ),
        ),
        SizedBox(height: 8,),
        Card(
          margin: EdgeInsets.all(0),
          elevation: 6,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            leading: SvgPicture.asset(MyIcons.icOrders, height: 45, width: 45,fit: BoxFit.cover,),
            title: Text("My Orders", style: TextStyle(fontWeight: FontWeight.bold),),
            trailing: Icon(Icons.arrow_forward_ios,size: 18,),
            onTap: (){
              Route route = new MaterialPageRoute(builder: (_)=>MyLabTestOrders());
              Navigator.push(context, route);
            },
          ),
        ),
        SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Utilities.showToast("Coming Soon...");
          },
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: 6,
            color: Colors.grey.shade100,
            child: ListTile(
              enabled: false,
              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              leading: SvgPicture.asset(MyIcons.icReports, height: 45, width: 45,),
              title: Text("View Reports", style: TextStyle(fontWeight: FontWeight.bold),),
              trailing: Icon(Icons.arrow_forward_ios,size: 18,),
            ),
          ),
        ),

      ],
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }
}
