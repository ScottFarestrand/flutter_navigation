import 'package:flutter/material.dart';
import '/screens/login.dart';
import '/screens/register.dart';
import '/screens/userprofile.dart';
// import '/widgets/navigation_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.lightBlue,
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: Login.id,
      routes: {
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        UserProfile.id: (context) => UserProfile(),
      },
    );
  }

}

