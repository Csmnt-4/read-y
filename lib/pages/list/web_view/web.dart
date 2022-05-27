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
      appBar: AppBar(
        title: const Text('Test app'),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 200,
                child: const WebView(
                  initialUrl: 'https://flutter.dev',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
