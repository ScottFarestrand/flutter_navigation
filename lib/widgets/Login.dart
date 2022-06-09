import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_navigation/screens/screen1.dart';
class Login extends StatelessWidget {
  final Function callback;
  const Login({Key? key, required this.callback()}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("menu"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                callback(appState.loggedin);
              },
              child: Text("Login"))
        ],
      ),

    );
  }
}
