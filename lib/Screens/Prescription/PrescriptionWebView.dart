import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PrescriptionWebView extends StatefulWidget {
  final String url;
  final String title;

  const PrescriptionWebView(this.url, this.title, {Key key}) : super(key: key);

  @override
  _PrescriptionWebViewState createState() => _PrescriptionWebViewState(url);
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
      body: Column(
        children: [
          progress < 1.0
              ? LinearProgressIndicator(value: progress)
              : const SizedBox.shrink(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(url)),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                        supportZoom: true, cacheEnabled: true)),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, Uri url) {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onLoadStop: (InAppWebViewController controller, Uri url) async {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
