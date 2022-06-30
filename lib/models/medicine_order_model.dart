import 'dart:convert';
import 'package:flutter/material.dart';

import 'meta.dart';

MedicineOrders medicineOrdersFromJson(String str) => MedicineOrders.fromJson(json.decode(str));

String medicineOrdersToJson(MedicineOrders data) => json.encode(data.toJson());

class MedicineOrders {
  Meta? meta;
  MedicineOrdersResponse? response;

  MedicineOrders({
    this.meta,
    this.response,
  });

  factory MedicineOrders.fromJson(Map<String, dynamic> json) => MedicineOrders(
    meta: Meta.fromJson(json["Meta"]),
    response: MedicineOrdersResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Meta": meta!.toJson(),
    "Response": response!.toJson(),
  };
}

class MedicineOrdersResponse {
  List<Order>? orders;

  MedicineOrdersResponse({
    this.orders,
  });

  factory MedicineOrdersResponse.fromJson(Map<String, dynamic> json) => MedicineOrdersResponse(
    orders: List<Order>.from(json["Response"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  String? id;
  String? orderId;
  String? name;
  String? phone;
  String? address;
  String? email;
  String? prescriptionPath;
  String? status;
  String? prescriptionType;
  String? orderDate;
  List<PrescriptionConverterModel>? medicines;
  Orderdetails? orderdetails;
  dynamic postedPrescription;

  Order({
    this.id,
    this.orderId,
    this.name,
    this.phone,
    this.address,
    this.email,
    this.prescriptionPath,
    this.status,
    this.prescriptionType,
    this.orderDate,
    this.medicines,
    this.orderdetails,
    this.postedPrescription,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["ID"],
    orderId: json["OrderId"],
    name: json["Name"],
    phone: json["Phone"],
    address: json["Address"],
    email: json["Email"],
    prescriptionPath: json["PrescriptionPath"],
    status: json["status"],
    prescriptionType: json["PrescriptionType"],
    orderDate: json["OrderDate"],
    medicines: List<PrescriptionConverterModel>.from(jsonDecode(json["PrescriptionString"] == "null" ||
        json["PrescriptionString"] == null  || json["PrescriptionString"].toString().isEmpty ? "[]"
        : json["PrescriptionString"]).map((x) => PrescriptionConverterModel.fromJson(x))),
    orderdetails: Orderdetails.fromJson(json["orderdetails"]),
    postedPrescription: json["PostedPrescription"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "OrderId": orderId,
    "Name": name,
    "Phone": phone,
    "Address": address,
    "Email": email,
    "PrescriptionPath": prescriptionPath,
    "status": status,
    "PrescriptionType": prescriptionType,
    "OrderDate": orderDate,
    "PrescriptionString": List<dynamic>.from(medicines!.map((x) => x.toJson())),
    "orderdetails": orderdetails!.toJson(),
    "PostedPrescription": postedPrescription,
  };

  Color getColor(){
    if (status!.toLowerCase() == "pending"){
      return Colors.blue;
    } else if (status!.toLowerCase() == "cancelled"){
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

}

class Orderdetails {
  String? orderId;
  String? username;
  String? type;
  dynamic foreignId;
  dynamic confirmed;
  String? referencedBy;

  Orderdetails({
    this.orderId,
    this.username,
    this.type,
    this.foreignId,
    this.confirmed,
    this.referencedBy,
  });

  factory Orderdetails.fromJson(Map<String, dynamic> json) => Orderdetails(
    orderId: json["OrderID"],
    username: json["Username"],
    type: json["Type"],
    foreignId: json["ForeignID"],
    confirmed: json["Confirmed"],
    referencedBy: json["ReferencedBy"],
  );

  Map<String, dynamic> toJson() => {
    "OrderID": orderId,
    "Username": username,
    "Type": type,
    "ForeignID": foreignId,
    "Confirmed": confirmed,
    "ReferencedBy": referencedBy,
  };
}

class PrescriptionConverterModel{
  String? productImage;
  String? productName;
  String? productId;
  String? productPrice;
  dynamic productQuantity;
  int? uniqueKey;
  String? formType;



  PrescriptionConverterModel({this.productName, this.productId, this.productImage,this.productPrice, this.productQuantity, this.uniqueKey, this.formType});

  factory PrescriptionConverterModel.fromJson(Map<String, dynamic> json) => PrescriptionConverterModel(
    productName : json.containsKey("Name") ? json["Name"] : json["product_name"],
    productQuantity : json.containsKey("Quantity") ? json["Quantity"] : json["product_quantity"],
    formType : json.containsKey("FormType") ? json["FormType"] : "",
    productPrice : json.containsKey("product_price") ? json["product_price"] : "",
    productId : json.containsKey("product_id") ? json["product_id"] : "",
    productImage : json.containsKey("product_image") ? json["product_image"] : "",
    uniqueKey : json.containsKey("unique_key") ? json["unique_key"] : 0,
  );

  Map<String, dynamic> toJson() => {
    "product_image":productImage,
    "product_name": productName,
    "product_id": productId,
    "product_quantity": productQuantity,
    "product_price": productPrice,
    "unique_key": uniqueKey,
  };
}