import 'package:flutter/material.dart';

Container roundedContainer(
    child, double? width, double vertPad, Color? color, Color bColor) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 9, vertical: vertPad),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: bColor, width: 1.0),
      borderRadius: const BorderRadius.all(
        Radius.circular(40.0),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: child,
    ),
  );
}

Container rotatedRoundedContainer(
    child, double? width, double vertPad, Color? color, Color bColor) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: vertPad),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: bColor, width: 2.0),
      borderRadius: const BorderRadius.all(
        Radius.circular(40.0),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: RotatedBox(
        quarterTurns: -1,
        child: child,
      ),
    ),
  );
}
