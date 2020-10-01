import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PrescriptionWebView extends StatefulWidget {
  final String url;
  final String title;

  PrescriptionWebView(this.url, this.title);

  @override
  _PrescriptionWebViewState createState() => _PrescriptionWebViewState(this.url);
}

class _PrescriptionWebViewState extends State<PrescriptionWebView> {
  double progress = 0;
  String url;
  InAppWebViewController webView;


  _PrescriptionWebViewState(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(child: Column(children: [
        progress < 1.0
            ? LinearProgressIndicator(value: progress)
            : SizedBox.shrink(),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: InAppWebView(
              initialUrl: this.url,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: false,
                    supportZoom: true,
                    cacheEnabled: true
                  )
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                setState(() {
                  this.url = url;
                });
              },
              onLoadStop: (InAppWebViewController controller, String url) async {
                setState(() {
                  this.url = url;
                });
              },
              onProgressChanged: (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ),
      ],
      ),),
    );
  }
}
