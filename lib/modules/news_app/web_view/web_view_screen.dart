import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  final String webViewPageTitle;

  WebViewScreen(this.url, this.webViewPageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          webViewPageTitle,
        ),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
