import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebSurf extends StatefulWidget {
  WebSurf({required this.url});
  String url;

  @override
  State<WebSurf> createState() => _WebSurfState();
}

class _WebSurfState extends State<WebSurf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 35),
        child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted),
      ),
    );
  }
}
