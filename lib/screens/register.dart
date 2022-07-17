import 'package:flutter/material.dart';
import 'package:flutter_navigation/screens/logged_in_screen.dart';
// import './profile.dart';
class Register_Screen extends StatelessWidget {
  static const id = "Register_Screen";
  const Register_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          SizedBox(height: 40,),
          Text("Register_Screen", style: TextStyle(fontSize: 30),),
          ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You have been validated'),
                    )
                );
                Navigator.pushNamed(context, Logged_In_Screen.id);
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