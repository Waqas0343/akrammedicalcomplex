// To parse this JSON data, do
//
//     final prescription = prescriptionFromJson(jsonString);

import 'dart:convert';

import 'meta.dart';

PrescriptionModel prescriptionModelFromJson(String str) => PrescriptionModel.fromJson(json.decode(str));

String prescriptionModelToJson(PrescriptionModel data) => json.encode(data.toJson());

class PrescriptionModel {
  Meta? meta;
  PrescriptionResponse? response;

  PrescriptionModel({
    this.meta,
    this.response,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) => PrescriptionModel(
    meta: Meta.fromJson(json["Meta"]),
    response: PrescriptionResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Meta": meta!.toJson(),
    "Response": response!.toJson(),
  };
}

class PrescriptionResponse {
  List<Prescription>? prescriptions;

  PrescriptionResponse({
    this.prescriptions,
  });

  factory PrescriptionResponse.fromJson(Map<String, dynamic> json) => PrescriptionResponse(
    prescriptions: List<Prescription>.from(json["Response"].map((x) => Prescription.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Response": List<dynamic>.from(prescriptions!.map((x) => x.toJson())),
  };
}

class Prescription {
  int? prescriptionId;
  String? caseHistoryTitle;
  String? patientHistory;
  String? onExamination;
  String? bloodPressure;
  String? pulse;
  String? tempurature;
  String? weight;
  String? title;
  String? doctorName;
  String? timeStamp;
  String? prescriptionUrl;
  List<MedicalTest>? medicalTest;
  List<Medicine>? medicines;

  Prescription({
    this.prescriptionId,
    this.caseHistoryTitle,
    this.patientHistory,
    this.onExamination,
    this.bloodPressure,
    this.pulse,
    this.tempurature,
    this.weight,
    this.doctorName,
    this.timeStamp,
    this.prescriptionUrl,
    this.medicalTest,
    this.medicines,
    this.title
  });

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
    prescriptionId: json["PrescriptionID"],
    caseHistoryTitle: json["CaseHistoryTitle"],
    patientHistory: json["PatientHistory"],
    onExamination: json["OnExamination"],
    bloodPressure: json["BloodPressure"],
    pulse: json["Pulse"],
    tempurature: json["Tempurature"],
    weight: json["Weight"],
    doctorName: json["DoctorName"],
    timeStamp: json["TimeStamp"],
    title: json["Title"],
    prescriptionUrl: json["prescription_url"],
    medicalTest: List<MedicalTest>.from(json["MedicalTest"].map((x) => MedicalTest.fromJson(x))),
    medicines: List<Medicine>.from(json["Medicines"].map((x) => Medicine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "PrescriptionID": prescriptionId,
    "CaseHistoryTitle": caseHistoryTitle,
    "PatientHistory": patientHistory,
    "OnExamination": onExamination,
    "BloodPressure": bloodPressure,
    "Pulse": pulse,
    "Tempurature": tempurature,
    "Weight": weight,
    "DoctorName": doctorName,
    "Title": title,
    "TimeStamp": timeStamp,
    "prescription_url": prescriptionUrl,
    "MedicalTest": List<dynamic>.from(medicalTest!.map((x) => x.toJson())),
    "Medicines": List<dynamic>.from(medicines!.map((x) => x.toJson())),
  };
}

class MedicalTest {
  int? id;
  int? prescriptionId;
  String? medicalTest;
  String? medicalTestNotes;
  dynamic labUsername;

  MedicalTest({
    this.id,
    this.prescriptionId,
    this.medicalTest,
    this.medicalTestNotes,
    this.labUsername,
  });

  factory MedicalTest.fromJson(Map<String, dynamic> json) => MedicalTest(
    id: json["ID"],
    prescriptionId: json["PrescriptionID"],
    medicalTest: json["MedicalTest"],
    medicalTestNotes: json["MedicalTestNotes"],
    labUsername: json["LabUsername"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "PrescriptionID": prescriptionId,
    "MedicalTest": medicalTest,
    "MedicalTestNotes": medicalTestNotes,
    "LabUsername": labUsername,
  };
}

class Medicine {
  int? id;
  int? prescriptionId;
  String? medicine;
  String? formType;
  String? grams;
  String? frequency;
  String? medicineNotes;

  Medicine({
    this.id,
    this.prescriptionId,
    this.medicine,
    this.formType,
    this.grams,
    this.frequency,
    this.medicineNotes,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    id: json["ID"],
    prescriptionId: json["PrescriptionID"],
    medicine: json["Medicine"],
    formType: json["FormType"],
    grams: json["Grams"],
    frequency: json["Frequency"],
    medicineNotes: json["MedicineNotes"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "PrescriptionID": prescriptionId,
    "Medicine": medicine,
    "FormType": formType,
    "Grams": grams,
    "Frequency": frequency,
    "MedicineNotes": medicineNotes,
  };
}
