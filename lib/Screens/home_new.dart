import 'package:amc/Screens/AppDrawer.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeNew extends StatefulWidget {
  @override
  _HomeNewState createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  String name, email, imagePath, oldId;
  SharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: AppDrawer(
        name: name,imagePath: imagePath,email: email,
      ),
      appBar: AppBar(

      ),
      body: Stack(
        children: [
          Image.asset(MyImages.banner,
            fit: BoxFit.cover,height: 200,width: size.width,),
          Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.only(top: 170.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32))
            ),
            child: ListView(
              padding: EdgeInsets.only(
                top: 24,
                left: 16,
                right: 16,
              ),
              children: [
                Row(children: [
                  Column(
                    children: [
                      SvgPicture.asset(MyIcons.icTreatment, height: 48,),
                      SizedBox(height: 6,),
                      Text("Book Home \nServices", textAlign: TextAlign.center,)
                    ],
                  )

                ],),

            ],),
          )
        ],
      ),
    );
  }

  void getUpdate() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      name = preferences.getString(Keys.name);
      email = preferences.getString(Keys.email);
      imagePath = preferences.getString(Keys.image);

    });
  }
}
