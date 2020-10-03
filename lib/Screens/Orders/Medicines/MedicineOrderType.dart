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
            margin: EdgeInsets.fromLTRB(4, 8, 4, 4),
            elevation: 6,
            child: InkWell(
              onTap: (){
                Route route = MaterialPageRoute(builder: (_) => MedicineOrderPlace(false));
                Navigator.push(context, route);
              },
              borderRadius: BorderRadius.circular(4),
              child: ListTile(
                leading: Icon(MdiIcons.medicalBag, color: MyColors.primary, size: 38,),
                title: Text("Select Medicines", style: TextStyle(fontFamily: "SemiBold", fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey,),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
            elevation: 6,
            child: InkWell(
              onTap: (){
                Route route = MaterialPageRoute(builder: (_) => MedicineOrderPlace(true));
                Navigator.push(context, route);
              },
              borderRadius: BorderRadius.circular(4),
              child: ListTile(
                leading: Icon(MdiIcons.upload, color: MyColors.primary, size: 38,),
                title: Text("Upload Prescription", style: TextStyle(fontFamily: "SemiBold", fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}