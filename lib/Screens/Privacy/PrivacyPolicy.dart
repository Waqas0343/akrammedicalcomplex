
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  WebViewController _controller;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://www.akrammedicalcomplex.com/about-us/',
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              // _loadHtmlFromAssets();
            },
            onPageFinished: (text){
              setState(() {
                isLoading = false;
              });
            },
            onPageStarted: (text){
              setState(() {
                isLoading = true;
              });
            },
          ),
          isLoading ? Center(child: CircularProgressIndicator()):SizedBox.shrink()
        ],
      ),
    );
  }
}
