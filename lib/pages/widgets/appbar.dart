import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';

import '../../data/colors.dart';
import '../extra/clippers.dart';

AppBar appBar(nickname, scaffoldKey, size) {
  return AppBar(
    // bottomOpacity: 0,
    surfaceTintColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    backgroundColor: cBl,
    shadowColor: Colors.transparent,

    title: Text(
      nickname.toString().toLowerCase(),
      style: h0White,
      textAlign: TextAlign.center,
    ),
    leading: ClipPath(
      clipper: IconShapeBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: cPu,
          shape: BoxShape.rectangle,
        ),
        child: IconButton(
          padding: const EdgeInsets.only(right: 5.0, bottom: 5.0),
          icon: const Icon(Icons.dehaze_rounded, size: 31,),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
          color: cWh,
        ),
      ),
    ),
    shape: AppbarShapeBorder(width: size, height: 120),
  );
}
