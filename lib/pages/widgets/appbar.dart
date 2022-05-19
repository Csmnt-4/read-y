import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';

import '../../data/colors.dart';
import '../extra/clippers.dart';

AppBar appBar(nickname, scaffoldKey, size) {
// TODO?: Implement more maquette-like appbar
  return AppBar(
    title: Center(
      widthFactor: 3.74,
      child: Text(
        nickname.toString().toLowerCase(),
        style: h0White,
      ),
    ),
    leading: ClipPath(
      clipper: IconShapeBorder(),
      child: Container(
        height: 100,
        width: 100,
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
    backgroundColor: cBl,
    shadowColor: Colors.transparent,
    shape: AppbarShapeBorder(),
  );
}
