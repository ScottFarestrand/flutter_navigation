// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
class UserProfile {
  String firstName;
  String lastName;
  String cellPhone;
  DateTime birthDate;
  bool sendTextReminders;
  bool sendEmailReminders;
  bool cellPhoneValidated;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.cellPhone,
    required this.birthDate,
    required this.sendTextReminders,
    required this.sendEmailReminders,
    required this.cellPhoneValidated,
  });
  void updateUserProfile(
      String firstname,
      String lastname,
      String cellphone,
      DateTime birthdate,
      bool sendtextreminders,
      bool sendemailreminders,
      bool cellphonevalidated,
      ){
    firstName = firstname;
    lastName = lastname;
    cellPhone = cellphone;
    birthDate = birthdate;
    sendTextReminders = sendtextreminders;
    sendEmailReminders  = sendemailreminders;
    cellPhoneValidated = cellphonevalidated;
  }
  Map<String, dynamic> toJson() => {
    'firstname': firstName,
    'lastname': lastName,
    'cellphone': cellPhone,
    'birthdate': birthDate,
    'sendtextreminders': sendTextReminders,
    'sendemailreminders': sendEmailReminders,
    'cellphonevalidated': cellPhoneValidated,
  };

  static UserProfile fromJson(Map<String, dynamic> json) => UserProfile(
    firstName: json['firstname'],
    lastName: json['lastname'],
    cellPhone: json['cellphone'],
    birthDate: json['birthdate'],
    sendTextReminders: json['sendtextreminders'],
    sendEmailReminders: json['sendEmailReminders'],
    cellPhoneValidated: json['cellphonevalidated'],
  );

}