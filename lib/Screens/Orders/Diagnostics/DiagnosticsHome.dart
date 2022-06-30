import 'package:amc/Screens/Orders/Diagnostics/TestType.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:amc/Screens/Orders/Diagnostics/MyLabTestOrders.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiagnosticsHome extends StatelessWidget {
  const DiagnosticsHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Diagnostics"),
      ),
      body: ListView(children: [
        Card(
          margin: const EdgeInsets.all(0),
          elevation: 6,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            leading: SvgPicture.asset(MyIcons.icBookLabTest, height: 45, width: 45,),
            title: const Text("Book Lab Test", style: TextStyle(fontWeight: FontWeight.bold),),
            trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            onTap: (){
              Route route = MaterialPageRoute(builder: (_)=> LabTestType());
              Navigator.push(context, route);
            },
          ),
        ),
        const SizedBox(height: 8,),
        Card(
          margin: const EdgeInsets.all(0),
          elevation: 6,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            leading: SvgPicture.asset(MyIcons.icOrders, height: 45, width: 45,fit: BoxFit.cover,),
            title: const Text("My Orders", style: TextStyle(fontWeight: FontWeight.bold),),
            trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            onTap: (){
              Route route = MaterialPageRoute(builder: (_)=>MyLabTestOrders());
              Navigator.push(context, route);
            },
          ),
        ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: (){
            Utilities.showToast("Coming Soon...");
          },
          child: Card(
            margin: const EdgeInsets.all(0),
            elevation: 6,
            color: Colors.grey.shade100,
            child: ListTile(
              enabled: false,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              leading: SvgPicture.asset(MyIcons.icReports, height: 45, width: 45,),
              title: const Text("View Reports", style: TextStyle(fontWeight: FontWeight.bold),),
              trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            ),
          ),
        ),

      ],
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }
}
