import 'package:flutter/material.dart';

Widget loadingScreen(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Scaffold(
    backgroundColor: const Color(0xFFFFFAFF),
    body: Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: height / 3),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  (Color(0xFF8789C0)),
                ),
              ),
              width: 44,
              height: 44,
            ),
          ]),
    ),
  );
}
