import 'package:flutter/material.dart';
import 'package:flutter_navigation/widgets/people_widget.dart';
import '../widgets/profile_widget.dart';
// import '../widgets/profile_widget.dart';
import '../widgets/reminders_widget.dart';
// import '../screens/people.dart';
// import '../screens/profile.dart';
// import '../screens/reminders.dart';
// import '../screens/person.dart';

class Logged_In_Screen extends StatefulWidget {
  const Logged_In_Screen({Key? key}) : super(key: key);
  static const id = "LoggedIn";
  @override
  State<Logged_In_Screen> createState() => _Logged_In_ScreenState();
}

class _Logged_In_ScreenState extends State<Logged_In_Screen> {
  int _currentIndex = 1;
  bool _actionVisible = false;
  @override
  Widget build(BuildContext context) {
    print("Building");

    print("Building");
    print(_currentIndex);
    final widgets = [
      Profile_Widget(),
      People_Widget(),
      Reminders_Widget(),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: _actionVisible,
            child: IconButton(
              icon: Icon(Icons.add),
              tooltip: "Add new person",
              onPressed: (){

              },
            ),
          ),
        ],

        title: Text("Random Reminder"),

      ),
      body: widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 1 ) {
              _actionVisible = true;
            } else {
              _actionVisible = false;
            }
          }),

          print(_currentIndex),
        },
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 16,
        unselectedFontSize: 12,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items:[
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.person),
              label: "Profile"),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.people),
              label: "People"),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.schedule),
              label: "Reminders"),
        ],
      ),
    );
  }
}