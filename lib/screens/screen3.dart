import 'package:flutter/material.dart';
class Screen_3 extends StatelessWidget {
  static const id = "Screen_Three";
  const Screen_3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Screen Three", style: TextStyle(fontSize: 30),),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Press Three"),
          ),
        ],
      ),

    );
  }
}