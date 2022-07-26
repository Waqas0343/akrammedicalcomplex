// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.response,
  });

  ProfileModelResponse? response;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        response: ProfileModelResponse.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": response!.toJson(),
      };
}

class ProfileModelResponse {
  ProfileModelResponse({
    this.response,
  });

  Profile? response;

  factory ProfileModelResponse.fromJson(Map<String, dynamic> json) =>
      ProfileModelResponse(
        response: Profile.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": response!.toJson(),
      };
}

class Profile {
  Profile({this.address, this.user, this.humanUser, required this.mrNo});

  Address? address;
  User? user;
  HumanUser? humanUser;
  String mrNo;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        address: Address.fromJson(json["Address"]),
        user: User.fromJson(json["User"]),
        humanUser: HumanUser.fromJson(json["humanUser"]),
        mrNo: json['MrNo'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Address": address!.toJson(),
        "User": user!.toJson(),
        "humanUser": humanUser!.toJson(),
        "MrNo": mrNo,
      };
}

class Address {
  Address({
    this.area,
    this.location,
    this.city,
    this.latitude,
    this.longitude,
  });

  String? area;
  String? location;
  String? city;
  dynamic latitude;
  dynamic longitude;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        area: json["Area"],
        location: json["Location"],
        city: json["City"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
      );

  Map<String, dynamic> toJson() => {
        "Area": area,
        "Location": location,
        "City": city,
        "Latitude": latitude,
        "Longitude": longitude,
      };
}

class HumanUser {
  HumanUser({
    this.username,
    this.gender,
    this.dateOfBirth,
    this.cnic,
    this.bloodGroup,
    this.height,
    this.weight,
    this.bmi,
    this.bsa,
    this.age,
    this.maritalStatus,
    this.religion,
    this.profession,
    this.nationality,
    this.salutation,
  });

  String? username;
  dynamic gender;
  String? dateOfBirth;
  String? cnic;
  String? bloodGroup;
  String? height;
  String? weight;
  String? bmi;
  dynamic bsa;
  int? age;
  String? maritalStatus;
  String? religion;
  String? profession;
  String? nationality;
  String? salutation;

  factory HumanUser.fromJson(Map<String, dynamic> json) => HumanUser(
        username: json["Username"],
        gender: json["Gender"],
        dateOfBirth: json["DateOfBirth"],
        cnic: json["CNIC"],
        bloodGroup: json["BloodGroup"],
        height: json["Height"],
        weight: json["Weight"],
        bmi: json["BMI"],
        bsa: json["BSA"],
        age: json["Age"],
        maritalStatus: json["MaritalStatus"],
        religion: json["Religion"],
        profession: json["Profession"],
        nationality: json["Nationality"],
        salutation: json["salutation"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "Gender": gender,
        "DateOfBirth": dateOfBirth,
        "CNIC": cnic,
        "BloodGroup": bloodGroup,
        "Height": height,
        "Weight": weight,
        "BMI": bmi,
        "BSA": bsa,
        "Age": age,
        "MaritalStatus": maritalStatus,
        "Religion": religion,
        "Profession": profession,
        "Nationality": nationality,
        "salutation": salutation,
      };
}

class User {
  User(
      {this.username,
      this.title,
      this.gender,
      this.name,
      this.phone,
      this.cnic,
      this.imagePath,
      this.email,
      this.dateofbirth,
      this.bloodgroup,
      this.height,
      this.weight,
      this.profession});

  String? username;
  String? title;
  dynamic gender;
  String? name;
  String? phone;
  String? cnic;
  String? imagePath;
  String? email;
  String? dateofbirth;
  String? bloodgroup;
  String? height;
  String? weight;
  String? profession;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["Username"],
        title: json["Title"],
        gender: json["Gender"],
        name: json["Name"],
        phone: json["Phone"],
        cnic: json["CNIC"],
        imagePath: json["ImagePath"],
        email: json["Email"],
        dateofbirth: json["dateofbirth"],
        bloodgroup: json["Bloodgroup"],
        height: json["Height"],
        weight: json["Weight"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "Title": title,
        "Gender": gender,
        "Name": name,
        "Phone": phone,
        "CNIC": cnic,
        "ImagePath": imagePath,
        "Email": email,
        "dateofbirth": dateofbirth,
        "Bloodgroup": bloodgroup,
        "Height": height,
        "Weight": weight,
      };
}
