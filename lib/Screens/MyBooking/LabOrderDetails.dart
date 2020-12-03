import 'package:amc/Widgets/cache_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amc/Models/SearchTeshModel.dart';
import 'package:amc/Models/TestOrderResponseModel.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:flutter/material.dart';

import '../LabReports/ViewReport.dart';

class LabOrderDetails extends StatefulWidget {
  final TestModel testModel;

  const LabOrderDetails({Key key, this.testModel}) : super(key: key);

  @override
  _LabOrderDetailsState createState() => _LabOrderDetailsState();
}

class _LabOrderDetailsState extends State<LabOrderDetails> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Order # ${widget.testModel.orderId}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            orderDetails(),
            widget.testModel.testList == null ? SizedBox.shrink() : testCard(),
            widget.testModel.attachmentsResults == null
                ? SizedBox.shrink()
                : viewReport(),
          ],
        ),
      ),
    );
  }

  Widget makeList(BuildContext context, int index) {
    Test test = widget.testModel.testList[index];
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      title: AutoSizeText(
        test.testName,
        maxLines: 1,
      ),
      subtitle: Text(test.fee.replaceAll("Rs/-", "PKR/-")),
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

  Widget testCard() {
    return Card(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              "Test(s)",
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
                itemCount: widget.testModel.testList.length,
              ),
            ),
          )
        ],
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
            widget.testModel.testList == null
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
                          child: NetWorkImage(
                            placeHolder:
                              MyImages.instaFile,
                            imagePath:
                              widget.testModel.prescriptionPath,
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
                      widget.testModel.status,
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
                    child: Text(widget.testModel.name),
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
                    child: Text(widget.testModel.phone),
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
                    child: Text(widget.testModel.location ?? ""),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget viewReport() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 4),
      child: ListTile(
        title: Text("View Report"),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
        onTap: () {
          Route route = new MaterialPageRoute(
              builder: (_) => ViewReport(
                    path: widget.testModel.attachmentsResults,
                    name: widget.testModel.orderId,
                  ));
          Navigator.push(context, route);
        },
      ),
    );
  }
}
