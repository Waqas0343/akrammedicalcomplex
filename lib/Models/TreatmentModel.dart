// To parse this JSON data, do
//
//     final treatmentModel = treatmentModelFromJson(jsonString);

import 'dart:convert';

import 'package:amc/Models/ServicesModel.dart';
import 'package:flutter/material.dart';

TreatmentModel treatmentModelFromJson(String str) => TreatmentModel.fromJson(json.decode(str));

String treatmentModelToJson(TreatmentModel data) => json.encode(data.toJson());

class TreatmentModel {
  TreatmentModel({
    this.response,
  });

  TreatmentModelResponse response;

  factory TreatmentModel.fromJson(Map<String, dynamic> json) => TreatmentModel(
    response: TreatmentModelResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response.toJson(),
  };
}

class TreatmentModelResponse {
  TreatmentModelResponse({
    this.response,
  });

  List<TreatmentData> response;

  factory TreatmentModelResponse.fromJson(Map<String, dynamic> json) => TreatmentModelResponse(
    response: List<TreatmentData>.from(json["Response"].map((x) => TreatmentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class TreatmentData {
  TreatmentData({
    this.id,
    this.patientUsername,
    this.patientName,
    this.details,
    this.status,
    this.scheduledDate,
    this.location,
    this.type,
  });

  String id;
  String patientUsername;
  String patientName;
  List<ServiceModel> details;
  String status;
  String scheduledDate;
  String location;
  String type;
  bool isExpanded = false;

  factory TreatmentData.fromJson(Map<String, dynamic> json) => TreatmentData(
    id: json["ID"],
    patientUsername: json["PatientUsername"],
    patientName: json["PatientName"],
    details: List<ServiceModel>.from(jsonDecode(json["Details"]).map((x) => ServiceModel.fromJson(x))),
    status: json["Status"],
    scheduledDate: json["ScheduledDate"],
    location: json["Location"],
    type: json["Type"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "PatientUsername": patientUsername,
    "PatientName": patientName,
    "Details": details,
    "Status": status,
    "ScheduledDate": scheduledDate,
    "Location": location,
    "Type": type,
  };

  Color getStatusColor(){
    Color color;
    if (status != null){
      if (status.trim().isNotEmpty){
        if (status.toLowerCase() == "accepted"){
          color = Colors.blue;
        } else if (status.toLowerCase() == "pending"){
          color = Colors.orange;
        } else if (status.toLowerCase() == "cancelled"){
          color = Colors.red;
        } else if (status.toLowerCase() == "completed"){
          color = Colors.green;
        } else {
          color = Colors.orange;
        }
      } else {
        color = Colors.orange;
      }
    } else {
      color = Colors.orange;
    }
    return color;
  }
}
