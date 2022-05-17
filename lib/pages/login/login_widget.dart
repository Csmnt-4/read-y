import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:read_y/models/firebase_user_entity.dart';
import 'package:read_y/pages/register/register_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/firebase_auth_service.dart';
import '../main_page.dart';

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
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LoginEmail(emailController: emailController),
              const SizedBox(height: 30.0),
              _LoginPassword(passwordController: passwordController),
              const SizedBox(height: 30.0),
              _SubmitButton(
                email: emailController,
                password: passwordController,
              ),
              const SizedBox(height: 30.0),
              _CreateAccountButton(),
            ],
          ),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        controller: emailController,
        decoration: const InputDecoration(hintText: 'Email'),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Пароль',
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
    return ElevatedButton(
      onPressed: () async {
          try {
            var u = await _authService.signInWithEmailAndPassword(
              email: email.text,
              password: password.text,
            );
            print(u); //TODO REMOVE
            print(u.id);
            var nickname = await FirebaseFirestore.instance.collection("users").where("id", isEqualTo: u.id).get().then(
                    (qsnap) => qsnap.docs[0]['nick'],
                onError: (e) => print("Something went wrong"+e));
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MainPage(context, userId: u.id, initialPage: "initialPage", nickname: nickname,),

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
      child: const Text('Login'),
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
      child: const Text('Create Account'),
    );
  }
}
