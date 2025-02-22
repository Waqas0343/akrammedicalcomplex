import 'package:amc/Screens/MyBooking/MyAppointments.dart';
import 'package:amc/Screens/MyBooking/MyLabOrders.dart';
import 'package:amc/Screens/Orders/Medicines/MyMedicineOrders.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/models/appointment_model.dart';
import 'package:amc/models/medicine_order_model.dart';
import 'package:amc/models/test_order_model.dart';
import 'package:amc/placeholder/custom_shimmer.dart';
import 'package:amc/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBooking extends StatefulWidget {
  final int? initialIndex;

  const MyBooking({Key? key, this.initialIndex}) : super(key: key);

  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  List<Appointment>? appointments;

  // List<TreatmentData> treatments;
  List<TestModel>? testOrders;
  List<Order>? medicinesOrders;

  bool appointmentLoading = true;

  // bool treatmentLoading = true;
  bool ordersLoading = true;
  bool medicinesLoading = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialIndex ?? 0,
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return <Widget>[
              const SliverAppBar(
                pinned: true,
                floating: true,
                title: Text("My Bookings"),
                bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: <Tab>[
                      Tab(
                        text: "Test Orders",
                      ),
                      Tab(
                        text: "Medicine Orders",
                      ),
                      Tab(
                        text: "Appointments",
                      ),
                    ]),
              )
            ];
          },
          body: TabBarView(children: [
            ordersLoading
                ? const MyLabOrderIsLoading()
                : LabOrders(
                    orders: testOrders,
                  ),
            medicinesLoading
                ? const MyMedicineOrdersIsLoading()
                : MyMedicineOrders(
                    orders: medicinesOrders,
                  ),
            appointmentLoading
                ? const LoadingMyAppointmentList()
                : MyAppointments(
                    appointments: appointments,
                  ),
          ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    appointments = [];
    testOrders = [];
    medicinesOrders = [];
    super.initState();
    getBookings();
  }

  void getAppointments(String? username) async {
    String appointmentResponse = await Utilities.httpGet(
        ServerConfig.appointments + "&patientusername=$username");
    if (appointmentResponse != "404") {
      if (!mounted) return;
      setState(() {
        appointments!.addAll(appointmentModelFromJson(appointmentResponse)
            .response!
            .appointmentList!);
        appointmentLoading = false;
      });
    } else {
      Utilities.showToast("Unable to load Appointments, try again later.");
    }
  }

  void getOrders(String? username) async {
    String response = await Utilities.httpGet(
        ServerConfig.myTestOrders + "&username=$username&Attachments=false");
    if (response != "404") {
      var list = testOrderResponseModelFromJson(response).response!.response;
      if (!mounted) return;
      setState(() {
        testOrders!.addAll(list!);
        ordersLoading = false;
      });
    }
  }

  void getMedicineOrders(String? username) async {
    String response = await Utilities.httpGet(
        ServerConfig.medicineOrders + "&username=$username");
    if (response != "404") {
      List<Order>? list = medicineOrdersFromJson(response).response!.orders;
      if (!mounted) return;
      setState(() {
        medicinesOrders!.addAll(list!);
        medicinesLoading = false;
      });
    }
  }

  void getBookings() async {
    String? username = Get.find<Preferences>().getString(Keys.username);

    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable();
      ordersLoading = false;
      appointmentLoading = false;
      medicinesLoading = false;
      setState(() {});
      return;
    }

    getAppointments(username);
    getOrders(username);
    getMedicineOrders(username);
  }
}
