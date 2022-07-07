import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  LoginResponse? response;

  Login({
    this.response,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        response: LoginResponse.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": response!.toJson(),
      };
}

class LoginResponse {
  User? user;
  LoginResponse({
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        user: User.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": user!.toJson(),
      };
}

class User {
  String? username;
  String? type;
  String? timeStamp;
  String? name;
  String? phone;
  String? imagePath;
  String? email;
  int otpCode;
  bool? status;
  bool? activationStatus;
  String? sessionToken;
  String? authToken;
  dynamic ipAddress;
  String? facebookId;
  HumanDetails? huDetails;
  HumanAddress? huAddress;

  User({
    this.username,
    this.type,
    this.timeStamp,
    this.name,
    this.phone,
    this.imagePath,
    this.email,
    required this.otpCode,
    this.status,
    this.activationStatus,
    this.sessionToken,
    this.authToken,
    this.ipAddress,
    this.facebookId,
    this.huDetails,
    this.huAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["Username"],
        type: json["Type"],
        timeStamp: json["TimeStamp"],
        name: json["Name"],
        phone: json["Phone"],
        imagePath: json["ImagePath"],
        email: json["Email"],
        otpCode: json["OTPCode"],
        status: json["Status"],
        activationStatus: json["ActivationStatus"],
        sessionToken: json["SessionToken"],
        authToken: json["AuthToken"],
        ipAddress: json["IPAddress"],
        facebookId: json["facebook_id"],
        huDetails: HumanDetails.fromJson(json["hu_details"]),
        huAddress: HumanAddress.fromJson(json["hu_address"]),
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "Type": type,
        "TimeStamp": timeStamp,
        "Name": name,
        "Phone": phone,
        "ImagePath": imagePath,
        "Email": email,
        "OTPCode": otpCode,
        "ActivationStatus": activationStatus,
        "SessionToken": sessionToken,
        "AuthToken": authToken,
        "IPAddress": ipAddress,
        "facebook_id": facebookId,
        "hu_details": huDetails!.toJson(),
        "hu_address": huAddress!.toJson(),
      };
}

class HumanAddress {
  int? id;
  String? username;
  String? country;
  String? stateProvince;
  String? city;
  String? location;
  String? area;
  dynamic latitude;
  dynamic longitude;

  HumanAddress({
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

  factory HumanAddress.fromJson(Map<String, dynamic> json) => HumanAddress(
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

class HumanDetails {
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

  HumanDetails({
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

  factory HumanDetails.fromJson(Map<String, dynamic> json) => HumanDetails(
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
