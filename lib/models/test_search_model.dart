import 'dart:convert';
import 'activation_model.dart';

SearchLabTestModel searchLabTestModelFromJson(String str) =>
    SearchLabTestModel.fromJson(json.decode(str));

String searchLabTestModelToJson(SearchLabTestModel data) =>
    json.encode(data.toJson());

class SearchLabTestModel {
  SearchLabTestModel({
    this.meta,
    this.response,
  });

  Meta? meta;
  SearchLabTestModelResponse? response;

  factory SearchLabTestModel.fromJson(Map<String, dynamic> json) =>
      SearchLabTestModel(
        meta: Meta.fromJson(json["Meta"]),
        response: SearchLabTestModelResponse.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
    "Meta": meta!.toJson(),
    "Response": response!.toJson(),
  };
}

class SearchLabTestModelResponse {
  SearchLabTestModelResponse({
    this.response,
  });

  List<Test>? response;

  factory SearchLabTestModelResponse.fromJson(Map<String, dynamic> json) =>
      SearchLabTestModelResponse(
        response:
        List<Test>.from(json["Response"].map((x) => Test.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(response!.map((x) => x.toJson())),
  };
}

class ResponseResponse {
  ResponseResponse({
    this.totalItems,
    this.testsList,
  });

  int? totalItems;
  List<Test>? testsList;

  factory ResponseResponse.fromJson(Map<String, dynamic> json) =>
      ResponseResponse(
        totalItems: json["TotalItems"],
        testsList:
        List<Test>.from(json["TestsList"].map((x) => Test.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "TotalItems": totalItems,
    "TestsList": List<dynamic>.from(testsList!.map((x) => x.toJson())),
  };
}

class Test {
  Test({
    this.id,
    this.labId,
    this.testId,
    this.testName,
    this.fee,
    this.reportingDays,
    this.sampleRequired,
    this.description,
    this.views,
    this.imagePath,
    this.labName,
    this.discount,
    this.discountType,
    this.city,
    this.homeSample,
    this.category,
    this.permaLink,
    this.slug,
    this.min,
    this.max,
    this.discountedPrice,
    this.onboard,
    this.phone,
    this.knownAs,
    this.email,
    productQuantity,
  });

  String? id;
  String? labId;
  String? testId;
  String? testName;
  String? fee;
  String? reportingDays;
  String? sampleRequired;
  String? description;
  String? views;
  String? imagePath;
  String? labName;
  String? discount;
  String? discountType;
  String? city;
  bool? homeSample;
  String? category;
  String? permaLink;
  String? slug;
  int? min;
  int? max;
  String? discountedPrice;
  bool? onboard;
  String? phone;
  String? knownAs;
  String? email;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    id: json.containsKey('ID') ? json["ID"] : json['unique_key'],
    labId: json.containsKey('LabID') ? json["LabID"] : json['lab_id'],
    testId:
    json.containsKey('TestID') ? json["TestID"] : json['product_id'],
    testName: json.containsKey('TestName')
        ? json["TestName"]
        : json['product_name'],
    fee: json.containsKey('fee')
        ? json["fee"]
        : (int.tryParse(json['discounted_price'])! +
        int.tryParse(json['product_price']
            .toString()
            .replaceAll("Rs/-", ''))!)
        .toString(),
    reportingDays: json["ReportingDays"],
    sampleRequired: json["SampleRequired"],
    description: json["description"],
    views: json["views"],
    imagePath: json["ImagePath"],
    productQuantity: json["ProductQuantity"],
    labName:
    json.containsKey('LabName') ? json["LabName"] : json['lab_name'],
    discount: json.containsKey('Discount')
        ? json["Discount"] ?? "0"
        : json.containsKey('discounted_price')
        ? json['discounted_price'] ?? "0"
        : "0",
    discountType: json["DiscountType"],
    city: json["City"],
    homeSample: json["HomeSample"],
    category: json["Category"],
    permaLink: json["PermaLink"],
    slug: json["Slug"],
    min: json["Min"],
    max: json["Max"],
    discountedPrice: json.containsKey('DiscountedPrice')
        ? json["DiscountedPrice"]
        : json['product_price'],
    onboard: json["Onboard"],
    phone: json.containsKey('Phone') ? json["Phone"] : json['lab_phone'],
    knownAs: json["KnownAs"],
    email: json.containsKey('Email') ? json["Email"] : json['lab_email'],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "LabID": labId,
    "TestID": testId,
    "TestName": testName,
    "fee": fee,
    "ReportingDays": reportingDays,
    "SampleRequired": sampleRequired,
    "description": description,
    "views": views,
    "ImagePath": imagePath,
    "LabName": labName,
    "Discount": discount,
    "DiscountType": discountType,
    "City": city,
    "HomeSample": homeSample,
    "Category": category,
    "PermaLink": permaLink,
    "Slug": slug,
    "Min": min,
    "Max": max,
    "DiscountedPrice": discountedPrice,
    "Onboard": onboard,
    "Phone": phone,
    "KnownAs": knownAs,
    "Email": email,
  };
}

class MyTestOrderModel {
  MyTestOrderModel({
    this.productId,
    this.labId,
    this.labName,
    required this.productName,
    this.productPrice,
    this.labPhone,
    this.labEmail,
    this.discountRate,
    this.productQuantity,
    this.uniqueKey,
    this.isNewJson = false,
  });

  String? productId;
  String? labId;
  String? labName;
  String productName;
  String? productPrice; // it is discounted price
  String? labPhone;
  String? labEmail;
  String? discountRate;
  int? productQuantity;
  String? uniqueKey;
  bool isNewJson;

  factory MyTestOrderModel.fromJson(Map<String, dynamic> json) =>
      MyTestOrderModel(
        productId: json.containsKey('product_id')
            ? json["product_id"]
            : json['TestID'],
        labId: json.containsKey('lab_id') ? json["lab_id"] : json['LabID'],
        labName:
        json.containsKey("lab_name") ? json["lab_name"] : json['LabName'],
        productName: json.containsKey('product_name')
            ? json["product_name"]
            : json['TestName'] ?? "N/A",
        productPrice: getProductPrice(json),
        labPhone:
        json.containsKey('lab_phone') ? json["lab_phone"] : json['Phone'],
        labEmail:
        json.containsKey('lab_email') ? json["lab_email"] : json['Email'],
        discountRate: calculateDiscountPrice(json),
        isNewJson: hasNewFormat(json),
        productQuantity: json.containsKey('product_quantity')
            ? int.tryParse(json["product_quantity"].toString())
            : 1,
        uniqueKey: json.containsKey('unique_key')
            ? json["unique_key"].toString()
            : json['ID'],
      );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "lab_id": labId,
    "lab_name": labName,
    "product_name": productName,
    "product_price": productPrice,
    "lab_phone": labPhone,
    "lab_email": labEmail,
    "discounted_price": discountRate,
    "product_quantity": productQuantity,
    "unique_key": uniqueKey,
  };

  int get price => getInteger(productPrice) + (isNewJson ? 0 : discountPrice);

  int get priceDiscounted => getInteger(productPrice) - (isNewJson ? discountPrice : 0);

  int get discountPrice {return ((discountPercent / 100) * getInteger(productPrice)).toInt();
  }
  int get discountPercent => getInteger(discountRate);

  int getInteger(String? value) {
    if (value == null) return 0;
    int? response = int.tryParse(value);
    response ??= double.tryParse(value)?.round();
    return response ?? 0;
  }
}

String getProductPrice(Map<String, dynamic> json) {
  if (json.containsKey("price")) {
    return json['price'];
  }
  for (var element in ["product_price", "DiscountedPrice", "Fee"]) {
    if (json.containsKey(element)) {
      return json[element];
    }
  }
  return "0";
}

String calculateDiscountPrice(Map<String, dynamic> json) {
  if (json.containsKey("discounts")) {
    if (json['discounts'].isNotEmpty) {
      return json['discounts'][0]["value"].toString();
    }
  }

  for (var element in ["discounted_price", "Discount"]) {
    if (json.containsKey(element)) {
      return json[element];
    }
  }
  return "value";
}

bool hasNewFormat(Map<String, dynamic> json) => json.containsKey("price");

/*
bool? isNewJsonData(Map<String, dynamic> json) {
  if (json.containsKey("price")) {
    if (json['price'].isNotEmpty) {
      return true;
    }
  }
  return false;
}
 */
