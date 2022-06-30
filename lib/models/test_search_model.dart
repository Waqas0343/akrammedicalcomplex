// To parse this JSON data, do
//
//     final searchLabTestModel = searchLabTestModelFromJson(jsonString);

import 'dart:convert';

SearchLabTestModel searchLabTestModelFromJson(String str) => SearchLabTestModel.fromJson(json.decode(str));

String searchLabTestModelToJson(SearchLabTestModel data) => json.encode(data.toJson());

class SearchLabTestModel {
  SearchLabTestModel({
    this.response,
  });

  SearchLabTestModelResponse? response;

  factory SearchLabTestModel.fromJson(Map<String, dynamic> json) => SearchLabTestModel(
    response: SearchLabTestModelResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response!.toJson(),
  };
}

class SearchLabTestModelResponse {
  SearchLabTestModelResponse({
    this.response,
  });

  ResponseResponse? response;

  factory SearchLabTestModelResponse.fromJson(Map<String, dynamic> json) => SearchLabTestModelResponse(
    response: ResponseResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response!.toJson(),
  };
}

class ResponseResponse {
  ResponseResponse({
    this.totalItems,
    this.testsList,
  });

  int? totalItems;
  List<Test>? testsList;

  factory ResponseResponse.fromJson(Map<String, dynamic> json) => ResponseResponse(
    totalItems: json["TotalItems"],
    testsList: List<Test>.from(json["TestsList"].map((x) => Test.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalItems": totalItems,
    "TestsList": List<dynamic>.from(testsList!.map((x) => x.toJson())),
  };
}

class Test {
  Test({
    this.id,
    this.testId,
    this.testName,
    this.sampleRequired,
    this.description,
    this.views,
    this.fee,
  });

  String? id;
  String? testId;
  String? testName;
  String? sampleRequired;
  String? description;
  String? views;
  String? fee;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    id: json["ID"],
    testId: json["TestID"],
    testName: json["TestName"],
    sampleRequired: json["SampleRequired"],
    description: json["Description"],
    views: json["Views"],
    fee: json["Fee"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TestID": testId,
    "TestName": testName,
    "SampleRequired": sampleRequired,
    "Description": description,
    "Views": views,
    "Fee": fee,
  };
}
