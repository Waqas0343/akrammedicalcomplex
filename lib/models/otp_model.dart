// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_utils/src/get_utils/get_utils.dart';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
    this.meta,
    this.response,
  });

  Meta? meta;
  OtpModelResponse? response;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        meta: Meta.fromJson(json["Meta"]),
        response: OtpModelResponse.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Meta": meta!.toJson(),
        "Response": response!.toJson(),
      };
}

class Meta {
  Meta({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}

class OtpModelResponse {
  OtpModelResponse({
    this.response,
  });

  OTPResponse? response;

  factory OtpModelResponse.fromJson(Map<String, dynamic> json) =>
      OtpModelResponse(
        response: OTPResponse.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": response!.toJson(),
      };
}

class OTPResponse {
  OTPResponse({
    this.otpCode,
    this.userList,
    this.message,
  });

  int? otpCode;
  List<UserShortModel>? userList;

  String? message;

  factory OTPResponse.fromJson(Map<String, dynamic> json) => OTPResponse(
        otpCode: json["OTPCode"],
        userList: GetUtils.isNullOrBlank(json["UserList"])!
            ? []
            : List<UserShortModel>.from(
                json["UserList"].map((x) => UserShortModel.fromJson(x))),
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "OTPCode": otpCode,
        "UserList": List<dynamic>.from(userList!.map((x) => x.toJson())),
        "Message": message,
      };
}

class UserShortModel {
  UserShortModel({
    this.name,
    this.phone,
    this.username,
    this.password,
  });

  String? name;
  String? phone;
  String? username;
  String? password;

  factory UserShortModel.fromJson(Map<String, dynamic> json) => UserShortModel(
        name: json["Name"],
        phone: json["Phone"],
        username: json["Username"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Phone": phone,
        "Username": username,
        "Password": password,
      };

  factory UserShortModel.fromMap(Map<String, dynamic> json) => UserShortModel(
        name: json["Name"],
        phone: json["Phone"],
        username: json["Username"],
        password: json["Password"],
      );

  Map<String, dynamic> toMap() => {
        "Name": name,
        "Phone": phone,
        "Username": username,
        "Password": password,
      };
}
