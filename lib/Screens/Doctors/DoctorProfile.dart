
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Models/DoctorResponseModel.dart';
import 'package:amc/Screens/BookAppointment/BookAppointment.dart';
import 'package:amc/Server/ServerConfig.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:amc/Styles/MyColors.dart';
import 'package:amc/Styles/MyIcons.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Utilities/Utilities.dart';
import 'package:amc/Widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProfile extends StatefulWidget {
  final String username;

  const DoctorProfile({Key key, this.username}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState(this.username);
}

class _DoctorProfileState extends State<DoctorProfile> {
  String sessionToken;
  final String username;

  DocProfile doctorProfile;

  SharedPreferences preferences;

  _DoctorProfileState(this.username);


  @override
  Widget build(BuildContext context) {
    String mon, tues, wed, thur, fri, sat, sun, qualification;
    if (doctorProfile != null) {
      Weeklyschedule week = doctorProfile.assosiations[0].weeklyschedule;
      mon = week.monday;
      tues = week.tuesday;
      wed = week.wednesday;
      thur = week.thursday;
      fri = week.friday;
      sat = week.saturday;
      sun = week.sunday;
      qualification = doctorProfile.qualifications.join(", ");
    }

    return doctorProfile == null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: MyColors.primary,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 70, bottom: 16, right: 16, left: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 0, bottom: 4),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                          child: Container(
                                            color: Colors.white,
                                            child: FadeInImage.assetNetwork(
                                              image: doctorProfile.imagePath ?? Keys.imageNotFound,
                                              placeholder: MyImages.doctorPlace,
                                              width: 70,height: 70,
                                            ),
                                          ),
                                        )),
                                    // doctorProfile.isOnline
                                    //     ? Row(
                                    //   children: [
                                    //     Icon(
                                    //       MdiIcons.circle,
                                    //       size: 14,
                                    //       color: Colors.lightGreen,
                                    //     ),
                                    //     SizedBox(
                                    //       width: 4,
                                    //     ),
                                    //     Text(
                                    //       "Online",
                                    //       style: TextStyle(
                                    //           color: Colors.lightGreen),
                                    //     )
                                    //   ],
                                    // )
                                    //     : SizedBox.shrink()
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        AutoSizeText(
                                          doctorProfile.name,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        AutoSizeText(
                                          doctorProfile.speciality.name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        AutoSizeText(
                                          qualification ?? "",
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            MyIcons.icRupee,
                            height: 24,
                            width: 24,
                            color: Colors.grey.shade500,
                          ),
                          title: Text("PKR ${doctorProfile
                              .assosiations[0].regularCharges ??
                              "N/A"}"),
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  MyIcons.icLike,
                                  height: 24,
                                  width: 24,
                                  color: Colors.grey.shade500,
                                ),
                                title: AutoSizeText(
                                  doctorProfile.averageRating == "NAN"
                                      ? doctorProfile.averageRating
                                      : "N/A",
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  MyIcons.icBag,
                                  height: 24,
                                  width: 24,
                                  color: Colors.grey.shade500,
                                ),
                                title: AutoSizeText(
                                  doctorProfile.experience ?? "N/A",
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        ListTile(
                          leading: SvgPicture.asset(
                            MyIcons.icMap,
                            height: 24,
                            width: 24,
                            color: Colors.grey,
                          ),
                          title: Text(
                              doctorProfile.assosiations[0].location ?? ""),
                          subtitle: AutoSizeText(
                            doctorProfile.assosiations[0].fullAddress ?? "",
                            maxLines: 1,
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: SvgPicture.asset(
                            MyIcons.icClock,
                            width: 24,
                            height: 24,
                            color: Colors.grey,
                          ),
                          title: Text("Timings"),
                          subtitle: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Monday"),
                                  Text(mon ?? ""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Tuesday"),
                                  Text(tues ?? ""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Wednesday"),
                                  Text(wed ?? ""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Thursday"),
                                  Text(thur ?? ""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Friday"),
                                  Text(fri ?? ""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Saturday"),
                                  Text(sat ?? ""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Sunday"),
                                  Text(sun ?? ""),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: SvgPicture.asset(
                            MyIcons.icService,
                            width: 24,
                            height: 24,
                            color: Colors.grey,
                          ),
                          title: Text("Services"),
                          subtitle: doctorProfile.services.isNotEmpty
                              ? ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      MdiIcons.circleSmall,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                        child: Text(
                                          doctorProfile.services[index].name,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                        ))
                                  ],
                                ),
                              );
                            },
                            itemCount: doctorProfile.services.length,
                          )
                              : Text("N/A"),
                        ),
                        Divider(),
                        ListTile(
                          leading: SvgPicture.asset(
                            MyIcons.icReview,
                            width: 24,
                            height: 24,
                            color: Colors.grey,
                          ),
                          title: Text("Reviews"),
                          subtitle: doctorProfile.reviews.isNotEmpty
                              ? ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)),
                                      child: FadeInImage.assetNetwork(
                                        image: doctorProfile
                                            .reviews[index].imagePath,
                                        fit: BoxFit.cover,
                                        placeholder: MyImages.user,
                                        fadeInDuration:
                                        Duration(milliseconds: 100),
                                        height: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            doctorProfile.reviews[index]
                                                .title ??
                                                "",
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          Text(
                                            doctorProfile.reviews[index]
                                                .description ??
                                                "",
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: doctorProfile.reviews.length,
                          )
                              : Text("N/A"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      child: Text("Book Appointment"),
                      textColor: Colors.white,
                      onPressed: () {
                        Route route = new MaterialPageRoute(builder: (_)=>
                            BookAppointment(drUsername: doctorProfile.username,
                              drName: doctorProfile.name,
                              fee: doctorProfile.assosiations[0].regularCharges,
                              category: doctorProfile.speciality.name,
                              image: doctorProfile.imagePath,
                            ));
                        Navigator.push(context, route);
                      },
                    ),
                  )
                ],
              ),
              floatingActionButton: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: Colors.grey.withOpacity(0.6),
                    mini: true,
                    child: Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
    getProfile();
  }

  void getProfile() async {
    Loading.build(context, true);
    String response = await Utilities.httpGet(ServerConfig.doctorProfile +
        "&Username=$username" +
        "&SessionToken=$sessionToken");

    if (response != "404") {
      setState(() {
        doctorProfile =
            doctorProfileFromJson(response).doctorProfileResponse.docProfile;
      });
    } else {
      Utilities.showToast("Something went wrong");
    }
    print(response);
    Loading.dismiss();
  }

  void getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    sessionToken = preferences.getString(Keys.sessionToken);
  }
}
