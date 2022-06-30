import 'dart:convert';
import 'meta.dart';


OtcMedicines otcMedicinesFromJson(String str) => OtcMedicines.fromJson(json.decode(str));

String otcMedicinesToJson(OtcMedicines data) => json.encode(data.toJson());

class OtcMedicines {
  Meta meta;
  OtcMedicinesResponse response;

  OtcMedicines({
    this.meta,
    this.response,
  });

  factory OtcMedicines.fromJson(Map<String, dynamic> json) => OtcMedicines(
    meta: Meta.fromJson(json["Meta"]),
    response: OtcMedicinesResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Meta": meta.toJson(),
    "Response": response.toJson(),
  };
}

class OtcMedicinesResponse {
  List<ProductDetail> otcMedicines;

  OtcMedicinesResponse({
    this.otcMedicines,
  });

  factory OtcMedicinesResponse.fromJson(Map<String, dynamic> json) => OtcMedicinesResponse(
    otcMedicines: List<ProductDetail>.from(json["Response"].map((x) => ProductDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(otcMedicines.map((x) => x)),
  };
}

class ProductDetail {
  String id;
  String name;
  String price;
  String company;
  String category;
  bool isFeatured;
  dynamic addedOn;
  String img;

  ProductDetail({
    this.id,
    this.name,
    this.price,
    this.company,
    this.category,
    this.isFeatured,
    this.addedOn,
    this.img,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    company: json["company"],
    category: json["category"],
    isFeatured: json["isFeatured"],
    addedOn: json["added_on"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "company": company,
    "category": category,
    "isFeatured": isFeatured,
    "added_on": addedOn,
    "img": img,
  };

  @override
  String toString() {
    return name;
  }


}