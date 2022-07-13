import 'dart:convert';

CategoryJsonResponse categoryFromJson(String str) =>
    CategoryJsonResponse.fromJson(json.decode(str));

String categoryToJson(CategoryJsonResponse data) => json.encode(data.toJson());

class CategoryJsonResponse {
  CategoryList? response;

  CategoryJsonResponse({
    this.response,
  });

  factory CategoryJsonResponse.fromJson(Map<String, dynamic> json) =>
      CategoryJsonResponse(
        response: CategoryList.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": response!.toJson(),
      };
}

class CategoryList {
  List<Category>? categoryList;

  CategoryList({
    this.categoryList,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        categoryList: List<Category>.from(
            json["Response"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Response": List<dynamic>.from(categoryList!.map((x) => x.toJson())),
      };
}

class Category {
  int? id;
  String? totalConsultants;
  String name;
  String? tag;
  String? popularity;
  String? imagePath;
  String? about;

  Category({
    required this.id,
    this.totalConsultants,
    required this.name,
    this.tag,
    this.popularity,
    this.imagePath,
    this.about,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["ID"],
        totalConsultants: json["TotalConsultants"],
        name: json["Name"],
        tag: json["Tags"] ?? "",
        popularity: json["Popularity"],
        imagePath: json["ImagePath"] ?? "",
        about: json["About"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "TotalConsultants": totalConsultants,
        "ID": id,
        "Name": name,
        "Tags": tag ?? "",
        "Popularity": popularity,
        "ImagePath": imagePath ?? "",
        "About": about ?? "",
      };
}
