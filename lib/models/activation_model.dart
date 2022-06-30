// To parse this JSON data, do
//
//     final Update = UpdateFromJson(jsonString);

import 'dart:convert';

Update updateFromJson(String str) => Update.fromJson(json.decode(str));

String updateToJson(Update data) => json.encode(data.toJson());

class Update {
  Update({
    this.meta,
    this.response,
  });

  Meta? meta;
  UpdateResponse? response;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    meta: Meta.fromJson(json["Meta"]),
    response: UpdateResponse.fromJson(json["Response"]),
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

class UpdateResponse {
  UpdateResponse({
    this.response,
  });

  ResponseResponse? response;

  factory UpdateResponse.fromJson(Map<String, dynamic> json) => UpdateResponse(
    response: ResponseResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response!.toJson(),
  };
}

class ResponseResponse {
  ResponseResponse({
    this.username,
    this.type,
    this.timeStamp,
    this.name,
    this.phone,
    this.imagePath,
    this.email,
    this.status,
    this.sessionToken,
    this.authToken,
    this.ipAddress,
    this.facebookId,
    this.googleId,
    this.huDetails,
    this.huAddress,
  });

  String? username;
  String? type;
  String? timeStamp;
  String? name;
  String? phone;
  String? imagePath;
  String? email;
  bool? status;
  String? sessionToken;
  String? authToken;
  dynamic ipAddress;
  String? facebookId;
  dynamic googleId;
  HuDetails? huDetails;
  HuAddress? huAddress;

  factory ResponseResponse.fromJson(Map<String, dynamic> json) => ResponseResponse(
    username: json["Username"],
    type: json["Type"],
    timeStamp: json["TimeStamp"],
    name: json["Name"],
    phone: json["Phone"],
    imagePath: json["ImagePath"],
    email: json["Email"],
    status: json["Status"],
    sessionToken: json["SessionToken"],
    authToken: json["AuthToken"],
    ipAddress: json["IPAddress"],
    facebookId: json["facebook_id"],
    googleId: json["google_id"],
    huDetails: HuDetails.fromJson(json["hu_details"]),
    huAddress: HuAddress.fromJson(json["hu_address"]),
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Type": type,
    "TimeStamp": timeStamp,
    "Name": name,
    "Phone": phone,
    "ImagePath": imagePath,
    "Email": email,
    "Status": status,
    "SessionToken": sessionToken,
    "AuthToken": authToken,
    "IPAddress": ipAddress,
    "facebook_id": facebookId,
    "google_id": googleId,
    "hu_details": huDetails!.toJson(),
    "hu_address": huAddress!.toJson(),
  };
}

class HuAddress {
  HuAddress({
    this.id,
    this.username,
    this.country,
    this.stateProvince,
    this.city,
    this.location,
    this.area,
    this.latitude,
    this.longitude,
  });

  int? id;
  String? username;
  String? country;
  String? stateProvince;
  String? city;
  String? location;
  String? area;
  String? latitude;
  String? longitude;

  factory HuAddress.fromJson(Map<String, dynamic> json) => HuAddress(
    id: json["ID"],
    username: json["Username"],
    country: json["Country"],
    stateProvince: json["State_Province"],
    city: json["City"],
    location: json["Location"],
    area: json["Area"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Username": username,
    "Country": country,
    "State_Province": stateProvince,
    "City": city,
    "Location": location,
    "Area": area,
    "Latitude": latitude,
    "Longitude": longitude,
  };
}

class HuDetails {
  HuDetails({
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
  String? gender;
  String? dateOfBirth;
  String? cnic;
  String? bloodGroup;
  String? height;
  String? weight;
  String? bmi;
  String? bsa;
  int? age;
  String? maritalStatus;
  String? religion;
  String? profession;
  String? nationality;
  String? salutation;

  factory HuDetails.fromJson(Map<String, dynamic> json) => HuDetails(
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
