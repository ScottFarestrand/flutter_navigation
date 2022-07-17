// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import '../models/userprofile.dart';
//
//
// class Profile extends StatefulWidget {
//
//   const Profile({Key? key}) : super(key: key);
//   static const id = "Register";
//   // final bool emailVerified;
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   int _currentIndex = 0;
//   bool _BottomNavVisible = true;
//   final dateFormat = new DateFormat('MMM d, y');
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final cellPhoneNumberController = TextEditingController();
//   final dateController = TextEditingController();
//   final birthDateController = TextEditingController();
//   // MaskTextInputFormatter formatter();
//   var maskFormatter = new MaskTextInputFormatter(mask: '###.###.####', filter: { "#": RegExp(r'[0-9]') });
//   DateTime birthDate = DateTime.now();
//   String firstName = "";
//   String lastName = "";
//   String cellPhoneNumber = "";
//   bool textReminders = false;
//   bool emailReminders = false;
//   bool cellPhoneValidated = false;
//   // bool _saved = true;
//   String origCellPhone = "";
//   bool _cellValidated = false;
//   bool _alerted = false;
//   final UserProfile userProfile = UserProfile(
//     firstName: "",
//     lastName: "",
//     birthDate: DateTime.now(),
//     cellPhone: "",
//     cellPhoneValidated: false,
//     sendEmailReminders: false,
//     sendTextReminders: false,
//   );
//
//
//
//
//   Future<void> _selectDate(BuildContext context, TextEditingController selectedDate) async {
//     final dateFormat = new DateFormat('MMM d, y');
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: birthDate,
//       firstDate: DateTime(DateTime.now().year - 125),
//       lastDate: DateTime(DateTime.now().year + 1),);
//     if (pickedDate != null && pickedDate != birthDate)
//       setState(() {
//         birthDate = pickedDate;
//         selectedDate.text = dateFormat.format(birthDate);
//       });
//   }
//
//   @override
//
//   Widget build(BuildContext context) {
//     print("Building Profile");
//     String tempDate;
//     int _seconds;
//     int _nanoseconds = 0;
//     final user =  FirebaseAuth.instance.currentUser!;
//     print(user.email);
//     print(user.uid);
//     try {
//       FirebaseFirestore.instance.collection('Users').
//       doc(FirebaseAuth.instance.currentUser!.uid).
//       get().then((snapshot) =>
//       {
//          print("Got The Record"),
//         print(snapshot['birthdate'].toString()),
//         tempDate = snapshot['birthdate'].toString(),
//         _seconds = int.parse(tempDate.substring(18, 28)),
//         _nanoseconds =
//             int.parse(tempDate.substring(42, tempDate.lastIndexOf(')'))),
//         birthDate = Timestamp(_seconds, _nanoseconds).toDate(),
//         firstNameController.text = snapshot['firstname'],
//         lastNameController.text = snapshot['lastname'],
//         emailReminders = snapshot["sendemailreminders"],
//         textReminders = snapshot["sendtextreminders"],
//         cellPhoneNumberController.text = snapshot["cellphone"],
//         cellPhoneValidated = snapshot["CellPhoneValidated"],
//         userProfile.updateUserProfile(
//           snapshot['firstname'],
//           snapshot['lastname'],
//           snapshot["cellphone"],
//           birthDate,
//           snapshot["sendtextreminders"],
//           snapshot["sendemailreminders"],
//           snapshot["CellPhoneValidated"],
//         )
//
//       });
//     } on FirebaseException catch(error){
//       print(error.code);
//       print(error.message);
//     }
//
//
//     final formKey = GlobalKey<FormState>();
//       FirebaseFirestore.instance.collection('Users').
//       doc(FirebaseAuth.instance.currentUser!.uid).
//       get().then((snapshot) =>
//       {
//
//         tempDate = snapshot['birthdate'].toString(),
//         _seconds = int.parse(tempDate.substring(18, 28)),
//         _nanoseconds =
//             int.parse(tempDate.substring(42, tempDate.lastIndexOf(')'))),
//         birthDate = Timestamp(_seconds, _nanoseconds).toDate(),
//
//         userProfile.updateUserProfile(
//             snapshot['firstname'],
//             snapshot['lastname'],
//             snapshot['cellphone'],
//             birthDate,
//             snapshot["sendtextreminders"],
//             snapshot["sendemailreminders"],
//             snapshot["cellphonevalidated"]),
//
//         firstNameController.text = userProfile.firstName,
//         lastNameController.text = userProfile.lastName,
//         emailReminders = userProfile.sendEmailReminders,
//         textReminders = userProfile.sendTextReminders,
//         cellPhoneNumberController.text = userProfile.cellPhone,
//         origCellPhone = snapshot["cellphone"],
//         cellPhoneValidated = snapshot["cellphonevalidated"],
//         birthDateController.text = dateFormat.format(userProfile.birthDate),
//         print(birthDateController.text),
//       });
//
//     // final widgets = [
//     //   // UserProfile2(emailVerified: _emailValidated),
//     //   Profile(),
//     //   People(),
//     //
//     //   // Calendar()
//     // ];
//
//     return Scaffold(
//       bottomNavigationBar: Visibility(
//         visible: _BottomNavVisible,
//         child: BottomNavigationBar(
//           onTap: (index) => setState(() => _currentIndex = index),
//           currentIndex: _currentIndex,
//           backgroundColor: Colors.blue,
//           showUnselectedLabels: true,
//           showSelectedLabels: true,
//           selectedFontSize: 16,
//           unselectedFontSize: 12,
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white70,
//
//
//           items:[
//             BottomNavigationBarItem(
//                 backgroundColor: Colors.blue,
//                 icon: Icon(Icons.person),
//                 label: "Profile"),
//             BottomNavigationBarItem(
//                 backgroundColor: Colors.blue,
//                 icon: Icon(Icons.people),
//                 label: "People"),
//             BottomNavigationBarItem(
//                 backgroundColor: Colors.blue,
//                 icon: Icon(Icons.schedule),
//                 label: "Reminders"),
//           ],
//         ),
//       ),
//       body: Profile(),
//       // body: Form(
//       //   key: formKey,
//       //   child: Padding(
//       //     padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
//       //     child: Column(
//       //       children: <Widget>[
//       //         SizedBox(height: 20),
//       //
//       //         TextFormField(
//       //             controller: firstNameController,
//       //             keyboardType: TextInputType.text,
//       //             decoration: InputDecoration(
//       //               labelText: "First Name",
//       //               labelStyle: TextStyle(fontStyle: FontStyle.italic),
//       //             ),
//       //             style: TextStyle(fontSize: 20),
//       //             validator: (value) {
//       //               if (value == null || value.isEmpty) {
//       //                 return "Please enter First Name";
//       //               }
//       //               return null;
//       //             }
//       //         ),
//       //         TextFormField(
//       //             controller: lastNameController,
//       //             keyboardType: TextInputType.text,
//       //             decoration: InputDecoration(
//       //               labelText: "Last Name",
//       //               labelStyle: TextStyle(fontStyle: FontStyle.italic),
//       //             ),
//       //             style: TextStyle(fontSize: 20),
//       //             validator: (value) {
//       //               if (value == null || value.isEmpty) {
//       //                 return "Please enter Last Name";
//       //               }
//       //               return null;
//       //             }
//       //         ),
//       //         TextFormField(
//       //           onTap: () {_selectDate(context, dateController);},
//       //           decoration: InputDecoration(
//       //             labelText: "Birth Date",
//       //             labelStyle: TextStyle(fontStyle: FontStyle.italic),
//       //           ),
//       //           style: TextStyle(fontSize: 20),
//       //           controller: birthDateController,
//       //           keyboardType: TextInputType.none,
//       //         ),
//       //         TextFormField(
//       //           // inputFormatters: [MaskedInputFormater('(###) ###-####')],
//       //           inputFormatters: [maskFormatter],
//       //           controller: cellPhoneNumberController,
//       //           keyboardType: TextInputType.phone,
//       //           decoration: InputDecoration(
//       //             labelText: "Cell Phone Number",
//       //             labelStyle: TextStyle(fontStyle: FontStyle.italic),
//       //           ),
//       //           style: TextStyle(fontSize: 20),
//       //         ),
//       //         Row(children: [
//       //           Text('Send Text Reminders', style: TextStyle(fontSize: 20),),
//       //           SizedBox(width: 10,),
//       //           FlutterSwitch(
//       //               activeToggleColor: Colors.white,
//       //               inactiveColor: Colors.blueGrey,
//       //               height: 25,
//       //               width: 50,
//       //               value: textReminders,
//       //               onToggle: (bool? value) { // This is where we update the state when the checkbox is tapped
//       //                 print(textReminders);
//       //                 print(emailReminders);
//       //                 print("setting");
//       //                 setState(() {
//       //                   _saved = false;
//       //                   textReminders = !textReminders;
//       //                 });
//       //                 print("set");
//       //                 print(textReminders);
//       //                 print(emailReminders);
//       //
//       //               })
//       //         ],),
//       //         Row(children: [SizedBox(height: 10,)],),
//       //         Row(children: [
//       //
//       //           Text('Send Email Reminders', style: TextStyle(fontSize: 20), ),
//       //           SizedBox(width: 10,),
//       //           // ToggleButtons(children: [Text("Yes"),Text("no")], isSelected: (){}),
//       //           FlutterSwitch(
//       //               activeToggleColor: Colors.white,
//       //               inactiveColor: Colors.blueGrey,
//       //               height: 25,
//       //               width: 50,
//       //               value: emailReminders,
//       //               onToggle: (bool? value) { // This is where we update the state when the checkbox is tapped
//       //
//       //                 setState(() {
//       //                   _saved = false;
//       //                   emailReminders = !emailReminders;
//       //                 });
//       //               })
//       //         ],),
//       //         ElevatedButton(onPressed: (){
//       //           FirebaseAuth.instance.signOut();
//       //         }, child: Text("Log out")),
//       //         ElevatedButton(onPressed: (){
//       //           print("hmmmm");
//       //           final userprofile = UserProfile(
//       //               firstName: firstNameController.text,
//       //               lastName: lastNameController.text,
//       //               cellPhone: cellPhoneNumberController.text,
//       //               birthDate: birthDate,
//       //               sendTextReminders: textReminders,
//       //               sendEmailReminders: emailReminders,
//       //               cellPhoneValidated: _cellValidated);
//       //
//       //           updateUser(userprofile);
//       //           // addRecord(firstNameController.text, lastNameController.text, birthDate);
//       //         }, child: Text("Save")),
//       //         Visibility(
//       //           visible: ( !cellPhoneValidated && _saved),
//       //           child: ElevatedButton(
//       //             onPressed: (){},
//       //             child: Text("Validate Cell Number"),),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // )
//     );
//   }
//
//   Future updateUser(UserProfile userprofile) async {
//     final myID = FirebaseAuth.instance.currentUser!.uid;
//     final docUser = FirebaseFirestore.instance.collection('Users').doc(
//         myID);
//     final json =userprofile.toJson();
//     await docUser.set(json);
//   }
//   addRecord (String firstName, String lastName, DateTime birthDate  )  {
//     final myID = FirebaseAuth.instance.currentUser!.uid;
//     final docUser = FirebaseFirestore.instance.collection('Users').doc(
//         myID);
//
//     print("Saving");
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Saving User")),
//     );
//     if (cellPhoneNumberController.text != origCellPhone) {
//       cellPhoneValidated  = false;
//     }
//     print(textReminders);
//     if (cellPhoneNumberController.text != origCellPhone) {
//       cellPhoneValidated = false;
//     }
//     // FirebaseAuth.instance.signOut();
//     final json = {
//       'FirstName': firstNameController.text,
//       'LastName': lastNameController.text,
//       'BirthDate': birthDate,
//       'SendTextReminders': textReminders,
//       'SendEmailReminders': emailReminders,
//       'CellPhone': cellPhoneNumberController.text,
//       'CellPhoneValidated': cellPhoneValidated,
//     };
//     try {
//       print("Trying");
//       docUser.set(json)
//           .then((stuff) {
//         print("saved");
//       })
//           .catchError((e) {
//         print("Error Caught");
//         print(e.code);
//         print(e.message);
//
//         // print(Err.toString());
//         if (e.code == "permission-denied") {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("You Do not have necessary permission",
//                 style: TextStyle(backgroundColor: Colors.red),),
//             ),
//           );}
//       });
//     } on FirebaseException catch (err){
//       print(err.toString());
//     } on IOException catch(err) {
//       print(err.toString());
//     }
//
//
//
//     setState((){
//       // _saved = true;
//     });
//
//
//   }
//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Email Not Validated'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: const <Widget>[
//                 Text('To ensure your email address was correct, we just sent you an email to verify you entered your email address correctly. Please check your email and click the link to validate your email address'),
//
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Ok'),
//               onPressed: () {
//                 final user = FirebaseAuth.instance.currentUser;
//
//                 Navigator.of(context).pop();
//
//                 user!.sendEmailVerification()
//                     .whenComplete(() => print("Success"))
//                     .onError((error, stackTrace) {print(error);});
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }