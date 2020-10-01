import 'package:amc/Database/Database.dart';
import 'package:amc/Models/NotificationModel.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  DatabaseManager dbManager = new DatabaseManager();

  List<NotificationModel> notifications;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: notifications.isNotEmpty
          ? notificationView()
          : Center(child: Text("No Notification", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
    );
  }

  Widget notificationView(){
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 4),
      itemBuilder: (BuildContext context, int index){
        NotificationModel notification = notifications[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          elevation: 4,
          child: ListTile(
            title: Text(notification.title??"", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(notification.description??""),
          ),
        );
      }, itemCount: notifications.length,
    );
  }

  @override
  void initState() {
    super.initState();
    notifications = [];
    dbManager.initializeDatabase();
    updateUi();
  }

  void updateUi()async{
    var list = await dbManager.getNotification();
    setState(() {
      notifications.addAll(list);
    });
  }
}
