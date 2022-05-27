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
  final width;
  final height;

  const AppbarShapeBorder({required double this.width, required double this.height});
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, height * 0.6, 0, height * 0.69);
    path.cubicTo(width * 0.25, height * 0.92, width * 0.75, height * 0.92, width, height * 0.69);
    path.quadraticBezierTo(width, 0, width, 0);
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
    path.quadraticBezierTo(size.width * 0.97, size.height * -0.1,
        size.width * 0.97, size.height * 0.41);
    path.cubicTo(
        size.width * 0.97,
        size.height * 0.76,
        size.width * 0.76,
        size.height * 0.97,
        size.width * 0.41,
        size.height * 0.97);
    path.quadraticBezierTo(size.width * -0.12, size.height * 0.97,
        size.width * -0.17, size.height * 0.41);
    path.lineTo(size.width * -0.17, size.height * -0.17);
    path.lineTo(size.width * 0.41, size.height * -0.17);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawerShapeBorder extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0,0);
    path.quadraticBezierTo(size.width*0.34,0,size.width*0.46,0);
    path.cubicTo(size.width*1.18,size.height*0.2,size.width*1.14,size.height*0.78,size.width*0.46,size.height);
    path.quadraticBezierTo(size.width*0.34,size.height,0,size.height);
    path.lineTo(0,0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
