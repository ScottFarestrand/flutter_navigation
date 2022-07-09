import 'package:flutter/material.dart';
class UserProfile extends StatelessWidget {
  static const id = "UserProfile";
  const UserProfile({Key? key}) : super(key: key);

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
          ElevatedButton(onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Hi! i am snackbar'),
                )
            );
          },
              child: Text("Show Snackbar")
          ),
        ],
      ),

    );
  }
}