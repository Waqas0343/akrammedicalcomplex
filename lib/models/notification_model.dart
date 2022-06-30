import 'package:amc/Styles/Keys.dart';


class NotificationModel {
  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
  });

  int? id;
  String? title;
  String? description;
  String? date;
  String? time;

  factory NotificationModel.fromMap(Map<String, dynamic> json) => NotificationModel(
    id: json[Keys.ID],
    title: json[Keys.title],
    description: json[Keys.description],
    date: json[Keys.date],
    time: json[Keys.time],
  );

  Map<String, dynamic> toMap() => {
    Keys.ID: id,
    Keys.title: title,
    Keys.description: description,
    Keys.date: date,
    Keys.time: time,
  };
}
