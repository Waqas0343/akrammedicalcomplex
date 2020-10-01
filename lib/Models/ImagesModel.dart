import 'dart:convert';

import 'Meta.dart';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  Meta meta;
  ImagePath response;

  ImageModel({
    this.meta,
    this.response,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    meta: Meta.fromJson(json["Meta"]),
    response: ImagePath.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Meta": meta.toJson(),
    "Response": response.toJson(),
  };
}

class ImagePath {
  String path;

  ImagePath({
    this.path,
  });

  factory ImagePath.fromJson(Map<String, dynamic> json) => ImagePath(
    path: json["Response"],
  );

  Map<String, dynamic> toJson() => {
    "Response": path,
  };
}
