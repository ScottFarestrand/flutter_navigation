import 'package:flutter/material.dart';
import './screen3.dart';
class Screen_2 extends StatelessWidget {
  static const id = "Screen_Two";
  const Screen_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Screen Two", style: TextStyle(fontSize: 30),),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Screen_3.id);
              },
              child: Text("Press Two"))
        ],
      ),

    );
  }
}