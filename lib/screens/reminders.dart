import 'package:flutter/material.dart';
class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);
  static const id = "Reminders";


  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Reminder Page"),);
  }
}

