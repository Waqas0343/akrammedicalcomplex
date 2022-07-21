import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/material.dart';

class MyLabTestReports extends StatefulWidget {
  const MyLabTestReports({Key? key}) : super(key: key);

  @override
  _MyLabTestReportsState createState() => _MyLabTestReportsState();
}

class _MyLabTestReportsState extends State<MyLabTestReports> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
  
  @override
  void initState() {
    super.initState();
    getReports();
  }

  void getReports() async{

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    String username = preferences.getString(Keys.USERNAME);
    if (!await Utilities.isOnline()){
      Utilities.internetNotAvailable(context);
      return;
    }
    
    Loading.build(context, true);
    
    
//    String response = await Utilities.httpGet(ServerConfig.LAB_REPORTS+"&patient=$username");
    Loading.dismiss();
  }
}
