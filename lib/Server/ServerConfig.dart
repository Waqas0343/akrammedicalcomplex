import 'package:amc/Styles/Keys.dart';

class ServerConfig{
  static const String baseUrl = "https://instacare.pk/";
  static const baseTestUrl = 'https://iprouk-testing.azurewebsites.net/';
  static const baseTestUrl2 = 'https://instacareuk-staging.azurewebsites.net/';
  static const login = baseTestUrl2 +
      "api/Accounts/LoginPhone_Username?SystemKey=" + systemKey;

  static const remindAccount = baseTestUrl +
      "api/User/PatientForgotPassword?SystemKey=" + systemKey; //resetphone

  static const signUp = baseTestUrl2 +
      "api/Accounts/PatientRegister?SystemKey=$systemKey&SourceUrl=${Keys.source}";

  static const checkUsername = baseTestUrl +
      "api/Accounts/CheckUserName?SystemKey=" + systemKey;

  static const cities = baseUrl +
      "api/City/GetCitiesList?SystemKey=" + systemKey;

  static const searchTest = baseTestUrl2 +
      "api/LabTest/GetTestList?SystemKey=" + systemKey;

  static const bookLabTest = baseTestUrl2 +
      "api/LabTest/BookMobileLabTest?SystemKey=" + systemKey;

  static const healthRecordSave = baseUrl +
      "api/Documents/AddDocuments?SystemKey=" + systemKey;

  static const medicalRecordDelete = baseTestUrl2 +
      "api/Documents/DeleteDocument?SystemKey=" + systemKey; //Id

  static const medicalRecords = baseUrl +
      "api/Prescriptions/MyFiles?SystemKey=" + systemKey; //username

  static const medicineOrders = baseTestUrl2 +
      "api/Payment/MedicineOrderList?SystemKey=" + systemKey; //username

  static const otcMedicines = baseTestUrl2 +
      "api/otc/get?SystemKey=" + systemKey; //name=

  static const medicineOrderPlace = baseTestUrl2 +
      "api/Payment/AddMedicineOrder?SystemKey="+systemKey;

  static const myTestOrders = baseTestUrl2 +
      "api/LabTest/LabTestList?SystemKey=" + systemKey;

  static const uploadImages = baseUrl +
      "api/documents/savetocloud?"; //userid, attachment(File)

  static const categories = baseTestUrl2 +
      "api/Speciality/GetSpecialities?SystemKey=$systemKey&LocationId=${Keys.locationId}";

  static const doctorProfile = baseUrl +
      "/api/Profile?SystemKey=" + systemKey;

  static const doctors = baseTestUrl2 +
      "api/Doctors/DoctorListShort?SystemKey=$systemKey&Medusername=${Keys.locationId}";

  static const verifyCode = baseTestUrl2 +
      "api/Accounts/Activate?SystemKey=$systemKey";

  static const resentCode = baseTestUrl +
      "api/accounts/getactivationcode?SystemKey=$systemKey";
  
  static const prescriptions = baseUrl +
      "api/Prescriptions/MyPrescriptionsList?SystemKey=" + systemKey; //username

  static const timeSlots = baseTestUrl +
      "api/Appointment/GetAvailableDateList?SystemKey=$systemKey&LocationId=${Keys.locationId}";

  static const appointmentTreatmentSave = baseTestUrl +
      "api/AppointmentApi/SaveAppointment?SystemKey=" + systemKey;


  static const getServices = baseTestUrl +
      "api/ServicesApi/GetLocationServices?SystemKey=" + systemKey;

  static const labs = baseUrl +
      "api/LabTest/ListOfLabsShort?SystemKey=" + systemKey;

  static const patientInfoUpdate = baseTestUrl2 +
      "api/PatientProfile/BasicInfo_Update?SystemKey=" + systemKey;

  static const labTestBook = baseTestUrl2 +
      "api/LabTest/BookMobileLabTest?SystemKey=" + systemKey;

  static const getPatientInfo = baseTestUrl2 +
      "api/PatientProfile/GetList_BasicInfo?SystemKey=" + systemKey;

  static const changePassword = baseUrl +
      "api/Accounts/ChangePassword?SystemKey=" + systemKey;

  static const appointments = baseTestUrl2 +
      "api/CustomAppointments/GetList?SystemKey=" + systemKey; //patientusername

  static const saveToken = baseTestUrl +
      "api/Accounts/SaveFirebaseToken?SystemKey=" + systemKey; //&username=&token=

  static const treatments = baseTestUrl +
      "api/Treatment/GetBookedTreatmentList?SystemKey=" + systemKey; //&username=&token=


  static const String sourceUrl = "AMC";
  static const String systemKey = "6b2e7679-34dd-41f9-b0cd-ac0ea0f8bf8b";

}