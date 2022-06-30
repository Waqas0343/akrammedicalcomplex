// To parse this JSON data, do
//
//     final timeSlotModel = timeSlotModelFromJson(jsonString);

import 'dart:convert';

TimeSlotModel timeSlotModelFromJson(String str) => TimeSlotModel.fromJson(json.decode(str));

String timeSlotModelToJson(TimeSlotModel data) => json.encode(data.toJson());

class TimeSlotModel {
  TimeSlotModel({
    this.response,
  });

  TimeSlotModelResponse response;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
    response: TimeSlotModelResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response.toJson(),
  };
}


class TimeSlotModelResponse {
  TimeSlotModelResponse({
    this.response,
  });

  List<TimeSlot> response;

  factory TimeSlotModelResponse.fromJson(Map<String, dynamic> json) => TimeSlotModelResponse(
    response: List<TimeSlot>.from(json["Response"].map((x) => TimeSlot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class TimeSlot {
  TimeSlot({
    this.date,
    this.timeSlots,
  });

  String date;
  bool isSelected = false;
  List<String> timeSlots;

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
    date: json["Date"],
    timeSlots: List<String>.from(json["TimeSlots"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Date": date,
    "TimeSlots": List<dynamic>.from(timeSlots.map((x) => x)),
  };
}
