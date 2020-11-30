import 'package:amc/Models/DoctorResponseModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Models/CategoryModel.dart';
import 'package:amc/Screens/BookAppointment/BookAppointment.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:flutter/material.dart';

import 'DoctorProfile.dart';

class FindDoctor extends StatefulWidget {
  @override
  _FindDoctorState createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  bool isLoading = false;
  int totalRecord = 0, pageNo = 0;

  List<ResponseDetail> doctors;

  Category category;
  List<Category> categories;

  final nameFocus = FocusNode();

  final nameController = TextEditingController();
  ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: DropdownButtonHideUnderline(
          child: DropdownButton(
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              dropdownColor: MyColors.primary,
              value: category,
              focusColor: Colors.white,
              iconEnabledColor: Colors.white,
              hint: Text(
                "All",
                style: TextStyle(color: Colors.white),
              ),
              items: categories.map((e) {
                return DropdownMenuItem(
                  child: AutoSizeText(
                    e.name,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  value: e,
                );
              }).toList(),
              onChanged: (Category cate) {
                setState(() {
                  category = cate.name != "All" ? cate : null;
                  pageNo = 0;
                  totalRecord = 0;
                  doctors.clear();
                  nameController.clear();
                });
                nameFocus.unfocus();
                FocusScope.of(context).requestFocus(FocusNode());
                getDoctors();
              }),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: TextField(
              focusNode: nameFocus,
              controller: nameController,
              onEditingComplete: () {
                nameFocus.unfocus();
                setState(() {
                  totalRecord = 0;
                  doctors.clear();
                  getDoctors();
                });
              },
              textInputAction: TextInputAction.search,
              maxLength: 60,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search by Name',
                  prefixIcon: Icon(Icons.search),
                  counterText: "",
                  suffix: GestureDetector(
                      onTap: () {
                        nameFocus.unfocus();
                        setState(() {
                          nameController.clear();
                          pageNo = 0;
                          totalRecord = 0;
                          doctors.clear();
                          getDoctors();
                        });
                      },
                      child: Icon(Icons.close))),
            ),
          ),
          doctors.isNotEmpty
              ? Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 4),
                          controller: controller,
                          itemBuilder: (BuildContext context, int index) =>
                              doctorListView(context, index),
                          itemCount: doctors.length,
                        ),
                      ),
                      Visibility(
                        visible: isLoading,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: LinearProgressIndicator()),
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        doctors.isEmpty && !isLoading
                            ? Text("No Doctor Found")
                            : CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget doctorListView(BuildContext context, int index) {
    ResponseDetail doctorModel = doctors[index];
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade400))),
            child: InkWell(
              onTap: () {
                Route route = new MaterialPageRoute(
                    builder: (context) => DoctorProfile(
                          username: doctorModel.username,
                        ));
                Navigator.push(context, route);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              color: Colors.white,
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fill,
                                placeholder: MyImages.doctorPlace,
                                image:
                                    doctorModel.imagepath ?? Keys.imageNotFound,
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  doctorModel.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  softWrap: false,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  doctorModel.speciality ?? "",
                                  style: TextStyle(color: Colors.black),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  doctorModel.fee ?? "0",
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: OutlineButton(
                    highlightElevation: 6,
                    highlightedBorderColor: MyColors.primary,
                    borderSide: BorderSide(color: MyColors.primary),
                    textColor: MyColors.primary,
                    onPressed: () {
                      Route route = new MaterialPageRoute(
                          builder: (context) => DoctorProfile(
                                username: doctorModel.username,
                              ));
                      Navigator.push(context, route);
                    },
                    child: Text('View Profile'),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    elevation: 0,
                    highlightElevation: 6,
                    textColor: Colors.white,
                    onPressed: () {
                      Route route = new MaterialPageRoute(
                          builder: (_) => BookAppointment(
                                drName: doctorModel.name,
                                drUsername: doctorModel.username,
                                category: doctorModel.speciality,
                                fee: doctorModel.fee,
                                image: doctorModel.imagepath,
                              ));
                      Navigator.push(context, route);
                    },
                    child: Text("Book Appointment"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    updateUi();
    controller = new ScrollController()..addListener(_scrollListener);
    doctors = [];
    categories = [Category(name: "All", id: 0)];
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void getDoctors() async {
    String name = nameController.text.trim();
    setState(() {
      isLoading = true;
    });

    String response;
    try {
      response = await Utilities.httpGet(ServerConfig.doctors +
          "&PageNumber=$pageNo&SearchPramas=$name&PageSize=10&Speciality=${category == null ? "0" : category.id}");
    } catch (e) {
      response = "404";
      print(e);
    }

    if (response != "404") {
      DoctorModel responseDetail = doctorModelFromJson(response);
      totalRecord = int.parse(responseDetail.response.response.recordsFiltered);
      if (!mounted) return;
      setState(() {
        doctors.addAll(responseDetail.response.response.data);
      });
    } else {
      Utilities.showToast("Unable to fetch doctors, try again later.");
    }

    setState(() {
      isLoading = false;
    });
  }

  void getCategory() async {
    String response = await Utilities.httpGet(ServerConfig.categories);
    if (response != "404") {
      var list = categoryFromJson(response).response.categoryList;
      if (!mounted) return;
      setState(() {
        categories.addAll(list);
      });
    } else {
      Utilities.showToast("Unable to load Categories");
    }
  }

  void updateUi() async {
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable(context);
      return;
    }

    getDoctors();
    getCategory();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (doctors.length < totalRecord && !isLoading) {
        pageNo++;
        getDoctors();
      }
    }
  }
}
