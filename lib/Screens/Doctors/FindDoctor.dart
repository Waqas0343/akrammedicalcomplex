import 'package:amc/Models/DoctorResponseModel.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:amc/placeholder/custom_shimmer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Models/CategoryModel.dart';
import 'package:amc/Screens/BookAppointment/BookAppointment.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Widgets/lazy_loader_widget.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:flutter/material.dart';

import 'DoctorProfile.dart';

class FindDoctor extends StatefulWidget {
  final bool isSearching;

  const FindDoctor({Key key, this.isSearching}) : super(key: key);

  @override
  _FindDoctorState createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Find Doctor");
  bool isLoading = false, hasMore = true;
  int totalRecord = 0, pageNo = 0;

  List<ResponseDetail> doctors;

  Category category;
  List<Category> categories;

  final nameFocus = FocusNode();

  final nameController = TextEditingController();

  Future<void> doctorSpecialtyDialogBox() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Specialty"),
          content: Container(
            child: DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(
                  filled: false,
                  hintText: "All",
                  hintStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                value: category,
                focusColor: Colors.black,
                iconEnabledColor: Colors.black,
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
                  Navigator.of(context).pop();
                  setState(() {
                    category = cate.name != "All" ? cate : null;
                    pageNo = 0;
                    totalRecord = 0;
                    doctors.clear();
                    nameController.clear();
                  });
                  nameFocus.unfocus();
                  FocusScope.of(context).requestFocus(FocusNode());
                  checkInternet();
                }),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: this.cusSearchBar,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setAppBarValue();
            },
            icon: cusIcon,
          ),
          IconButton(
            onPressed: () {
              doctorSpecialtyDialogBox();
            },
            icon: Icon(
              Icons.filter_alt_sharp,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          doctors.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= doctors.length) {
                        if (!isLoading) {
                          checkInternet();
                        }
                        return LazyLoader();
                      }
                      return doctorListView(context, index);
                    },
                    itemCount:
                        hasMore ? doctors.length + 1 : doctors.length,
                  ),
                )
              : Expanded(
                  child: doctors.isEmpty && !isLoading
                      ? Center(
                          child: Text("No Doctor Found"),
                        )
                      : LoadingDoctorsList(),
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
                            child: NetWorkImage(
                              placeHolder: MyImages.doctorPlace,
                              imagePath: doctorModel.imagepath,
                              width: 48,
                              height: 48,
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
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                  softWrap: false,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  doctorModel.speciality ?? "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
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
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 16),
                  //   child: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
                right: 12,
                left: 12,
                top: 0,
              ),
              child: GestureDetector(
                onTap: () {
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
                child: Text(
                  "Book Appointment",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         flex: 1,
          //         child: OutlineButton(
          //           highlightElevation: 6,
          //           highlightedBorderColor: MyColors.primary,
          //           borderSide: BorderSide(color: MyColors.primary),
          //           textColor: MyColors.primary,
          //           onPressed: () {
          //             Route route = new MaterialPageRoute(
          //                 builder: (context) => DoctorProfile(
          //                       username: doctorModel.username,
          //                     ));
          //             Navigator.push(context, route);
          //           },
          //           child: Text('View Profile'),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 8,
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: RaisedButton(
          //           elevation: 0,
          //           highlightElevation: 6,
          //           textColor: Colors.white,
          //           onPressed: () {
          //             Route route = new MaterialPageRoute(
          //                 builder: (_) => BookAppointment(
          //                       drName: doctorModel.name,
          //                       drUsername: doctorModel.username,
          //                       category: doctorModel.speciality,
          //                       fee: doctorModel.fee,
          //                       image: doctorModel.imagepath,
          //                     ));
          //             Navigator.push(context, route);
          //           },
          //           child: Text("Book Appointment"),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  void setAppBarValue() {
    setState(() {
      if (this.cusIcon.icon == Icons.search) {
        this.cusIcon = Icon(Icons.cancel);
        this.cusSearchBar = TextField(
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white,
          ),
          focusNode: nameFocus,
          autofocus: widget.isSearching,
          controller: nameController,
          onEditingComplete: () {
            nameFocus.unfocus();
            setState(() {
              pageNo = 0;
              totalRecord = 0;
              doctors.clear();
            });
            checkInternet();
          },
          textInputAction: TextInputAction.search,
          maxLength: 60,
          decoration: InputDecoration(
            filled: false,
            hintText: 'Search by Name',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            counterText: "",
          ),
        );
      } else {
        this.cusIcon = Icon(Icons.search);
        this.cusSearchBar = Text("Find Doctor");
        nameController.clear();
        pageNo = 0;
        totalRecord = 0;
        doctors.clear();
        checkInternet();
      }
    });
  }

  @override
  void initState() {
    updateUi();
    if (widget.isSearching) {
      this.cusIcon = Icon(Icons.search);
      setAppBarValue();
    }
    doctors = [];
    categories = [Category(name: "All", id: 0)];
    super.initState();
  }

  void getDoctors() async {
    String name = nameController.text.trim();
    setState(() => isLoading = true);

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
      if (!mounted) return;
      var list = responseDetail.response.response.data;
      if (list.length < 10) {
        hasMore = false;
      } else {
        hasMore = true;
      }
      setState(() {
        doctors.addAll(list);
        pageNo++;
      });
    } else {
      Utilities.showToast("Unable to fetch doctors, try again later.");
    }
    setState(() => isLoading = false);
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

  void checkInternet() async {
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable(context);
      setState(() => isLoading = false);
      return;
    }
    getDoctors();
  }

  void updateUi() async {
    if (!await Utilities.isOnline()) {
      Utilities.internetNotAvailable(context);
      return;
    }
    getDoctors();
    getCategory();
  }
}
