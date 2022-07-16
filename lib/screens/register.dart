import 'package:flutter/material.dart';
import './profile.dart';
class Register extends StatelessWidget {
  static const id = "Register";
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          SizedBox(height: 40,),
          Text("SRegister", style: TextStyle(fontSize: 30),),
          ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You have been validated'),
                    )
                );
                Navigator.pushNamed(context, Profile.id);
              },
              child: Text("Press Two"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Pop me"),
          ),
        ],
      ),

    );
  }
}