import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';
import './register.dart';
// import './profile.dart';
import './logged_in_screen.dart';
// import './register.dart';
// import '../widgets/navigation_drawer.dart';
// import '../widgets/Login.dart';
// import '../widgets/ValidateEmail.dart';
// import '../widgets/register.dart';


class Login_Screen extends StatefulWidget {
  static const id = "Login_Screen";


  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  @override
  Widget build(BuildContext context) {
    print("Building Login");
    // FirebaseAuth auth = FirebaseAuth.instance;
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    // final user =  FirebaseAuth.instance.currentUser!;
    emailController.text = "ScottFarestrand@gmail.com";
    passwordController.text = "Jlj#980507";
    return Scaffold(
        appBar: AppBar(
          title: Text("Random Reminder - Login"),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value.toString())) {
                        return null;
                      }
                      return 'Please enter a valid email address';
                    }
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () async {
                    print("Pressed");
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }

                    Navigator.pushNamed(context, Logged_In_Screen.id);
                  },
                  child: const Text('Login'),
                ),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, Register_Screen.id);

                }, child: Text("Register")),
              ],
            ),
          ),

        ));

  }
  // static Future<User?> signInUsingEmailPassword({
  //   required String email,
  //   required String password,
  //   required BuildContext context,
  // }) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided.');
  //     }
  //   }
  //
  //   return user;
  // }


}
