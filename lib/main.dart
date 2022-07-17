import 'package:flutter/material.dart';
import '/screens/login_screen.dart';
import '/screens/register.dart';
// import '/screens/profile.dart';
// import './screens/reminders.dart';
// import './screens/people.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/logged_in_screen.dart';
// import '/widgets/navigation_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseAuth auth = FirebaseAuth.instance;
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
      initialRoute: Login_Screen.id,
      routes: {
        Login_Screen.id: (context) => Login_Screen(),
        Logged_In_Screen.id: (context) => Logged_In_Screen(),
        Register_Screen.id: (context) => Register_Screen(),
      },
    );
  }

}

