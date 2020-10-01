// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

ServicesModel servicesModelFromJson(String str) => ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());

class ServicesModel {
  ServicesModel({
    this.meta,
    this.response,
  });

  Meta meta;
  ServicesModelResponse response;

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
    meta: Meta.fromJson(json["Meta"]),
    response: ServicesModelResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Meta": meta.toJson(),
    "Response": response.toJson(),
  };
}

class Meta {
  Meta({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}

class ServicesModelResponse {
  ServicesModelResponse({
    this.response,
  });

  List<ServiceModel> response;

  factory ServicesModelResponse.fromJson(Map<String, dynamic> json) => ServicesModelResponse(
    response: List<ServiceModel>.from(json["Response"].map((x) => ServiceModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class ServiceModel {
  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.fee,
    this.serviceId,
  });

  String id;
  String name;
  String description;
  String fee;
  String serviceId;

  bool isSelected = false;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json["ID"],
    name: json["Name"],
    description: json["Description"] == null ? null : json["Description"],
    fee: json["Fee"],
    serviceId: json["service_id"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Description": description == null ? null : description,
    "Fee": fee,
    "service_id": serviceId
  };
}
