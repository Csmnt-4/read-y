import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/extra/clippers.dart';
import 'package:read_y/pages/register/register_widget.dart';

import '../../data/colors.dart';
import '../../data/firebase_auth_service.dart';
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
              heightFactor: 0.93,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: whitey,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipPath(
                      clipper: smallerUpperClipper(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: blackish,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Text(
                            'Вход',
                            style: h2White,
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
                              style: h3Black,
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
                    Container(
                      child: ClipPath(
                        clipper: smallerLowerClipper(),
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                            color: blackish,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _CreateAccountButton(),
                                SizedBox(
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
  _LoginEmail({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 0),
      decoration: BoxDecoration(
        color: blackish,
        border: Border.all(color: whitey, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          style: p1White,
          cursorColor: whitey,
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: p1Grey,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginPassword extends StatelessWidget {
  _LoginPassword({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 0),
      decoration: BoxDecoration(
        color: blackish,
        border: Border.all(color: whitey, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          style: p1White,
          controller: passwordController,
          cursorColor: whitey,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Пароль',
            hintStyle: p1Grey,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
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
            email: email.text,
            password: password.text,
          );
          var nickname = await FirebaseFirestore.instance
              .collection("users")
              .where("id", isEqualTo: u.id)
              .get()
              .then((qSnap) => qSnap.docs[0]['nick'],
                  onError: (e) => print("Something went wrong" + e));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MainPage(
                context,
                userId: u.id,
                initialPage: "initialPage",
                nickname: nickname,
              ),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 4),
        decoration: BoxDecoration(
          color: whitey,
          border: Border.all(color: whitey, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        child: Text(
          'войти',
          style: p1Black,
        ),
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
