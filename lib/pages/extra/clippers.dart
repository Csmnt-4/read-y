import 'package:flutter/material.dart';

class LowerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        size.width, size.height * 0.46, size.width, size.height * 0.28);
    path.cubicTo(size.width * 0.7, size.height * 0.084, size.width * 0.28,
        size.height * 0.084, 0, size.height * 0.28);
    path.quadraticBezierTo(0, size.height * 0.46, 0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class UpperClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.72);
    path.cubicTo(size.width * 0.28, size.height * 0.92, size.width * 0.72,
        size.height * 0.92, size.width, size.height * 0.72);
    path.quadraticBezierTo(size.width, size.height * 0.53, size.width, 0);
    path.lineTo(0, 0);
    path.quadraticBezierTo(0, size.height * 0.7, 0, size.height * 0.72);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SmallerUpperClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, size.height * 0.45, 0, size.height * 0.60);
    path.cubicTo(size.width * 0.25, size.height * 0.92, size.width * 0.75,
        size.height * 0.92, size.width, size.height * 0.60);
    path.quadraticBezierTo(size.width, size.height * 0.45, size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SmallerLowerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(0, size.height * 0.75, 0, size.height * 0.5);
    path.cubicTo(size.width * 0.25, size.height * 0.12, size.width * 0.75,
        size.height * 0.12, size.width, size.height * 0.5);
    path.quadraticBezierTo(
        size.width, size.height * 0.75, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class AppbarShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const he = 115.0;
    const wi = 450.0;
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, he * 0.45, 0, he * 0.60);
    path.cubicTo(wi * 0.25, he * 0.92, wi * 0.75, he * 0.92, wi, he * 0.60);
    path.quadraticBezierTo(wi, he * 0.45, wi, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }
}

class IconShapeBorder extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.5, size.height * -0.1);
    path.quadraticBezierTo(size.width * 0.9739000, size.height * -0.1031000,
        size.width * 0.9915000, size.height * 0.4131000);
    path.cubicTo(
        size.width * 0.9720000,
        size.height * 0.7669000,
        size.width * 0.7541000,
        size.height * 0.9707000,
        size.width * 0.4092000,
        size.height * 0.9956000);
    path.quadraticBezierTo(size.width * -0.1270000, size.height * 0.9851000,
        size.width * -0.1734000, size.height * 0.4131000);
    path.lineTo(size.width * -0.1734000, size.height * -0.1693000);
    path.lineTo(size.width * 0.4090000, size.height * -0.1693000);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
