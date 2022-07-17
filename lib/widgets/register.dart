import 'package:flutter/material.dart';
// import 'package:flutter_navigation/screens/login_screen.dart';
class Registerx extends StatelessWidget {
  final Function callback;
  const Registerx({Key? key, required this.callback()}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Register "),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                print("Register Pressed");
                callback();
              },
              child: Text("Register"))
        ],
      ),

    );
  }
}