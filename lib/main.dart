import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:read_y/pages/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ReadyApp(),
  );
}

class ReadyApp extends StatelessWidget {
  const ReadyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read-y App',
      home: SplashScreenWidget(context),
      // debugShowCheckedModeBanner: false,
    );
  }
}
