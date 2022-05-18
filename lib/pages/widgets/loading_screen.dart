import 'package:flutter/material.dart';

import '../../data/colors.dart';

Widget loadingScreen(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Scaffold(
    backgroundColor: whitey,
    body: Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: height / 3),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  blackish,
                ),
              ),
              width: 44,
              height: 44,
            ),
          ]),
    ),
  );
}
