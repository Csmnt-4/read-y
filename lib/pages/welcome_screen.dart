import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:read_y/data/colors.dart';
import 'package:read_y/data/firebase_auth_service.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/register/register.dart';

import 'extra/clippers.dart';
import 'extra/rounded_containers.dart';
import 'home/main_page.dart';
import 'login/login.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget(BuildContext context, {Key? key}) : super(key: key);

  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        key: scaffoldKey,
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
            color: cWh,
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
                    padding: const EdgeInsets.only(
                        bottom: 35.0, left: 50, right: 50),
                    height: 300,
                    decoration: BoxDecoration(
                      color: cBl,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Добро пожаловать в Read-y!',
                            style: h1White,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: cWh,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: LowerClipper(),
                  child: Container(
                    height: 270,
                    decoration: BoxDecoration(
                      color: cBl,
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
                            children: const [
                              RegisterButton(),
                              LoginButton(),
                            ],
                          ),
                        ),
                        const TellMeButton(),
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
  const RegisterButton({Key? key}) : super(key: key);

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
      child: roundedContainer(
        Text(
          'регистрация',
          style: h3Black,
        ),
        null,
        4,
        cWh,
        cWh,
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (kDebugMode) {
          try {
            var u = await FirebaseAuthService(
              authService: FirebaseAuth.instance,
            ).signInWithEmailAndPassword(
              email: 'test@test.com',
              password: 'testtest',
            );
            var nickname = await FirebaseFirestore.instance
                .collection("users")
                .where("id", isEqualTo: u.id)
                .get()
                .then(
                  (qSnap) => qSnap.docs[0]['nick'],
              onError: (e) => log("Something went wrong $e"),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    MainPage(
                      context,
                      userId: u.id,
                      initialPage: "",
                      nickname: nickname,
                    ),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  e.toString(),
                ),
              ),
            );
          }
        } else {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginWidget(),
            ),
          );
        }
      },
      child: roundedContainer(
        Text(
          'войти',
          style: h3Black,
        ),
        null,
        4,
        cWh,
        cWh,
      ),
    );
  }
}

class TellMeButton extends StatelessWidget {
  const TellMeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // TODO: Tell about app (IntroductionScreen?)
      },
      child: roundedContainer(
        Text(
          'расскажите мне о read-y',
          style: h3White,
        ),
        null,
        4,
        cPu,
        cPu,
      ),
    );
  }
}
