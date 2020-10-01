// To parse this JSON data, do
//
//     final testOrderResponseModel = testOrderResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

import 'SearchTeshModel.dart';

TestOrderResponseModel testOrderResponseModelFromJson(String str) => TestOrderResponseModel.fromJson(json.decode(str));

String testOrderResponseModelToJson(TestOrderResponseModel data) => json.encode(data.toJson());

class TestOrderResponseModel {
  TestOrderResponseModel({
    this.response,
  });

  Response response;

  factory TestOrderResponseModel.fromJson(Map<String, dynamic> json) => TestOrderResponseModel(
    response: Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response.toJson(),
  };
}

class Response {
  Response({
    this.response,
  });

  List<TestModel> response;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    response: List<TestModel>.from(json["Response"].map((x) => TestModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class TestModel {
  TestModel({
    this.id,
    this.orderId,
    this.name,
    this.phone,
    this.email,
    this.prescriptionPath,
    this.labId,
    this.location,
    this.area,
    this.city,
    this.testList,
    this.prescriptionType,
    this.status,
    this.datetime,
    this.attachmentsResults,
  });

  int id;
  String orderId;
  String name;
  String phone;
  String email;
  String prescriptionPath;
  String labId;
  String location;
  String area;
  String city;
  List<Test> testList;
  String prescriptionType;
  String status;
  String datetime;
  bool isExpanded = false;
  dynamic attachmentsResults;

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
    id: json["ID"],
    orderId: json["OrderId"],
    name: json["Name"],
    phone: json["Phone"],
    email: json["Email"],
    prescriptionPath: json["PrescriptionPath"] == null
        || json["PrescriptionPath"].toString().trim()=="null"
        || json["PrescriptionPath"].toString().isEmpty ? null : json["PrescriptionPath"],
    labId: json["LabId"],
    location: json["Location"],
    area: json["Area"],
    city: json["City"],
    testList: json["PrescriptionString"] != "null"
        && json["PrescriptionString"].toString().contains("[")
        ? List<Test>.from(jsonDecode(json["PrescriptionString"]).map((x) => Test.fromJson(x)))
        : null,
    prescriptionType: json["PrescriptionType"],
    status: json["Status"],
    datetime: json["Datetime"],
    attachmentsResults: json["Attachments_Results"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "OrderId": orderId,
    "Name": name,
    "Phone": phone,
    "Email": email,
    "PrescriptionPath": prescriptionPath,
    "LabId": labId,
    "Location": location,
    "Area": area,
    "City": city,
    "PrescriptionString": testList,
    "PrescriptionType": prescriptionType,
    "Status": status,
    "Datetime": datetime,
    "Attachments_Results": attachmentsResults,
  };

  Color getColor(){
    if (status.toLowerCase() == "pending"){
      return Colors.blue;
    } else if (status.toLowerCase() == "cancelled"){
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  bool isPrescription(){
    if (testList == null){
      return true;
    } else {
      return false;
    }
  }
}
