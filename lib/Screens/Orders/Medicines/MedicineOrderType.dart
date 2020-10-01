import 'package:amc/Styles/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'MedicineOrderPlace.dart';

class MedicineOrderType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Select Medicine Type"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
            elevation: 4,
            child: InkWell(
              onTap: (){
                Route route = MaterialPageRoute(builder: (_) => MedicineOrderPlace(false));
                Navigator.push(context, route);
              },
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(MdiIcons.medicalBag, color: MyColors.primary, size: 38,),
                  title: Text("Select Medicines", style: TextStyle(fontFamily: "SemiBold", fontSize: 18),),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18,),
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            elevation: 4,
            child: InkWell(
              onTap: (){
                Route route = MaterialPageRoute(builder: (_) => MedicineOrderPlace(true));
                Navigator.push(context, route);
              },
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(MdiIcons.upload, color: MyColors.primary, size: 38,),
                  title: Text("Upload Prescription", style: TextStyle(fontFamily: "SemiBold", fontSize: 18),),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}