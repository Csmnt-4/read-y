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

class smallerUpperClipper extends CustomClipper<Path> {
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

class smallerLowerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.0005000, size.height * 0.6100000, 0,
        size.height * 0.4800000);
    path.cubicTo(
        size.width * 0.2505000,
        size.height * 0.1215600,
        size.width * 0.7500000,
        size.height * 0.1160000,
        size.width,
        size.height * 0.4780800);
    path.quadraticBezierTo(
        size.width, size.height * 0.6085600, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
