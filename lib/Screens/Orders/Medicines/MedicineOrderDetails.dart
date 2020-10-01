import 'package:amc/Models/MedicineOrderModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:flutter/material.dart';

class MedicineOrderDetails extends StatelessWidget {
  final Order order;

  MedicineOrderDetails(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order # " + order.orderId),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            order.medicines.isEmpty
                ? Padding(
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
                        child: FadeInImage.assetNetwork(
                          placeholder: MyImages.instaFile,
                          image: order.prescriptionPath,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
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
            Divider(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
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
            Divider(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
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
            Divider(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text("Address"),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(order.address),
                  )
                ],
              ),
            ),
            Divider(),
            order.medicines.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Medicines",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )
                : SizedBox.shrink(),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  makeList(context, index),
              itemCount: order.medicines.length,
            )
          ],
        ),
      ),
    );
  }

  Widget makeList(BuildContext context, int index) {
    PrescriptionConverterModel medicine = order.medicines[index];
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      title: AutoSizeText(
        medicine.productName ?? "",
        maxLines: 2,
      ),
      subtitle: Text(medicine.productPrice ?? ""),
      leading: Container(
          width: 30,
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${index + 1}',
                style: TextStyle(fontWeight: FontWeight.w600),
              ))),
      dense: true,
    );
  }
}
