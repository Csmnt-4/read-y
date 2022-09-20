import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  const WebPage({Key? key, this.url}) : super(key: key);
  final url;

  @override
  State<WebPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: WebView(
                  initialUrl: widget.url
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
