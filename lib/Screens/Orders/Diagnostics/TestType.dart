import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'BookLabTest.dart';

class LabTestType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Order Type"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
            elevation: 4,
            child: InkWell(
              onTap: (){
                Route route = MaterialPageRoute(builder: (_) => BookLabTest(false));
                Navigator.push(context, route);
              },
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: SvgPicture.asset(MyIcons.icTubeAdd, height: 38, width: 38,color: MyColors.accent,),
                  title: Text("Select Test(s)"),
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
                Route route = MaterialPageRoute(builder: (_) => BookLabTest(true));
                Navigator.push(context, route);
              },
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(MdiIcons.upload, color: MyColors.accent, size: 38,),
                  title: Text("Upload Prescription"),
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
