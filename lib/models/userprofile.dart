// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
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
    cFirstName: firstName,
    cLastName: lastName,
    cCellPhone: cellPhone,
    cBirthDate: birthDate,
    cSendTextReminders: sendTextReminders,
    cSendEmailReminders: sendEmailReminders,
    cCellPhoneValidated: cellPhoneValidated,
  };

  static UserProfile fromJson(Map<String, dynamic> json) => UserProfile(
    firstName: json[cFirstName],
    lastName: json[cLastName],
    cellPhone: json[cCellPhone],
    birthDate: json[cBirthDate],
    sendTextReminders: json[cSendTextReminders],
    sendEmailReminders: json[cSendEmailReminders],
    cellPhoneValidated: json[cCellPhoneValidated],
  );

}