import 'package:flutter/material.dart';
// import './screen2.dart';
// import '../widgets/navigation_drawer.dart';
import '../widgets/Login.dart';
import '../widgets/ValidateEmail.dart';
enum appState {
  none,
  loggedin,
  validated
}
class Screen_1 extends StatefulWidget {
  static const id = "Screen_One";

  const Screen_1({Key? key}) : super(key: key);

  @override
  State<Screen_1> createState() => _Screen_1State();
}

class _Screen_1State extends State<Screen_1> {
  var userState = appState.none;
  @override
  Widget build(BuildContext context) {
    return userState == appState.none? login(): validateEmail();
    // return Scaffold(
    //   backgroundColor: Theme.of(context).backgroundColor,
    //   drawer: NavDrawer(),
    //   appBar: AppBar(
    //     title: Text("menu"),
    //   ),
    //   body: Column(
    //     children: [
    //       if (userState == appState.none) Text("Login"),
    //       if (userState == appState.loggedin) Text("Validate"),
    //
    //       Text("Screen One", style: TextStyle(fontSize: 30),),
    //       ElevatedButton(
    //           onPressed: () {
    //             Navigator.pushNamed(context, Screen_2.id);
    //           },
    //           child: Text("Press Me"))
    //     ],
    //   ),
    //
    // );
  }
}
