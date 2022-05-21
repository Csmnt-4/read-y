import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/extra/clippers.dart';
import 'package:read_y/pages/extra/decorations.dart';
import 'package:read_y/pages/register/register.dart';

import '../../data/colors.dart';
import '../../data/firebase_auth_service.dart';
import '../extra/rounded_containers.dart';
import '../home/main_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: [
            Center(
              heightFactor: 0.9321,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: cWh,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipPath(
                      clipper: SmallerUpperClipper(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: cBl,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Text(
                            'Вход',
                            style: h0White,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text(
                              'C возвращением!',
                              style: h1Black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child:
                                _LoginEmail(emailController: emailController),
                          ),
                          _LoginPassword(
                              passwordController: passwordController),
                        ],
                      ),
                    ),
                    ClipPath(
                      clipper: SmallerLowerClipper(),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: cBl,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const _CreateAccountButton(),
                              const SizedBox(
                                width: 10,
                              ),
                              _SubmitButton(
                                email: emailController,
                                password: passwordController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class _LoginEmail extends StatelessWidget {
  const _LoginEmail({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final emailController;

  @override
  Widget build(BuildContext context) {
    return roundedContainer(
      TextField(
        style: h4White,
        controller: emailController,
        cursorColor: cWh,
        decoration: greyTransparentDecoration('e-mail'),
      ),
      MediaQuery.of(context).size.width / 1.5,
      0,
      cBl,
      cBl,
    );
  }
}

class _LoginPassword extends StatelessWidget {
  const _LoginPassword({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final passwordController;

  @override
  Widget build(BuildContext context) {
    return roundedContainer(
      TextField(
        style: h4White,
        controller: passwordController,
        cursorColor: cWh,
        obscureText: true,
        decoration: greyTransparentDecoration('пароль'),
      ),
      MediaQuery.of(context).size.width / 1.5,
      0,
      cBl,
      cBl,
    );
  }
}

class _SubmitButton extends StatelessWidget {
  _SubmitButton({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  final email, password;
  final _authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          var u = await _authService.signInWithEmailAndPassword(
            email: kDebugMode ? 'test@test.com' : email.text,
            password: kDebugMode ? 'testtest' : password.text,
          );
          var nickname = await FirebaseFirestore.instance
              .collection("users")
              .where("id", isEqualTo: u.id)
              .get()
              .then(
                (qSnap) => qSnap.docs[0]['nick'],
                onError: (e) => print("Something went wrong $e"),
              );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MainPage(
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
              backgroundColor: cWh,
              content: Text(
                // errorToPrettyString(e.toString());
                e.toString(),
              ),
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

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
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
