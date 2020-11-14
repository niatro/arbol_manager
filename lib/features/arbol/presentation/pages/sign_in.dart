import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<void> signIn({
  @required String email,
  @required String password,
}) async {
  // Sign in the user
  signIn(email: 'pazzwd', password: 'email@example');
}
