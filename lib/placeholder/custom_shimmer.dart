import 'package:amc/Styles/MyColors.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class LoadingDoctorsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) => Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Shimmer.fromColors(
          baseColor: MyColors.divider,
          highlightColor: MyColors.highLight,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              child: MyShimmer(
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
                                  MyShimmer(
                                    width: 70,
                                    height: 14,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  MyShimmer(
                                    width: 50,
                                    height: 12,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  MyShimmer(
                                    width: 50,
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                  child: MyShimmer(
                    width: 60,
                    height: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: CheckboxListTile(
                    title: MyShimmer(
                      width: 40,
                      height: 14,
                    ),
                    subtitle: MyShimmer(
                      width: 40,
                      height: 12,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: false,
                    onChanged: null,
                  ),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}

class MyServicesLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: Column(
                    children: [
                      ListTile(
                        title: MyShimmer(
                          width: 60,
                          height: 14,
                        ),
                        subtitle: MyShimmer(
                          width: 40,
                          height: 12,
                        ),
                        trailing: MyShimmer(
                          width: 10,
                          height: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}

class DoctorDetailLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Shimmer.fromColors(
          baseColor: MyColors.divider,
          highlightColor: MyColors.highLight,
          child: Column(
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
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  child: MyShimmer(
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 2,
                                    ),
                                    MyShimmer(
                                      width: 60,
                                      height: 14,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    MyShimmer(
                                      width: 40,
                                      height: 12,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    MyShimmer(
                                      width: 60,
                                      height: 20,
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
                      leading: MyShimmer(
                        height: 24,
                        width: 24,
                      ),
                      title: MyShimmer(
                        width: 40,
                        height: 14,
                      ),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            leading: MyShimmer(
                              height: 24,
                              width: 24,
                            ),
                            title: MyShimmer(
                              width: 40,
                              height: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            leading: MyShimmer(
                              height: 24,
                              width: 24,
                            ),
                            title: MyShimmer(
                              width: 40,
                              height: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    ListTile(
                      leading: MyShimmer(
                        width: 24,
                        height: 24,
                      ),
                      title: MyShimmer(width: 40, height: 14),
                      subtitle: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                              MyShimmer(
                                width: 40,
                                height: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: MyShimmer(
                        width: 24,
                        height: 24,
                      ),
                      title: MyShimmer(width: 40, height: 14),
                      subtitle: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                MyShimmer(
                                  width: 18,
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: MyShimmer(width: 40, height: 12),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: 1,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: MyShimmer(
                        width: 24,
                        height: 24,
                      ),
                      title: MyShimmer(width: 40, height: 14),
                      subtitle: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  child: MyShimmer(
                                    width: 30,
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
                                      MyShimmer(width: 40, height: 12),
                                      MyShimmer(width: 40, height: 12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: MyShimmer(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Column(
          children: [
            Container(
              height: 65.0,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(left: 12),
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    padding: EdgeInsets.only(right: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 65,height: 16,color: Colors.grey,),
                        SizedBox(height: 12,),
                        Container(width: 55, height: 12,color: Colors.grey,),
                        SizedBox(height: 6,),
                        Container(
                          width: 40,
                          color: Colors.grey,
                          height: 6,
                        ),
                      ],),
                  );
                }, itemCount: 3,
                scrollDirection: Axis.horizontal,),
            ),
            Container(
              margin: const EdgeInsets.only(left: 12,right: 12),
              child: GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: MediaQuery.of(context).size.height / 400,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  scrollDirection: Axis.vertical,
                  children: [1,2,3,4,5,6,7,8,9,10,11].map((e) =>
                      Container(decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),)
                  ).toList()
              ),
            ),
          ],
        ),
        baseColor: MyColors.divider,
        highlightColor: MyColors.highLight,
    );
  }
}

class BookAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.divider,
      highlightColor: MyColors.highLight,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: MyShimmer(
                  height: 100,
                  width: 110,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyShimmer(
                        width: 50,
                        height: 22,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      MyShimmer(
                        width: 50,
                        height: 22,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      MyShimmer(
                        width: 50,
                        height: 18,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                            color: MyColors.accent,
                            borderRadius: BorderRadius.circular(8)),
                        child: MyShimmer(
                          width: 40,
                          height: 12,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 65.0,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.transparent,
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyShimmer(
                              width: 40,
                              height: 20,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            MyShimmer(
                              width: 40,
                              height: 16,
                            ),
                            Container(
                              width: 40,
                              child: Divider(
                                color: MyColors.primary,
                                height: 10,
                                thickness: 3,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: MediaQuery.of(context).size.height / 400,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                scrollDirection: Axis.vertical,
                children: List.generate(3, (e) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: new Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        child: const MyShimmer(
                          width: 30,
                          height: 13,
                        ),
                      ),
                    ),
                  );
                }).toList()),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: false,
            onChanged: null,
            activeColor: MyColors.primary,
            checkColor: Colors.white,
            title: MyShimmer(width: 30, height: 13,),
          ),
          MyShimmer(width: MediaQuery.of(context).size.width, height: 40,),
        ],
      ),
    );
  }
}

class MyLabOrderIsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: ListTile(
                    title: MyShimmer(
                      width: 50,
                      height: 14,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        MyShimmer(
                          width: 40,
                          height: 12,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        MyShimmer(
                          width: 40,
                          height: 12,
                        )
                      ],
                    ),
                    leading: MyShimmer(
                      height: 90,
                      width: 70,
                    ),
                  ),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}

class MyMedicineOrdersIsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 4),
            itemBuilder: (BuildContext context, int index) => Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Shimmer.fromColors(
                baseColor: MyColors.divider,
                highlightColor: MyColors.highLight,
                child: ListTile(
                  title: MyShimmer(
                    width: 50,
                    height: 14,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 4,
                      ),
                      MyShimmer(
                        width: 50,
                        height: 12,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      MyShimmer(
                        width: 50,
                        height: 12,
                      ),
                    ],
                  ),
                  leading: MyShimmer(
                    height: 90,
                    width: 70,
                    // height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
            ),
            itemCount: 3,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }
}

class LoadingMyAppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: MyShimmer(
                        width: 60,
                        height: 60,
                      ),
                    ),
                    title: MyShimmer(
                      width: 60,
                      height: 14,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        MyShimmer(
                          width: 60,
                          height: 12,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        MyShimmer(
                          width: 60,
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}

class LoadingMyPrescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: ListTile(
                    leading: MyShimmer(
                      width: 38,
                      height: 38,
                    ),
                    title: MyShimmer(
                      width: 40,
                      height: 14,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        MyShimmer(
                          width: 40,
                          height: 12,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        MyShimmer(
                          width: 40,
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: 3,
            ),
          ),
        ),
      ],
    );
  }
}

class LoadingHealthRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              elevation: 4,
              child: Shimmer.fromColors(
                baseColor: MyColors.divider,
                highlightColor: MyColors.highLight,
                child: ListTile(
                  leading: MyShimmer(
                    width: 70,
                    height: 70,
                  ),
                  title: MyShimmer(
                    width: 50,
                    height: 14,
                  ),
                  subtitle: MyShimmer(
                    width: 40,
                    height: 12,
                  ),
                  trailing: MyShimmer(
                    width: 18,
                    height: 18,
                  ),
                ),
              ),
            ),
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}

class ProfileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: MyColors.divider,
        highlightColor: MyColors.highLight,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: MyShimmer(width: MediaQuery.of(context).size.width * 0.7, height: 28,),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                margin: EdgeInsets.only(top: 8, bottom: 16),
                child: Badge(
                  badgeContent: MyShimmer(width: 24, height: 24,),
                  padding: EdgeInsets.all(1),
                  badgeColor: Colors.white,
                  elevation: 0,
                  position:
                  BadgePosition.bottomRight(bottom: 0, right: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: MyShimmer(width: 80, height: 80,),
                  ),
                ),),
            SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: MyShimmer(width: 50, height: 30,),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: MyShimmer(width: 60, height: 30,),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            MyShimmer(width: MediaQuery.of(context).size.width, height: 30,),
            SizedBox(
              height: 8,
            ),
            MyShimmer(width: MediaQuery.of(context).size.width, height: 30,),
            SizedBox(
              height: 8,
            ),

            // email
            MyShimmer(width: MediaQuery.of(context).size.width, height: 30,),
            SizedBox(
              height: 8,
            ),
            MyShimmer(width: MediaQuery.of(context).size.width, height: 30,),
          ],
        ),
      ),
    );
  }
}

class MyLabReportsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: Column(
                    children: [
                      ListTile(
                        subtitle: MyShimmer(width: 50, height: 12,),
                        title: MyShimmer(width: 50, height: 14,),
                        trailing: MyShimmer(width: 20, height: 20,),
                      ),
                      Visibility(
                          visible: false,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                                bottom: 8,
                                left: 16,
                                right: 16,
                                top: 8),
                            title: Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: MyShimmer(
                                  height: 50,
                                  width: 70,
                                )),
                            trailing: MyShimmer(
                              width: 18, height: 18,
                            ),
                          ))
                    ],
                  ),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}


class MyShimmer extends StatelessWidget {
  final double width;
  final double height;

  const MyShimmer({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
    );
  }
}
