import 'package:flutter/material.dart';
// import './register.dart';
// import '../widgets/navigation_drawer.dart';
import '../widgets/Login.dart';
import '../widgets/ValidateEmail.dart';
import '../widgets/register.dart';
enum appState {
  init,
  register,
  loggedin,
  validated
}

class Login extends StatefulWidget {
  static const id = "Login";

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Login page"),);

  }


}
