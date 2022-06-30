import 'package:amc/models/medical_record_model.dart';
import 'package:amc/Styles/MyImages.dart';
import 'package:amc/Widgets/cache_image.dart';
import 'package:flutter/material.dart';

class MyHealthRecordDetails extends StatelessWidget {
  final HealthRecord record;

  const MyHealthRecordDetails(this.record, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(record.fileName),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height/2
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10
                          )
                        ]
                    ),
                    child: NetWorkImage(
                      placeHolder: MyImages.instaFile,
                      imagePath: record.filePath,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Text("File Name"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(record.fileName),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Text("File Type"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(record.recordType),
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Text("Description"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(record.description ?? ""),
                    )
                  ],
                ),
              ),
              const Divider(),

            ],
          ),
        ),
    );
  }
}