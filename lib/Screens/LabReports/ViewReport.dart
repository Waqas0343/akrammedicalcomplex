import 'dart:async';
import 'dart:io';

import 'package:amc/Utilities/Utilities.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' show get;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class ViewReport extends StatefulWidget {
  final String path;
  final String name;

  ViewReport({Key key, this.path, this.name}) : super(key: key);

  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> with WidgetsBindingObserver {

  bool pdfReady = false, isError = false;
  String urlPDFPath = "";
  Directory externalDir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Order # "+widget.name),
      ),
      body: Center(
        child: pdfReady
            ? isError ? Text("Unable to Open File")
            : PDFView(
          filePath: urlPDFPath,
          autoSpacing: true,
          enableSwipe: true,
          pageSnap: true,
          swipeHorizontal: false,
          nightMode: false,
          onError: (e) {
            print(e);
          },
          onRender: (_pages) {

          },
          onViewCreated: (PDFViewController vc) {
          },
          onPageChanged: (int page, int total) {
          },
          onPageError: (page, e) {},
        )
            : CircularProgressIndicator(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ()=>downloadFile(),
      //   backgroundColor: MyColors.primary,
      //   foregroundColor: Colors.white,
      //   child: Icon(Icons.file_download),
      //
      // ),
    );
  }


  @override
  void initState() {
    super.initState();
    getFileFromUrl(widget.path);
  }


  Future<void> getFileFromUrl(String url) async {
    try {
      var data = await get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      String filename = widget.name.replaceAll(" ", "_");
      File file = File("${dir.path}/$filename.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      urlPDFPath = urlFile.path;
      setState(() {
        pdfReady = true;
      });
    } catch (e) {
      setState(() {
        isError = true;
        pdfReady = true;
      });
      print(e);
    }
  }


  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  Future<void> downloadFile() async {


    bool checkPermission1 = true;
    // await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
    // print(checkPermission1);
    // if (checkPermission1 == false) {
    //   await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    //   checkPermission1 = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
    // }

    if (checkPermission1){

      String path = "";
      if (Platform.isAndroid) {
        path = "/storage/emulated/0/Download/";
      } else {
        path = (await getApplicationDocumentsDirectory()).path;
      }
      // String path = await ExtStorage.getExternalStoragePublicDirectory(
      //     ExtStorage.DIRECTORY_DOWNLOADS);

      Utilities.showToast("Downloading...");

      String finalPath = '$path/ReportNo${widget.name}.pdf';
      print(finalPath);
      try {
        FileUtils.mkdir([path]);
        var data = await get(widget.path);
        var bytes = data.bodyBytes;
        File file = File(finalPath);
        await file.writeAsBytes(bytes);
        Utilities.showToast("Downloading Completed");
      } catch (e) {
        print(e);
        Utilities.showToast("Downloading Failed, try again later.");
      }
    }

  }
}