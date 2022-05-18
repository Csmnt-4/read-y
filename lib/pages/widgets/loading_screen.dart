import 'package:flutter/material.dart';

import '../../data/colors.dart';

Widget loadingScreen(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  return Scaffold(
    backgroundColor: cWh,
    body: Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: height / 3),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  cBl,
                ),
              ),
            ),
          ]),
    ),
  );
}
