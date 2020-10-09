import 'package:amc/Models/MedicineOrderModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:flutter/material.dart';

class MedicineOrderDetails extends StatefulWidget {
  final Order order;

  MedicineOrderDetails(this.order);

  @override
  _MedicineOrderDetailsState createState() => _MedicineOrderDetailsState();
}

class _MedicineOrderDetailsState extends State<MedicineOrderDetails> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order # " + widget.order.orderId),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            orderDetails(),
            widget.order.medicines.isEmpty ? SizedBox.shrink() : medicineCard(),
          ],
        ),
      ),
    );
  }
  Widget orderDetails() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.order.medicines.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, right: 8, left: 8, bottom: 8),
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
                          child: FadeInImage(
                            placeholder: AssetImage(
                              MyImages.instaFile,
                            ),
                            image: NetworkImage(
                              widget.order.prescriptionPath ?? "Not Found",
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Text(
                "Order Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 8,
            ),
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
                    child: Text(
                      widget.order.status,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                    child: Text(widget.order.name),
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
                    child: Text(widget.order.phone),
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
                    child: Text(widget.order.address ?? ""),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget medicineCard() {
    return Card(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              "Medicine(s)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            trailing: Icon(isExpanded
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),
          ),
          Visibility(
            visible: isExpanded,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 8),
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    makeList(context, index),
                itemCount: widget.order.medicines.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget makeList(BuildContext context, int index) {
    PrescriptionConverterModel medicine = widget.order.medicines[index];
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      title: AutoSizeText(
        medicine.productName ?? "",
        maxLines: 2,
      ),
      subtitle: Text("PKR/- " + medicine.productPrice ?? ""),
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
