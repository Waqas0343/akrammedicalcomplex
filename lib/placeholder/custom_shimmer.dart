import 'package:amc/Styles/MyColors.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingDoctorsList extends StatelessWidget {
  const LoadingDoctorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) => Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Shimmer.fromColors(
          baseColor: MyColors.divider,
          highlightColor: MyColors.highLight,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: const ClipRRect(
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
                                children: const <Widget>[
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
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
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
  const LoadingServicesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: const CheckboxListTile(
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
  const MyServicesLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: Column(
                    children: const [
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
  const DoctorDetailLoading({Key? key}) : super(key: key);

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
                              children: const [
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
                                  children: const <Widget>[
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
                    const ListTile(
                      leading: MyShimmer(
                        height: 24,
                        width: 24,
                      ),
                      title: MyShimmer(
                        width: 40,
                        height: 14,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: const <Widget>[
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
                    const Divider(),
                    ListTile(
                      leading: const MyShimmer(
                        width: 24,
                        height: 24,
                      ),
                      title: const MyShimmer(width: 40, height: 14),
                      subtitle: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
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
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
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
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
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
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
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
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
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
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
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
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
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
                    const Divider(),
                    ListTile(
                      leading: const MyShimmer(
                        width: 24,
                        height: 24,
                      ),
                      title: const MyShimmer(width: 40, height: 14),
                      subtitle: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: const <Widget>[
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
                    const Divider(),
                    ListTile(
                      leading: const MyShimmer(
                        width: 24,
                        height: 24,
                      ),
                      title: const MyShimmer(width: 40, height: 14),
                      subtitle: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  child: MyShimmer(
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const <Widget>[
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
  const AppointmentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Column(
        children: [
          Container(
            height: 65.0,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 12),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 65,
                        height: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: 55,
                        height: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 40,
                        color: Colors.grey,
                        height: 6,
                      ),
                    ],
                  ),
                );
              },
              itemCount: 3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: MediaQuery.of(context).size.height / 1000,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 7,
                mainAxisSpacing: 8,
                scrollDirection: Axis.vertical,
                children: [
                  1,
                  2,
                  3,
                  4,
                ]
                    .map((e) => Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                        ))
                    .toList()),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12),
            child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: MediaQuery.of(context).size.height / 400,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                scrollDirection: Axis.vertical,
                children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
                    .map((e) => Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                        ))
                    .toList()),
          ),
        ],
      ),
      baseColor: MyColors.divider,
      highlightColor: MyColors.highLight,
    );
  }
}

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({Key? key}) : super(key: key);

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
              const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: MyShimmer(
                  height: 100,
                  width: 110,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyShimmer(
                        width: 50,
                        height: 22,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const MyShimmer(
                        width: 50,
                        height: 22,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const MyShimmer(
                        width: 50,
                        height: 18,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                            color: MyColors.accent,
                            borderRadius: BorderRadius.circular(8)),
                        child: const MyShimmer(
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
          const SizedBox(
            height: 12,
          ),
          SizedBox(
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
                          children: const [
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
                            SizedBox(
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: MediaQuery.of(context).size.height / 400,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                scrollDirection: Axis.vertical,
                children: List.generate(3, (e) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        child: MyShimmer(
                          width: 30,
                          height: 13,
                        ),
                      ),
                    ),
                  );
                }).toList()),
          ),
          const CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: false,
            onChanged: null,
            activeColor: MyColors.primary,
            checkColor: Colors.white,
            title: MyShimmer(
              width: 30,
              height: 13,
            ),
          ),
          MyShimmer(
            width: MediaQuery.of(context).size.width,
            height: 40,
          ),
        ],
      ),
    );
  }
}

class MyLabOrderIsLoading extends StatelessWidget {
  const MyLabOrderIsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: ListTile(
                    title: const MyShimmer(
                      width: 50,
                      height: 14,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
                    leading: const MyShimmer(
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
  const MyMedicineOrdersIsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemBuilder: (BuildContext context, int index) => Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Shimmer.fromColors(
                baseColor: MyColors.divider,
                highlightColor: MyColors.highLight,
                child: ListTile(
                  title: const MyShimmer(
                    width: 50,
                    height: 14,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
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
                  leading: const MyShimmer(
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
  const LoadingMyAppointmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: ListTile(
                    leading: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: MyShimmer(
                        width: 60,
                        height: 60,
                      ),
                    ),
                    title: const MyShimmer(
                      width: 60,
                      height: 14,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
  const LoadingMyPrescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: ListTile(
                    leading: const MyShimmer(
                      width: 38,
                      height: 38,
                    ),
                    title: const MyShimmer(
                      width: 40,
                      height: 14,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
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
  const LoadingHealthRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              elevation: 4,
              child: Shimmer.fromColors(
                baseColor: MyColors.divider,
                highlightColor: MyColors.highLight,
                child: const ListTile(
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
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.divider,
      highlightColor: MyColors.highLight,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: MyShimmer(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 28,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            child: Badge(
              badgeContent: const MyShimmer(
                width: 24,
                height: 24,
              ),
              padding: const EdgeInsets.all(1),
              badgeColor: Colors.white,
              elevation: 0,
              position: BadgePosition.bottomEnd(bottom: 0, end: 0),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: MyShimmer(
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: const <Widget>[
              Expanded(
                flex: 0,
                child: MyShimmer(
                  width: 50,
                  height: 30,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: MyShimmer(
                  width: 60,
                  height: 30,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          MyShimmer(
            width: MediaQuery.of(context).size.width,
            height: 30,
          ),
          const SizedBox(
            height: 8,
          ),
          MyShimmer(
            width: MediaQuery.of(context).size.width,
            height: 30,
          ),
          const SizedBox(
            height: 8,
          ),

          // email
          MyShimmer(
            width: MediaQuery.of(context).size.width,
            height: 30,
          ),
          const SizedBox(
            height: 8,
          ),
          MyShimmer(
            width: MediaQuery.of(context).size.width,
            height: 30,
          ),
        ],
      ),
    );
  }
}

class MyLabReportsShimmer extends StatelessWidget {
  const MyLabReportsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                elevation: 4,
                child: Shimmer.fromColors(
                  baseColor: MyColors.divider,
                  highlightColor: MyColors.highLight,
                  child: Column(
                    children: [
                      const ListTile(
                        subtitle: MyShimmer(
                          width: 50,
                          height: 12,
                        ),
                        title: MyShimmer(
                          width: 50,
                          height: 14,
                        ),
                        trailing: MyShimmer(
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Visibility(
                          visible: false,
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(
                                bottom: 8, left: 16, right: 16, top: 8),
                            title: Container(
                                margin: const EdgeInsets.only(left: 8),
                                alignment: Alignment.centerLeft,
                                child: const MyShimmer(
                                  height: 50,
                                  width: 70,
                                )),
                            trailing: const MyShimmer(
                              width: 18,
                              height: 18,
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
  final double? width;
  final double? height;

  const MyShimmer({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
    );
  }
}
