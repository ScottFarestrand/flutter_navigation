import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../models/userprofile.dart';

class Profile_Widget extends StatefulWidget {
  const Profile_Widget({Key? key}) : super(key: key);

  @override
  State<Profile_Widget> createState() => _Profile_WidgetState();
}

class _Profile_WidgetState extends State<Profile_Widget> {
  @override
  String tempDate = "";
  int _seconds = 0;
  int _nanoseconds = 0;
  final dateFormat = new DateFormat('MMM d, y');
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cellPhoneNumberController = TextEditingController();
  final dateController = TextEditingController();
  final birthDateController = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(mask: '###.###.####', filter: { "#": RegExp(r'[0-9]') });
  DateTime birthDate = DateTime.now();
  String firstName = "";
  String lastName = "";
  String cellPhoneNumber = "";
  bool textReminders = false;
  bool emailReminders = false;
  bool cellPhoneValidated = false;
  String origCellPhone = "";
  bool _cellValidated = false;
  final UserProfile userProfile = UserProfile(
    firstName: "",
    lastName: "",
    birthDate: DateTime.now(),
    cellPhone: "",
    cellPhoneValidated: false,
    sendEmailReminders: false,
    sendTextReminders: false,
  );
  Widget build(BuildContext context) {
    print("getting User");

    try {
      FirebaseFirestore.instance.collection('Users').
      doc(FirebaseAuth.instance.currentUser!.uid).
      get().then((snapshot) =>
      {
        tempDate = snapshot.data().toString().contains('birthdate') ?
            snapshot['birthdate'].toString() : DateTime.now().toString(),

        _seconds = int.parse(tempDate.substring(18, 28)),
        _nanoseconds =
            int.parse(tempDate.substring(42, tempDate.lastIndexOf(')'))),
        birthDate = Timestamp(_seconds, _nanoseconds).toDate(),

        firstNameController.text = snapshot.data().toString().contains('firstname') ?
          snapshot['firstname'] : "",

        lastNameController.text = snapshot.data().toString().contains('lastname') ?
        snapshot['lastname'] : "",

          emailReminders = snapshot.data().toString().contains("sendemailreminders") ?
          snapshot["sendemailreminders"] : false,


        textReminders = snapshot.data().toString().contains('sendtextreminders') ?
          snapshot["sendtextreminders"] : false,

        cellPhoneNumberController.text = snapshot.data().toString().contains('cellphone') ?
          snapshot["cellphone"] : '',

        cellPhoneValidated = snapshot.data().toString().contains('cellphonevalidated') ?
          snapshot["cellphonevalidated"] : false,

        userProfile.updateUserProfile(
          snapshot['firstname'],
          snapshot['lastname'],
          snapshot["cellphone"],
          birthDate,
          snapshot["sendtextreminders"],
          snapshot["sendemailreminders"],
          snapshot["cellphonevalidated"],

        ),
        firstNameController.text = userProfile.firstName,
        lastNameController.text = userProfile.lastName,
        emailReminders = userProfile.sendEmailReminders,
        textReminders = userProfile.sendTextReminders,
        cellPhoneNumberController.text = userProfile.cellPhone,
        origCellPhone = snapshot["cellphone"],
        cellPhoneValidated = snapshot["cellphonevalidated"],
        birthDateController.text = dateFormat.format(userProfile.birthDate),
        print(birthDateController.text),
        print("done done"),

      });
    } on FirebaseException catch(error){
      print(error.code);
      print(error.message);
    }
    return Form(
      // key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),

            TextFormField(
                controller: firstNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "First Name",
                  labelStyle: TextStyle(fontStyle: FontStyle.italic),
                ),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter First Name";
                  }
                  return null;
                }
            ),
            TextFormField(
                controller: lastNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Last Name",
                  labelStyle: TextStyle(fontStyle: FontStyle.italic),
                ),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Last Name";
                  }
                  return null;
                }
            ),
            TextFormField(
              onTap: () {_selectDate(context, dateController);},
              decoration: InputDecoration(
                labelText: "Birth Date",
                labelStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
              style: TextStyle(fontSize: 20),
              controller: birthDateController,
              keyboardType: TextInputType.none,
            ),
            TextFormField(
              // inputFormatters: [MaskedInputFormater('(###) ###-####')],
              inputFormatters: [maskFormatter],
              controller: cellPhoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Cell Phone Number",
                labelStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Row(children: [
              Text('Send Text Reminders', style: TextStyle(fontSize: 20),),
              SizedBox(width: 10,),
              FlutterSwitch(
                  activeToggleColor: Colors.white,
                  inactiveColor: Colors.blueGrey,
                  height: 25,
                  width: 50,
                  value: textReminders,
                  onToggle: (bool? value) { // This is where we update the state when the checkbox is tapped
                    print(textReminders);
                    print(emailReminders);
                    print("setting");
                    setState(() {
                      textReminders = !textReminders;
                    });
                    print("set");
                    print(textReminders);
                    print(emailReminders);

                  })
            ],),
            Row(children: [SizedBox(height: 10,)],),
            Row(children: [

              Text('Send Email Reminders', style: TextStyle(fontSize: 20), ),
              SizedBox(width: 10,),
              // ToggleButtons(children: [Text("Yes"),Text("no")], isSelected: (){}),
              FlutterSwitch(
                  activeToggleColor: Colors.white,
                  inactiveColor: Colors.blueGrey,
                  height: 25,
                  width: 50,
                  value: emailReminders,
                  onToggle: (bool? value) { // This is where we update the state when the checkbox is tapped

                    setState(() {
                      emailReminders = !emailReminders;
                    });
                  })
            ],),
            ElevatedButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            }, child: Text("Log out")),
            ElevatedButton(onPressed: (){
              print("hmmmm");
              final userprofile = UserProfile(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  cellPhone: cellPhoneNumberController.text,
                  birthDate: birthDate,
                  sendTextReminders: textReminders,
                  sendEmailReminders: emailReminders,
                  cellPhoneValidated: _cellValidated);

              updateUser(userprofile);
              // addRecord(firstNameController.text, lastNameController.text, birthDate);
            }, child: Text("Save")),
            Visibility(
              visible: (  false ),
              child: ElevatedButton(
                onPressed: (){},
                child: Text("Validate Cell Number"),),
            ),
          ],
        ),
      ),
    );
  }


  Future updateUser(UserProfile userprofile) async {
    final myID = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('Users').doc(
        myID);
    final json =userprofile.toJson();
    await docUser.set(json);
  }
  addRecord (String firstName, String lastName, DateTime birthDate  )  {
    final myID = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('Users').doc(
        myID);

    print("Saving");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Saving User")),
    );
    if (cellPhoneNumberController.text != origCellPhone) {
      cellPhoneValidated  = false;
    }
    print(textReminders);
    if (cellPhoneNumberController.text != origCellPhone) {
      cellPhoneValidated = false;
    }
    // FirebaseAuth.instance.signOut();
    final json = {
      'FirstName': firstNameController.text,
      'LastName': lastNameController.text,
      'BirthDate': birthDate,
      'SendTextReminders': textReminders,
      'SendEmailReminders': emailReminders,
      'CellPhone': cellPhoneNumberController.text,
      'CellPhoneValidated': cellPhoneValidated,
    };
    try {
      print("Trying");
      docUser.set(json)
          .then((stuff) {
        print("saved");
      })
          .catchError((e) {
        print("Error Caught");
        print(e.code);
        print(e.message);

        // print(Err.toString());
        if (e.code == "permission-denied") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You Do not have necessary permission",
                style: TextStyle(backgroundColor: Colors.red),),
            ),
          );}
      });
    } on FirebaseException catch (err){
      print(err.toString());
    } on IOException catch(err) {
      print(err.toString());
    }

    setState((){
      // _saved = true;
    });


  }
  Future<void> _selectDate(BuildContext context, TextEditingController selectedDate) async {
    final dateFormat = new DateFormat('MMM d, y');
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(DateTime.now().year - 125),
      lastDate: DateTime(DateTime.now().year + 1),);
    if (pickedDate != null && pickedDate != birthDate)
      setState(() {
        birthDate = pickedDate;
        selectedDate.text = dateFormat.format(birthDate);
      });
  }
}
