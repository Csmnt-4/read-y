import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_y/pages/register/register_widget.dart';

import '../data/colors.dart';
import 'login/login_widget.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget(BuildContext context, {Key? key}) : super(key: key);

  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: UpperClipper(),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: blackish,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 35.0, left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 180,
                          child: Text(
                            'Добро пожаловать в Read-y!',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: whitey,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          height: 57,
                          width: 57,
                          decoration: BoxDecoration(
                            color: whitey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ClipPath(
                clipper: LowerClipper(),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: blackish,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: TextButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterWidget(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 13, vertical: 4),
                            decoration: BoxDecoration(
                              color: whitey,
                              border: Border.all(
                                  color: Color(0xffFFFAFF), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: Text(
                              'Регистрация',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: blackish,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginWidget(),
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 13, vertical: 4),
                          decoration: BoxDecoration(
                            color: whitey,
                            border: Border.all(
                                color: Color(0xffFFFAFF), width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                          ),
                          child: Text(
                            'Войти',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                              color: blackish,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
