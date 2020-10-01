
import 'dart:convert';

import 'Meta.dart';

HealthRecordModel medicalRecordModelFromJson(String str) => HealthRecordModel.fromJson(json.decode(str));

String medicalRecordModelToJson(HealthRecordModel data) => json.encode(data.toJson());

class HealthRecordModel {
  Meta meta;
  HealthRecordModelList healthRecordList;

  HealthRecordModel({
    this.meta,
    this.healthRecordList,
  });

  factory HealthRecordModel.fromJson(Map<String, dynamic> json) => HealthRecordModel(
    meta: Meta.fromJson(json["Meta"]),
    healthRecordList: HealthRecordModelList.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Meta": meta.toJson(),
    "Response": healthRecordList.toJson(),
  };
}

class HealthRecordModelList {
  List<HealthRecord> records;

  HealthRecordModelList({
    this.records,
  });

  factory HealthRecordModelList.fromJson(Map<String, dynamic> json) => HealthRecordModelList(
    records: List<HealthRecord>.from(json["Response"].map((x) => HealthRecord.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(records.map((x) => x.toJson())),
  };
}

class HealthRecord {
  List<SharedWith> sharedWithUsernameAndName;
  int id;
  String username;
  String fileName;
  String filePath;
  String recordType;
  String description;
  String timeStamp;
  String timeStampShort;
  bool isSelected = false;

  HealthRecord({
    this.sharedWithUsernameAndName,
    this.id,
    this.username,
    this.fileName,
    this.filePath,
    this.recordType,
    this.description,
    this.timeStamp,
    this.timeStampShort,
  });

  factory HealthRecord.fromJson(Map<String, dynamic> json) => HealthRecord(
    sharedWithUsernameAndName: json.containsKey("SharedWithUsernameAndName")
        ? List<SharedWith>.from(json["SharedWithUsernameAndName"].map((x) => SharedWith.fromJson(x)))
        : [],
    id: json["ID"],
    username: json["Username"],
    fileName: json["FileName"],
    filePath: json["FilePath"],
    recordType: json["RecordType"],
    description: json["Description"] == null ? null : json["Description"],
    timeStamp: json["TimeStamp"],
    timeStampShort: json["TimeStamp_Short"],
  );

  Map<String, dynamic> toJson() => {
    "SharedWithUsernameAndName": List<dynamic>.from(sharedWithUsernameAndName.map((x) => x.toJson())),
    "ID": id,
    "Username": username,
    "FileName": fileName,
    "FilePath": filePath,
    "RecordType": recordType,
    "Description": description == null ? null : description,
    "TimeStamp": timeStamp,
    "TimeStamp_Short": timeStampShort,
  };
}

class SharedWith {
  String username;
  String name;

  SharedWith({
    this.username,
    this.name,
  });

  factory SharedWith.fromJson(Map<String, dynamic> json) => SharedWith(
    username: json["Username"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Name": name,
  };
}
