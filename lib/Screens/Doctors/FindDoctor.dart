import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Models/CategoryModel.dart';
import 'package:amc/Models/DoctorResponseModel.dart';
import 'package:amc/Screens/BookAppointment/BookAppointment.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

import 'DoctorProfile.dart';

class FindDoctor extends StatefulWidget {
  @override
  _FindDoctorState createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  int pageNo = 0;
  int totalPage = 0;
  int totalRecord = 0;

  List<DoctorModel> doctors;

  Category category;
  List<Category> categories;

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
                  totalPage = 0;
                  totalRecord = 0;
                  doctors.clear();
                });
              }),
        ),
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: TextField(
                controller: nameController,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    pageNo = 0;
                    totalPage = 0;
                    totalRecord = 0;
                    doctors.clear();
                  });
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search by name',
                    prefixIcon: Icon(Icons.search),
                    suffix: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            nameController.clear();
                            pageNo = 0;
                            totalPage = 0;
                            totalRecord = 0;
                            doctors.clear();
                          });
                        },
                        child: Icon(Icons.close))),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              child: LoadMore(
                isFinish: totalPage < pageNo,
                onLoadMore: getDoctors,
                textBuilder: DefaultLoadMoreTextBuilder.english,
                child: ListView.builder(
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) =>
                      doctorListView(context, index),
                  itemCount: doctors.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget doctorListView(BuildContext context, int index) {
    DoctorModel doctorModel = doctors[index];
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
                                    doctorModel.imagePath ?? Keys.imageNotFound,
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8, bottom: 8, right: 16),
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    doctorModel.speciality ?? "",
                                    style: TextStyle(color: Colors.black),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
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
          // ListTile(
          //   dense: true,
          //   leading: ClipRRect(
          //       borderRadius: BorderRadius.all(Radius.circular(50)),
          //       child: Image.asset(
          //         MyImages.logo,
          //         height: 40,
          //         width: 40,
          //       )),
          //   title: Text(doctorModel.practiceName),
          //   subtitle: Text(
          //     doctorModel.location ?? "",
          //     softWrap: false,
          //     overflow: TextOverflow.fade,
          //   ),
          // ),
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
                                image: doctorModel.imagePath,
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
    super.initState();
    doctors = [];
    categories = [Category(name: "All")];
    getCategory();
  }

  Future<bool> getDoctors() async {
    String name = nameController.text.trim();

    if (await Utilities.isOnline()) {
      String response = await Utilities.httpGet(ServerConfig.doctors +
          "&ItemsPerPage=15" +
          "&PageNumber=$pageNo" +
          "&speciality=${category == null ? "" : category.id}" +
          '&city=' +
          "&SearchParam=$name" +
          "&Gender=");

      if (response != "404") {
        ResponseDetail responseDetail =
            doctorsFromJson(response).response.response;

        totalRecord = responseDetail.pagingDetails.totalRecords;
        pageNo = responseDetail.pagingDetails.pageNumber;
        totalPage = responseDetail.pagingDetails.totalPages;
        if (!mounted) return false;
        setState(() {
          doctors.addAll(responseDetail.doctors);
        });
        pageNo++;
        return true;
      } else {
        Utilities.showToast("Something went wrong");
        return false;
      }
    } else {
      Utilities.internetNotAvailable(context);
    }

    return false;
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
}
