import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_y/pages/main_page.dart';

import '../../data/firebase_auth_service.dart';
import 'package:flutter/material.dart';

import '../../models/firebase_user_entity.dart';

class RegisterWidget extends StatelessWidget {final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Create Account'),
      centerTitle: true,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CreateAccountEmail(emailController: _emailController),
          const SizedBox(height: 30.0),
          _CreateAccountPassword(passwordController: _passwordController),
          const SizedBox(height: 30.0),
          _SubmitButton(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        ],
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
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        controller: emailController,
        decoration: const InputDecoration(hintText: 'Email'),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Password',
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
  final String email, password;
  final _authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );
  FirebaseUserEntity user = FirebaseUserEntity.empty();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          user = await _authService.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          print(user); //TODO REMOVE
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MainPage(context, userId: user.id, nickname: '???', initialPage: "initialPage"),
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
      child: const Text('Create Account'),
    );
  }
}