import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';

import 'pages/main.dart';



Future<void> main() async {
  debugRepaintRainbowEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ReadyApp());
}

class ReadyApp extends StatelessWidget {
  const ReadyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Read-y App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MainPage(context, title: 'Read-y App',),
      debugShowCheckedModeBanner: false,
    );
  }
}
