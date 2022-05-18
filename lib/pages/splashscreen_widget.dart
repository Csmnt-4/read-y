import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/register/register_widget.dart';

import '../data/colors.dart';
import 'extra/clippers.dart';
import 'login/login_widget.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget(BuildContext context, {Key? key}) : super(key: key);

  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: whitey,
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
                            width: 200,
                            child: Text(
                              'Добро пожаловать в Read-y!',
                              style: h3White,
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
                    height: 270,
                    decoration: BoxDecoration(
                      color: blackish,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: RegisterButton(),
                              ),
                              LoginButton(),
                            ],
                          ),
                        ),
                        TellMeButton(),
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

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterWidget(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 4),
        decoration: BoxDecoration(
          color: whitey,
          border: Border.all(color: whitey, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        child: Text('регистрация', style: p1Black),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginWidget(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 4),
        decoration: BoxDecoration(
          color: whitey,
          border: Border.all(color: whitey, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        child: Text('войти', style: p1Black),
      ),
    );
  }
}

class TellMeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // TODO: Tell about app (IntroductionScreen?)
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 4),
        decoration: BoxDecoration(
          color: purplish,
          border: Border.all(color: purplish, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        child: Text('расскажите мне о Read-y', style: p1White),
      ),
    );
  }
}
