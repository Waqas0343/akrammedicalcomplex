import 'dart:convert';
import 'meta.dart';
import 'lab_test_search_model.dart';

LabTestOrdersModel labTestOrdersModelFromJson(String str) => LabTestOrdersModel.fromJson(json.decode(str));

String labTestOrdersModelToJson(LabTestOrdersModel data) => json.encode(data.toJson());

class LabTestOrdersModel {
  LabTestOrdersModel({
    this.meta,
    this.response,
  });

  Meta? meta;
  LabTestOrdersModelResponse? response;

  factory LabTestOrdersModel.fromJson(Map<String, dynamic> json) => LabTestOrdersModel(
    meta: Meta.fromJson(json["Meta"]),
    response: LabTestOrdersModelResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Meta": meta!.toJson(),
    "Response": response!.toJson(),
  };
}

class LabTestOrdersModelResponse {
  LabTestOrdersModelResponse({
    this.tests,
  });

  List<TestOrder>? tests;

  factory LabTestOrdersModelResponse.fromJson(Map<String, dynamic> json) => LabTestOrdersModelResponse(
    tests: List<TestOrder>.from(json["Response"].map((x) => TestOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(tests!.map((x) => x.toJson())),
  };
}

class TestOrder {
  TestOrder({
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
    this.prescriptionString,
    this.prescriptionType,
    this.status,
    this.datetime,
  });

  int? id;
  String? orderId;
  String? name;
  String? phone;
  String? email;
  String? prescriptionPath;
  String? labId;
  String? location;
  String? area;
  String? city;
  String? prescriptionString;
  List<Test>? testList;
  String? prescriptionType;
  String? status;
  String? datetime;

  factory TestOrder.fromJson(Map<String, dynamic> json) => TestOrder(
    id: json["ID"],
    orderId: json["OrderId"],
    name: json["Name"],
    phone: json["Phone"],
    email: json["Email"],
    prescriptionPath: json["PrescriptionPath"],
    labId: json["LabId"],
    location: json["Location"],
    area: json["Area"],
    city: json["City"],
    prescriptionString: json["PrescriptionString"],
    prescriptionType: json["PrescriptionType"],

    testList: json["PrescriptionString"] != "null"
        && json["PrescriptionString"].toString().contains("[")
        ? List<Test>.from(jsonDecode(json["PrescriptionString"]).map((x) => Test.fromJson(x)))
        : null,

    status: json["Status"],
    datetime: json["Datetime"],
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
    "PrescriptionString": prescriptionString,
    "PrescriptionType": prescriptionType,
    "Status": status,
    "Datetime": datetime,
  };
}
