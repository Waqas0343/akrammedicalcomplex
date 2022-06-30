import 'dart:convert';

import 'category_model.dart';


// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

DoctorModel doctorModelFromJson(String str) => DoctorModel.fromJson(json.decode(str));

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  DoctorModel({
    this.response,
  });

  DoctorModelResponse response;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    response: DoctorModelResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response.toJson(),
  };
}


class DoctorModelResponse {
  DoctorModelResponse({
    this.response,
  });

  ResponseResponse response;

  factory DoctorModelResponse.fromJson(Map<String, dynamic> json) => DoctorModelResponse(
    response: ResponseResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response.toJson(),
  };
}

class ResponseResponse {
  ResponseResponse({
    this.data,
  });

  List<ResponseDetail> data;

  factory ResponseResponse.fromJson(Map<String, dynamic> json) => ResponseResponse(

    data: json["data"] != null ?
    List<ResponseDetail>.from(json["data"].map((x) => ResponseDetail.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ResponseDetail {
  ResponseDetail({
    this.username,
    this.name,
    this.imagepath,
    this.speciality,
    this.fee,
    this.practiceName,
    this.practiceId,
    this.practiceLogo,
    this.location,
    this.isTeleMedicineProvider,
    this.onlineStatus,
  });

  String username;
  String name;
  String imagepath;
  String speciality;
  String fee;
  String practiceName;
  String practiceId;
  String practiceLogo;
  String location;
  bool isTeleMedicineProvider;
  bool onlineStatus;

  factory ResponseDetail.fromJson(Map<String, dynamic> json) => ResponseDetail(
    username: json["username"],
    name: json["name"],
    imagepath: json["imagepath"],
    speciality: json["speciality"],
    fee: json["fee"],
    practiceName: json["practice_name"],
    practiceId: json["practice_id"],
    practiceLogo: json["practice_logo"],
    location: json["location"],
    isTeleMedicineProvider: json["IsTeleMedicineProvider"],
    onlineStatus: json["OnlineStatus"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "imagepath": imagepath,
    "speciality": speciality,
    "fee": fee,
    "practice_name": practiceName,
    "practice_id": practiceId,
    "practice_logo": practiceLogo,
    "location": location,
    "IsTeleMedicineProvider": isTeleMedicineProvider,
    "OnlineStatus": onlineStatus,
  };
}



DoctorProfileModel doctorProfileFromJson(String str) => DoctorProfileModel.fromJson(json.decode(str));

String doctorProfileToJson(DoctorProfileModel data) => json.encode(data.toJson());

class DoctorProfileModel {
  DoctorProfileResponse doctorProfileResponse;

  DoctorProfileModel({
    this.doctorProfileResponse,
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) => DoctorProfileModel(
    doctorProfileResponse: DoctorProfileResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": doctorProfileResponse.toJson(),
  };
}

class DoctorProfileResponse {
  DocProfile docProfile;

  DoctorProfileResponse({
    this.docProfile,
  });

  factory DoctorProfileResponse.fromJson(Map<String, dynamic> json) => DoctorProfileResponse(
    docProfile: DocProfile.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": docProfile.toJson(),
  };
}

class DocProfile {
  String username;
  String about;
  String registrationNo;
  String registrationType;
  String verificationMethod;
  String videoUrl;
  String facebookUrl;
  String twitterUrl;
  String linkedInUrl;
  String googlePlusUrl;
  String workingSince;
  String experience;
  bool onboard;
  String featured;
  String name;
  String phone;
  String imagePath;
  String email;
  String background;
  bool status;
  bool isOnline;
  bool isTeleMedicineProvider;
  dynamic bookmarked;
  List<dynamic> timeSlots;
  Category speciality;
  List<String> qualifications;
  List<Assosiation> assosiations;
  List<Review> reviews;
  dynamic averageRating;
  List<Service> services;
  dynamic addresses;

  DocProfile({
    this.username,
    this.about,
    this.registrationNo,
    this.registrationType,
    this.verificationMethod,
    this.videoUrl,
    this.facebookUrl,
    this.twitterUrl,
    this.linkedInUrl,
    this.googlePlusUrl,
    this.workingSince,
    this.experience,
    this.onboard,
    this.featured,
    this.name,
    this.phone,
    this.imagePath,
    this.email,
    this.background,
    this.status,
    this.bookmarked,
    this.timeSlots,
    this.speciality,
    this.qualifications,
    this.assosiations,
    this.reviews,
    this.averageRating,
    this.services,
    this.addresses,
    this.isOnline,
    this.isTeleMedicineProvider,
  });

  factory DocProfile.fromJson(Map<String, dynamic> json) => DocProfile(
    username: json["Username"],
    about: json["About"],
    registrationNo: json["RegistrationNo"],
    registrationType: json["RegistrationType"],
    verificationMethod: json["VerificationMethod"],
    videoUrl: json["VideoURL"] ?? "",
    facebookUrl: json["FacebookURL"] ?? "",
    twitterUrl: json["TwitterURL"] ?? "",
    linkedInUrl: json["LinkedInURL"] ?? "",
    googlePlusUrl: json["GooglePlusURL"] ?? "",
    workingSince: json["WorkingSince"],
    experience: json["experience"],
    onboard: json["Onboard"],
    featured: json["Featured"],
    name: json["Name"],
    phone: json["Phone"],
    imagePath: json["ImagePath"],
    email: json["Email"],
    background: json["Background"],
    status: json["Status"],
    bookmarked: json["Bookmarked"],
    timeSlots: List<dynamic>.from(json["TimeSlots"].map((x) => x)),
    speciality: Category.fromJson(json["Speciality"]),
    qualifications: List<String>.from(json["Qualifications"].map((x) => x)),
    assosiations: List<Assosiation>.from(json["Assosiations"].map((x) => Assosiation.fromJson(x))),
    reviews: List<Review>.from(json["Reviews"].map((x) => Review.fromJson(x))),
    averageRating: json["average_rating"],
    services: List<Service>.from(json["Services"].map((x) => Service.fromJson(x))),
    addresses: json["addresses"],
    isTeleMedicineProvider: json["IsTeleMedicineProvider"],
    isOnline: json["OnlineStatus"],
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "About": about,
    "RegistrationNo": registrationNo,
    "RegistrationType": registrationType,
    "VerificationMethod": verificationMethod,
    "VideoURL": videoUrl,
    "FacebookURL": facebookUrl,
    "TwitterURL": twitterUrl,
    "LinkedInURL": linkedInUrl,
    "GooglePlusURL": googlePlusUrl,
    "WorkingSince": workingSince,
    "experience": experience,
    "Onboard": onboard,
    "Featured": featured,
    "Name": name,
    "Phone": phone,
    "ImagePath": imagePath,
    "Email": email,
    "Background": background,
    "Status": status,
    "Bookmarked": bookmarked,
    "TimeSlots": List<dynamic>.from(timeSlots.map((x) => x)),
    "Speciality": speciality.toJson(),
    "Qualifications": List<dynamic>.from(qualifications.map((x) => x)),
    "Assosiations": List<dynamic>.from(assosiations.map((x) => x.toJson())),
    "Reviews": List<Review>.from(reviews.map((x) => x)),
    "average_rating": averageRating,
    "Services": List<dynamic>.from(services.map((x) => x.toJson())),
    "addresses": addresses,
    "IsTeleMedicineProvider": isTeleMedicineProvider,
    "OnlineStatus": isOnline,
  };
}

class Assosiation {
  String locationId;
  String location;
  String city;
  String lat;
  dynamic lng;
  String fullAddress;
  String logo;
  bool isMonday;
  String minMonday;
  String maxMonday;
  bool isTuesday;
  String minTuesday;
  String maxTuesday;
  bool isWednesday;
  String minWednesday;
  String maxWednesday;
  bool isThursday;
  String minThursday;
  String maxThursday;
  bool isFriday;
  String minFriday;
  String maxFriday;
  bool isSaturday;
  String minSaturday;
  String maxSaturday;
  bool isSunday;
  String minSunday;
  String maxSunday;
  String regularCharges;
  String videoCharges;
  String type;
  Weeklyschedule weeklyschedule;

  Assosiation({
    this.locationId,
    this.location,
    this.city,
    this.lat,
    this.lng,
    this.fullAddress,
    this.logo,
    this.isMonday,
    this.minMonday,
    this.maxMonday,
    this.isTuesday,
    this.minTuesday,
    this.maxTuesday,
    this.isWednesday,
    this.minWednesday,
    this.maxWednesday,
    this.isThursday,
    this.minThursday,
    this.maxThursday,
    this.isFriday,
    this.minFriday,
    this.maxFriday,
    this.isSaturday,
    this.minSaturday,
    this.maxSaturday,
    this.isSunday,
    this.minSunday,
    this.maxSunday,
    this.regularCharges,
    this.videoCharges,
    this.type,
    this.weeklyschedule,
  });

  factory Assosiation.fromJson(Map<String, dynamic> json) => Assosiation(
    locationId: json["location_id"],
    location: json["location"],
    city: json["city"],
    lat: json["lat"],
    lng: json["lng"],
    fullAddress: json["full_address"],
    logo: json["logo"],
    isMonday: json["isMonday"],
    minMonday: json["MinMonday"],
    maxMonday: json["MaxMonday"],
    isTuesday: json["isTuesday"],
    minTuesday: json["MinTuesday"],
    maxTuesday: json["MaxTuesday"],
    isWednesday: json["isWednesday"],
    minWednesday: json["MinWednesday"],
    maxWednesday: json["MaxWednesday"],
    isThursday: json["isThursday"],
    minThursday: json["MinThursday"],
    maxThursday: json["MaxThursday"],
    isFriday: json["isFriday"],
    minFriday: json["MinFriday"],
    maxFriday: json["MaxFriday"],
    isSaturday: json["isSaturday"],
    minSaturday: json["MinSaturday"],
    maxSaturday: json["MaxSaturday"],
    isSunday: json["isSunday"],
    minSunday: json["MinSunday"],
    maxSunday: json["MaxSunday"],
    regularCharges: json["RegularCharges"],
    videoCharges: json["VideoCharges"],
    type: json["type"],
    weeklyschedule: Weeklyschedule.fromJson(json["weeklyschedule"]),
  );

  Map<String, dynamic> toJson() => {
    "location_id": locationId,
    "location": location,
    "city": city,
    "lat": lat,
    "lng": lng,
    "full_address": fullAddress,
    "logo": logo,
    "isMonday": isMonday,
    "MinMonday": minMonday,
    "MaxMonday": maxMonday,
    "isTuesday": isTuesday,
    "MinTuesday": minTuesday,
    "MaxTuesday": maxTuesday,
    "isWednesday": isWednesday,
    "MinWednesday": minWednesday,
    "MaxWednesday": maxWednesday,
    "isThursday": isThursday,
    "MinThursday": minThursday,
    "MaxThursday": maxThursday,
    "isFriday": isFriday,
    "MinFriday": minFriday,
    "MaxFriday": maxFriday,
    "isSaturday": isSaturday,
    "MinSaturday": minSaturday,
    "MaxSaturday": maxSaturday,
    "isSunday": isSunday,
    "MinSunday": minSunday,
    "MaxSunday": maxSunday,
    "RegularCharges": regularCharges,
    "VideoCharges": videoCharges,
    "type": type,
    "weeklyschedule": weeklyschedule.toJson(),
  };
}

class Weeklyschedule {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;
  String today;

  Weeklyschedule({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.today,
  });

  factory Weeklyschedule.fromJson(Map<String, dynamic> json) => Weeklyschedule(
    monday: json["Monday"],
    tuesday: json["Tuesday"],
    wednesday: json["Wednesday"],
    thursday: json["Thursday"],
    friday: json["Friday"],
    saturday: json["Saturday"],
    sunday: json["Sunday"],
    today: json["Today"],
  );

  Map<String, dynamic> toJson() => {
    "Monday": monday,
    "Tuesday": tuesday,
    "Wednesday": wednesday,
    "Thursday": thursday,
    "Friday": friday,
    "Saturday": saturday,
    "Sunday": sunday,
    "Today": today,
  };
}

class Service {
  int id;
  String name;
  String description;
  String charges;

  Service({
    this.id,
    this.name,
    this.description,
    this.charges,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["ID"],
    name: json["Name"],
    description: json["Description"],
    charges: json["Charges"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Description": description,
    "Charges": charges,
  };
}

class Review {
  Review({
    this.patientName,
    this.imagePath,
    this.id,
    this.patientUsername,
    this.spUsername,
    this.rating,
    this.title,
    this.description,
    this.timeStamp,
    this.isRecommended,
    this.status,
  });

  String patientName;
  String imagePath;
  int id;
  String patientUsername;
  String spUsername;
  dynamic rating;
  String title;
  String description;
  DateTime timeStamp;
  bool isRecommended;
  String status;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    patientName: json["PatientName"],
    imagePath: json["ImagePath"],
    id: json["ID"],
    patientUsername: json["PatientUsername"],
    spUsername: json["SPUsername"],
    rating: json["Rating"],
    title: json["Title"],
    description: json["Description"],
    timeStamp: DateTime.parse(json["TimeStamp"]),
    isRecommended: json["isRecommended"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "PatientName": patientName,
    "ImagePath": imagePath,
    "ID": id,
    "PatientUsername": patientUsername,
    "SPUsername": spUsername,
    "Rating": rating,
    "Title": title,
    "Description": description,
    "TimeStamp": timeStamp.toIso8601String(),
    "isRecommended": isRecommended,
    "status": status,
  };
}
