import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:read_y/pages/home/main_page.dart';

import '../../data/colors.dart';
import '../../data/firebase_auth_service.dart';
import '../../data/fonts.dart';
import '../../models/firebase_user_entity.dart';
import '../extra/clippers.dart';

class RegisterWidget extends StatelessWidget {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                                _SubmitButton(
                                  nick: _nicknameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
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

class _CreateAccountNick extends StatelessWidget {
  _CreateAccountNick({
    Key? key,
    required this.nicknameController,
  }) : super(key: key);
  final TextEditingController nicknameController;

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
          controller: nicknameController,
          decoration: greyTransparentDecoration('Ник'),
        ),
      ),
    );
  }
}

class _CreateAccountEmail extends StatelessWidget {
  _CreateAccountEmail({
    Key? key,
    required this.emailController,
  }) : super(key: key);
  final TextEditingController emailController;

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
          decoration: greyTransparentDecoration('Email'),
        ),
      ),
    );
  }
}

class _CreateAccountPassword extends StatelessWidget {
  _CreateAccountPassword({
    Key? key,
    required this.passwordController,
  }) : super(key: key);
  final TextEditingController passwordController;

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
          decoration: greyTransparentDecoration('Пароль'),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  _SubmitButton({
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
            print(user); //TODO REMOVE
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
                backgroundColor: whitey,
                content: Text(
                  'Nick already in use!',
                  style: TextStyle(color: blackish),
                ),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: whitey,
              content: Text(
                e.toString(),
                style: TextStyle(color: blackish),
              ),
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
          'Создать аккаунт',
          style: p1Black,
        ),
      ),
    );
  }
}

InputDecoration greyTransparentDecoration(String text) {
  return InputDecoration(
    hintText: text,
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
  );
}
