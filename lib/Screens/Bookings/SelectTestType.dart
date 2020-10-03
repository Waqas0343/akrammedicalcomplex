import 'package:amc/Screens/Bookings/bookTest.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class TestType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Select Test Type"),
      ),
      body: Column(children: [
        Card(
          elevation: 6,
            margin: EdgeInsets.fromLTRB(4, 8, 4, 4),
          child: ListTile(
            title: Text("Select Test", style: TextStyle(fontFamily: "SemiBold", fontSize: 18),),
            leading: SvgPicture.asset(MyIcons.icCheckList, color: MyColors.primary, height: 28,),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: (){
              Route route = MaterialPageRoute(builder: (_)=>BookTest(isPrescription: false,));
              Navigator.push(context, route);
            },
          )
        ),
        Card(
          elevation: 6,
            margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
          child: ListTile(
            title: Text("Upload Prescription", style: TextStyle(fontFamily: "SemiBold", fontSize: 18),),
            leading: SvgPicture.asset(MyIcons.icUploadDocs, color: MyColors.primary, height: 28,),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: (){
              Route route = MaterialPageRoute(builder: (_)=>BookTest(isPrescription: true,));
              Navigator.push(context, route);
            },
          )
        )
      ],),
    );
  }
}
