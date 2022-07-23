import 'package:flutter/material.dart';
// import '../screens/register.dart';
class validateEmail extends StatefulWidget {
  final Function callback;
  const validateEmail({Key? key, required this.callback()}) : super(key: key);

  @override
  State<validateEmail> createState() => _validateEmailState();
}

class _validateEmailState extends State<validateEmail> {
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


          Text("Validate", style: TextStyle(fontSize: 30),),
          ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, Register.id);
              },
              child: Text("Verify Email"))
        ],
      ),

    );
  }
}
