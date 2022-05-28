import 'package:flutter/material.dart';
import './screen2.dart';
class Screen_1 extends StatelessWidget {
  static const id = "Screen_One";
  const Screen_1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Screen One", style: TextStyle(fontSize: 30),),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Screen_2.id);
              },
              child: Text("Press Me"))
        ],
      ),

    );
  }
}
