
import 'package:flutter/material.dart';
import 'package:flutter_navigation/screens/login.dart';
class Login extends StatelessWidget {
  final Function loginCallBack;
  final Function registerCallBack;
  const Login({Key? key, required this.loginCallBack(), required this.registerCallBack()}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Log in/Register"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                print("Login Pressed");
                loginCallBack();
              },
              child: Text("Login"),),
          ElevatedButton(
            onPressed: () {
              print("Register Pressed Pressed");
              registerCallBack();
            },
            child: Text("Register"),),
        ],
      ),

    );
  }
}
