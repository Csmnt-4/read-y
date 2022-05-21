import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:read_y/pages/home/main_page.dart';

import '../../data/colors.dart';
import '../../data/firebase_auth_service.dart';
import '../../data/fonts.dart';
import '../../models/firebase_user_entity.dart';
import '../extra/clippers.dart';
import '../extra/decorations.dart';
import '../extra/rounded_containers.dart';

class RegisterWidget extends StatelessWidget {
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: [
            Center(
              heightFactor: 0.93,
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
                            'Регистрация',
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
                          _CreateAccountNick(
                              nicknameController: _nicknameController),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: _CreateAccountEmail(
                                emailController: _emailController),
                          ),
                          _CreateAccountPassword(
                              passwordController: _passwordController),
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
                              _SubmitButton(
                                nick: _nicknameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
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

class _CreateAccountNick extends StatelessWidget {
  const _CreateAccountNick({
    Key? key,
    required this.nicknameController,
  }) : super(key: key);
  final TextEditingController nicknameController;

  @override
  Widget build(BuildContext context) {
    return roundedContainer(
      TextField(
        style: h3White,
        cursorColor: cWh,
        controller: nicknameController,
        decoration: greyTransparentDecoration('ник'),
      ),
      MediaQuery.of(context).size.width / 1.5,
      0,
      cBl,
      cBl,
    );
  }
}

class _CreateAccountEmail extends StatelessWidget {
  const _CreateAccountEmail({
    Key? key,
    required this.emailController,
  }) : super(key: key);
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return roundedContainer(
      TextField(
        style: h3White,
        cursorColor: cWh,
        controller: emailController,
        decoration: greyTransparentDecoration('e-mail'),
      ),
      MediaQuery.of(context).size.width / 1.5,
      0,
      cBl,
      cBl,
    );
  }
}

class _CreateAccountPassword extends StatelessWidget {
  const _CreateAccountPassword({
    Key? key,
    required this.passwordController,
  }) : super(key: key);
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return roundedContainer(
      TextField(
        style: h3White,
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

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({
    Key? key,
    required this.nick,
    required this.email,
    required this.password,
  }) : super(key: key);
  final String nick, email, password;

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  final _authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );

  FirebaseUserEntity user = FirebaseUserEntity.empty();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          var newUser = await _authService.createUserWithEmailAndPassword(
            nick: widget.nick,
            email: widget.email,
            password: widget.password,
          );
          if (newUser != null) {
            if (kDebugMode) {
              print(user);
            } //TODO REMOVE
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MainPage(context,
                    userId: user.id,
                    nickname: widget.nick,
                    initialPage: "initialPage"),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: cWh,
                content: Text(
                  'Nick already in use!',
                  style: TextStyle(color: cBl),
                ),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: cWh,
              content: Text(
                e.toString(),
                style: TextStyle(color: cBl),
              ),
            ),
          );
        }
      },
      child: roundedContainer(
        Text(
          'создать аккаунт',
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
