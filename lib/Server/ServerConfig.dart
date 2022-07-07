import 'package:amc/Styles/Keys.dart';

class ServerConfig {
  static const String baseUrl = "https://instacare.pk/";
  static const baseEmrUrl = 'https://app.instacare.pk/api/';
  static const baseTestUrl = 'https://iprouk-testing.azurewebsites.net/';
  static const baseTestUrl2 = 'https://instacareuk-staging.azurewebsites.net/';

  static const login = baseUrl + "api/Accounts/LoginPhone_Username?SystemKey=" + systemKey;
  static const remindAccount = baseUrl + "api/User/PatientForgotPassword?SystemKey=" + systemKey; //resetphone
  static const signUp = baseUrl + "api/Accounts/PatientRegister?SystemKey=$systemKey&SourceUrl=${Keys.source}&projectID=${Keys.projectId}&locationId=${Keys.locationId}";
  static const checkUsername = baseUrl + "api/Accounts/CheckUserName?SystemKey=" + systemKey;
  static const cities = baseUrl + "/api/LabTests/GetLabTests?SystemKey=" + systemKey;
  static const searchTest = baseUrl + "/api/LabTests/GetLabTests?SystemKey=" + systemKey;

  static const bookLabTest = baseUrl + "api/LabTest/BookMobileLabTest?SystemKey=$systemKey&locationId=${Keys.locationId}";

  static const healthRecordSave = baseUrl + "api/Documents/AddDocuments?SystemKey=" + systemKey;

  static const medicalRecordDelete = baseUrl + "api/Documents/DeleteDocument?SystemKey=" + systemKey; //Id

  static const medicalRecords = baseUrl + "api/Prescriptions/MyFiles?SystemKey=" + systemKey; //username

  static const medicineOrders = baseUrl + "api/Payment/MedicineOrderList?SystemKey=" + systemKey; //username

  static const otcMedicines = baseUrl + "api/otc/get?SystemKey=" + systemKey; //name=

  static const medicineOrderPlace = baseUrl + "api/Payment/AddMedicineOrder?SystemKey=$systemKey&LocationId=${Keys.locationId}";

  static const myTestOrders = baseUrl + "api/LabTest/LabTestList?SystemKey=" + systemKey;

  static const uploadImages = baseUrl + "api/documents/savetocloud?"; //userid, attachment(File)

  static const categories = baseUrl + "api/Speciality/GetSpecialities?SystemKey=$systemKey&LocationId=${Keys.locationId}";

  static const doctorProfile = baseUrl + "/api/Profile?SystemKey=" + systemKey;

  static const doctors = baseUrl + "api/Doctors/DoctorListShort?SystemKey=$systemKey&Medusername=${Keys.locationId}";

  static const verifyCode = baseUrl + "api/Accounts/Activate?SystemKey=$systemKey";

  static const resentCode = baseUrl + "api/accounts/getactivationcode?SystemKey=$systemKey";
  static const resendCode = baseUrl + "api/OTP/RegenerateOTP?SystemKey=$systemKey&locationID=${Keys.locationId}&projectID=${Keys.projectId}";

  static const prescriptions = baseUrl + "api/Prescriptions/MyPrescriptionsList?SystemKey=" + systemKey; //username

  static const timeSlots = baseEmrUrl + "AppointmentApi/GetTimeByDate?SystemKey=$systemKey";

  static const appointmentSave = baseEmrUrl + "AppointmentApi/SaveAppointment?SystemKey=$systemKey&LocationId=${Keys.locationId}&projectID=${Keys.projectId}";

  static const getServices = baseEmrUrl + "ServicesApi/GetLocationServices?SystemKey=" + systemKey;

  static const labs = baseUrl + "api/LabTest/ListOfLabsShort?SystemKey=" + systemKey;

  static const patientInfoUpdate = baseUrl + "api/PatientProfile/BasicInfo_Update?SystemKey=" + systemKey;

  static const labTestBook = baseUrl + "api/LabTest/BookMobileLabTest?SystemKey=$systemKey&LocationId=${Keys.locationId}&projectID=${Keys.projectId}";

  static const getPatientInfo = baseUrl + "api/PatientProfile/GetList_BasicInfo?SystemKey=" + systemKey;

  static const changePassword = baseUrl + "api/Accounts/ChangePassword?SystemKey=" + systemKey;

  static const appointments = baseUrl + "api/CustomAppointments/GetList?SystemKey=" + systemKey; //patientusername

  static const saveToken = baseUrl + "api/Accounts/SaveFirebaseToken?SystemKey=" + systemKey; //&username=&token=

  static const treatments = baseEmrUrl + "Treatment/GetBookedTreatmentList?SystemKey=" + systemKey; //&username=&token=

  static const String sourceUrl = "AMC";
  static const String projectID = "amc-healthcare-services";
  static const String locationID = "A20200710021733";
  static const String systemKey = "6b2e7679-34dd-41f9-b0cd-ac0ea0f8bf8b";
}
