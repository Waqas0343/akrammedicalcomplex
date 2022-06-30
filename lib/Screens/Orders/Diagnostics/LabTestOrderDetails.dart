import 'package:amc/models/lab_test_order_model.dart';
import 'package:amc/models/lab_test_search_model.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:flutter/material.dart';

class LabTestOrderDetails extends StatelessWidget {
  final TestOrder order;

  const LabTestOrderDetails(this.order,{Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order # "+order.orderId),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            order.testList == null ? Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10)
                  ]),
                  child: NetWorkImage(
                    placeHolder: MyImages.instaFile,
                    imagePath: order.prescriptionPath,
                  ),
                ),
              ),
            ) : const SizedBox.shrink(),
            Padding(
              padding:
              const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Text("Order Status"),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(order.status),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding:
              const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Text("Name"),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(order.name),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding:
              const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Text("Phone"),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(order.phone),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding:
              const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Text("Address"),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(order.location),
                  )
                ],
              ),
            ),
            const Divider(),
            order.testList != null
                ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Lab Test(s)",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            )
                : const SizedBox.shrink(),
            order.testList != null
                ? ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  makeList(context, index),
              itemCount: order.testList.length,
            )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }


  Widget makeList(BuildContext context, int index) {
    Test medicine = order.testList[index];
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      title: AutoSizeText(
        medicine.testName ?? "",
        maxLines: 2,
      ),
      subtitle: Text(medicine.fee ?? ""),
      leading: SizedBox(
          width: 30,
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ))),
      dense: true,
    );
  }
}

