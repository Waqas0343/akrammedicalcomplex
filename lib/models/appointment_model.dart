// To parse this JSON data, do
//
//     final appointments = appointmentsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

AppointmentModel appointmentModelFromJson(String str) => AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) => json.encode(data.toJson());

class AppointmentModel {
  AppointmentsResponse? response;

  AppointmentModel({
    this.response,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
    response: AppointmentsResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response!.toJson(),
  };
}


class AppointmentsResponse {
  List<Appointment>? appointmentList;

  AppointmentsResponse({
    this.appointmentList,
  });

  factory AppointmentsResponse.fromJson(Map<String, dynamic> json) => AppointmentsResponse(
    appointmentList: List<Appointment>.from(json["Response"].map((x) => Appointment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(appointmentList!.map((x) => x.toJson())),
  };
}

class Appointment {
  String? id;
  String? patientUsername;
  String? doctorName;
  String? date;
  String? dateFormatted;
  String? time;
  String? location;
  String? reason;
  String? notes;
  String? status;
  String? doctorImage;
  Color statusColor = Colors.orangeAccent;
  bool? providedByInstacare;

  Appointment({
    this.id,
    this.patientUsername,
    this.doctorName,
    this.date,
    this.dateFormatted,
    this.time,
    this.location,
    this.reason,
    this.notes,
    this.status,
    this.doctorImage,
    this.providedByInstacare,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      Appointment(
        id: json["Id"],
        patientUsername: json["PatientUsername"],
        doctorName: json["DoctorName"],
        date: json["Date"],
        dateFormatted: json["DateFormatted"],
        time: json["Time"],
        location: json["Location"],
        doctorImage: json["DoctorImage"],
        reason: json["Reason"],
        status: json["Status"] == null || json["Status"]
            .toString()
            .trim()
            .isEmpty ? "Unknown" : json["Status"],
        notes: json["Notes"],
        providedByInstacare: json["provided_by_instacare"],
      );

  Map<String, dynamic> toJson() =>
      {
        "Id": id,
        "PatientUsername": patientUsername,
        "DoctorName": doctorName,
        "Date": date,
        "DateFormatted": dateFormatted,
        "Time": time,
        "Location": location,
        "Reason": reason,
        "DoctorImage": doctorImage,
        "Status": status,
        "Notes": notes,
        "provided_by_instacare": providedByInstacare,
      };

  Color getStatusColor() {
    if (status != null) {
      if (status!
          .trim()
          .isNotEmpty) {
        if (status!.toLowerCase() == "pending") {
          return Colors.blue;
        } else if (status!.toLowerCase() == "cancelled") {
          return Colors.red;
        }
      }
    }
    return Colors.green;

  }
}