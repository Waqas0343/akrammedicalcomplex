// To parse this JSON data, do
//
//     final labModel = labModelFromJson(jsonString);

import 'dart:convert';

import 'Meta.dart';

LabModel labModelFromJson(String str) => LabModel.fromJson(json.decode(str));

String labModelToJson(LabModel data) => json.encode(data.toJson());

class LabModel {
  LabModel({
    this.meta,
    this.response,
  });

  Meta meta;
  LabModelResponse response;

  factory LabModel.fromJson(Map<String, dynamic> json) => LabModel(
    meta: Meta.fromJson(json["Meta"]),
    response: LabModelResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Meta": meta.toJson(),
    "Response": response.toJson(),
  };
}

class LabModelResponse {
  LabModelResponse({
    this.labs,
  });

  List<Lab> labs;

  factory LabModelResponse.fromJson(Map<String, dynamic> json) => LabModelResponse(
    labs: List<Lab>.from(json["Response"].map((x) => Lab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(labs.map((x) => x.toJson())),
  };
}

class Lab {
  Lab({
    this.username,
    this.name,
    this.imagePath,
    this.testsAvailable,
  });

  String username;
  String name;
  String imagePath;
  String testsAvailable;

  factory Lab.fromJson(Map<String, dynamic> json) => Lab(
    username: json["Username"],
    name: json["Name"],
    imagePath: json["ImagePath"],
    testsAvailable: json["tests_available"],
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Name": name,
    "ImagePath": imagePath,
    "tests_available": testsAvailable,
  };
}
