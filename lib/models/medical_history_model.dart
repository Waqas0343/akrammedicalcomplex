// To parse this JSON data, do
//
//     final medicalHistoryModel = medicalHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'meta.dart';

MedicalHistoryModel medicalHistoryModelFromJson(String str) => MedicalHistoryModel.fromJson(json.decode(str));

String medicalHistoryModelToJson(MedicalHistoryModel data) => json.encode(data.toJson());

class MedicalHistoryModel {
  MedicalHistoryModel({
    this.meta,
    this.response,
  });

  Meta meta;
  MedicalHistoryModelResponse response;

  factory MedicalHistoryModel.fromJson(Map<String, dynamic> json) => MedicalHistoryModel(
    meta: Meta.fromJson(json["Meta"]),
    response: MedicalHistoryModelResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Meta": meta.toJson(),
    "Response": response.toJson(),
  };
}

class MedicalHistoryModelResponse {
  MedicalHistoryModelResponse({
    this.historyModel,
  });

  HistoryModel historyModel;

  factory MedicalHistoryModelResponse.fromJson(Map<String, dynamic> json) => MedicalHistoryModelResponse(
    historyModel:json["Response"] != null ? HistoryModel.fromJson(json["Response"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "Response": historyModel.toJson(),
  };
}

class HistoryModel {
  HistoryModel({
    this.id,
    this.patientId,
    this.locationId,
    this.fillingDate,
    this.mHospitalized,
    this.mTakingMedication,
    this.mAlcohol,
    this.mSmoke,
    this.mHeartattack,
    this.mAngina,
    this.mBp,
    this.mCardiacPacemaker,
    this.mAnemia,
    this.mHepatitis,
    this.mBleedingDisorder,
    this.mRenalDiseases,
    this.mHiv,
    this.mSexualDisease,
    this.mRespiratory,
    this.mTuberculosis,
    this.mHayFeverAllergies,
    this.mDiabetes,
    this.mThyroid,
    this.mFainting,
    this.mStroke,
    this.mArthritis,
    this.mJointReplacement,
    this.mStomachUlcers,
    this.mOphthalmologicalProb,
    this.mEnt,
    this.mDengue,
    this.dGumBleeding,
    this.dTeethPain,
    this.dTeethHotCold,
    this.dTeethSweetSour,
    this.dSoresLumps,
    this.dHeadNeckInjury,
    this.dClicking,
    this.dPainJointEar,
    this.dDifficultyOpeningMouth,
    this.dDifficultyChewing,
    this.dHeadaches,
    this.dClenchTeeth,
    this.dBiteLips,
    this.dDifficultExtraction,
    this.dOrthoTreatment,
    this.dProlongedBleeding,
    this.dInstCorrectBrushing,
    this.dInstCateOfGums,
    this.dHowManyTimesBrush,
    this.permissionCertify,
    this.signedName,
    this.signedCnic,
    this.addedOn,
  });

  String id;
  String patientId;
  dynamic locationId;
  String fillingDate;
  bool mHospitalized;
  bool mTakingMedication;
  bool mAlcohol;
  bool mSmoke;
  bool mHeartattack;
  bool mAngina;
  bool mBp;
  bool mCardiacPacemaker;
  bool mAnemia;
  bool mHepatitis;
  bool mBleedingDisorder;
  bool mRenalDiseases;
  bool mHiv;
  bool mSexualDisease;
  bool mRespiratory;
  bool mTuberculosis;
  bool mHayFeverAllergies;
  bool mDiabetes;
  bool mThyroid;
  bool mFainting;
  bool mStroke;
  bool mArthritis;
  bool mJointReplacement;
  bool mStomachUlcers;
  bool mOphthalmologicalProb;
  bool mEnt;
  bool mDengue;
  bool dGumBleeding;
  bool dTeethPain;
  bool dTeethHotCold;
  bool dTeethSweetSour;
  bool dSoresLumps;
  bool dHeadNeckInjury;
  bool dClicking;
  bool dPainJointEar;
  bool dDifficultyOpeningMouth;
  bool dDifficultyChewing;
  bool dHeadaches;
  bool dClenchTeeth;
  bool dBiteLips;
  bool dDifficultExtraction;
  bool dOrthoTreatment;
  bool dProlongedBleeding;
  bool dInstCorrectBrushing;
  bool dInstCateOfGums;
  String dHowManyTimesBrush;
  bool permissionCertify;
  dynamic signedName;
  dynamic signedCnic;
  String addedOn;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    id: json["id"],
    patientId: json["patient_id"],
    locationId: json["location_id"],
    fillingDate: json["filling_date"],
    mHospitalized: json["m_hospitalized"],
    mTakingMedication: json["m_taking_medication"],
    mAlcohol: json["m_alcohol"],
    mSmoke: json["m_smoke"],
    mHeartattack: json["m_heartattack"],
    mAngina: json["m_angina"],
    mBp: json["m_bp"],
    mCardiacPacemaker: json["m_cardiac_pacemaker"],
    mAnemia: json["m_anemia"],
    mHepatitis: json["m_hepatitis"],
    mBleedingDisorder: json["m_bleeding_disorder"],
    mRenalDiseases: json["m_renal_diseases"],
    mHiv: json["m_hiv"],
    mSexualDisease: json["m_sexual_disease"],
    mRespiratory: json["m_respiratory"],
    mTuberculosis: json["m_tuberculosis"],
    mHayFeverAllergies: json["m_hay_fever_allergies"],
    mDiabetes: json["m_diabetes"],
    mThyroid: json["m_thyroid"],
    mFainting: json["m_fainting"],
    mStroke: json["m_stroke"],
    mArthritis: json["m_arthritis"],
    mJointReplacement: json["m_joint_replacement"],
    mStomachUlcers: json["m_stomach_ulcers"],
    mOphthalmologicalProb: json["m_ophthalmological_prob"],
    mEnt: json["m_ent"],
    mDengue: json["m_dengue"],
    dGumBleeding: json["d_gum_bleeding"],
    dTeethPain: json["d_teeth_pain"],
    dTeethHotCold: json["d_teeth_hot_cold"],
    dTeethSweetSour: json["d_teeth_sweet_sour"],
    dSoresLumps: json["d_sores_lumps"],
    dHeadNeckInjury: json["d_head_neck_injury"],
    dClicking: json["d_clicking"],
    dPainJointEar: json["d_pain_joint_ear"],
    dDifficultyOpeningMouth: json["d_difficulty_opening_mouth"],
    dDifficultyChewing: json["d_difficulty_chewing"],
    dHeadaches: json["d_headaches"],
    dClenchTeeth: json["d_clench_teeth"],
    dBiteLips: json["d_bite_lips"],
    dDifficultExtraction: json["d_difficult_extraction"],
    dOrthoTreatment: json["d_ortho_treatment"],
    dProlongedBleeding: json["d_prolonged_bleeding"],
    dInstCorrectBrushing: json["d_inst_correct_brushing"],
    dInstCateOfGums: json["d_inst_cate_of_gums"],
    dHowManyTimesBrush: json["d_how_many_times_brush"],
    permissionCertify: json["permission_certify"],
    signedName: json["signed_name"],
    signedCnic: json["signed_cnic"],
    addedOn: json["added_on"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient_id": patientId,
    "location_id": locationId,
    "filling_date": fillingDate,
    "m_hospitalized": mHospitalized,
    "m_taking_medication": mTakingMedication,
    "m_alcohol": mAlcohol,
    "m_smoke": mSmoke,
    "m_heartattack": mHeartattack,
    "m_angina": mAngina,
    "m_bp": mBp,
    "m_cardiac_pacemaker": mCardiacPacemaker,
    "m_anemia": mAnemia,
    "m_hepatitis": mHepatitis,
    "m_bleeding_disorder": mBleedingDisorder,
    "m_renal_diseases": mRenalDiseases,
    "m_hiv": mHiv,
    "m_sexual_disease": mSexualDisease,
    "m_respiratory": mRespiratory,
    "m_tuberculosis": mTuberculosis,
    "m_hay_fever_allergies": mHayFeverAllergies,
    "m_diabetes": mDiabetes,
    "m_thyroid": mThyroid,
    "m_fainting": mFainting,
    "m_stroke": mStroke,
    "m_arthritis": mArthritis,
    "m_joint_replacement": mJointReplacement,
    "m_stomach_ulcers": mStomachUlcers,
    "m_ophthalmological_prob": mOphthalmologicalProb,
    "m_ent": mEnt,
    "m_dengue": mDengue,
    "d_gum_bleeding": dGumBleeding,
    "d_teeth_pain": dTeethPain,
    "d_teeth_hot_cold": dTeethHotCold,
    "d_teeth_sweet_sour": dTeethSweetSour,
    "d_sores_lumps": dSoresLumps,
    "d_head_neck_injury": dHeadNeckInjury,
    "d_clicking": dClicking,
    "d_pain_joint_ear": dPainJointEar,
    "d_difficulty_opening_mouth": dDifficultyOpeningMouth,
    "d_difficulty_chewing": dDifficultyChewing,
    "d_headaches": dHeadaches,
    "d_clench_teeth": dClenchTeeth,
    "d_bite_lips": dBiteLips,
    "d_difficult_extraction": dDifficultExtraction,
    "d_ortho_treatment": dOrthoTreatment,
    "d_prolonged_bleeding": dProlongedBleeding,
    "d_inst_correct_brushing": dInstCorrectBrushing,
    "d_inst_cate_of_gums": dInstCateOfGums,
    "d_how_many_times_brush": dHowManyTimesBrush,
    "permission_certify": permissionCertify,
    "signed_name": signedName,
    "signed_cnic": signedCnic,
    "added_on": addedOn,
  };
}
