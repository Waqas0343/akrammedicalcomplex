import 'dart:convert';

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));

String citiesToJson(Cities data) => json.encode(data.toJson());

class Cities {
  CitiesList citiesList;

  Cities({
    this.citiesList,
  });

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
    citiesList: CitiesList.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": citiesList.toJson(),
  };
}


class CitiesList {
  List<City> cities;

  CitiesList({
    this.cities,
  });

  factory CitiesList.fromJson(Map<String, dynamic> json) => CitiesList(
    cities: List<City>.from(json["Response"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(cities.map((x) => x.toJson())),
  };
}

class City {
  int totalDoctors;
  int totalMedicalCenters;
  String name;
  String popularity;
  String latitude;
  String longitude;

  City({
    this.totalDoctors,
    this.totalMedicalCenters,
    this.name,
    this.popularity,
    this.latitude,
    this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    totalDoctors: json["TotalDoctors"],
    totalMedicalCenters: json["TotalMedicalCenters"],
    name: json["Name"],
    popularity: json["Popularity"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
  );

  Map<String, dynamic> toJson() => {
    "TotalDoctors": totalDoctors,
    "TotalMedicalCenters": totalMedicalCenters,
    "Name": name,
    "Popularity": popularity,
    "Latitude": latitude,
    "Longitude": longitude,
  };
}
