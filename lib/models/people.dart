import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

class Relationship{
  String firstName;
  String lastName;
  Timestamp birthDate;
  bool sendBirthdayReminders;
  Timestamp anniversary;
  bool sendAnniversaryReminders;
  String anniversaryType;
  String relationshipType;
  int randomReminders;
  String parentUserID;

  Relationship({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.sendBirthdayReminders,
    required this.anniversary,
    required this.sendAnniversaryReminders,
    required this.anniversaryType,
    required this.relationshipType,
    required this.randomReminders,
    required this.parentUserID
});
  void updateRelationship(
    String firstName,
    String lastName,
    Timestamp birthDate,
    bool sendBirthdayReminders,
    Timestamp anniversary,
    bool sendAnniversaryReminders,
    String anniversaryType,
    String relationshipType,
    int randomReminders,
    String parentUserID,
      )
  {
    firstName = firstName;
    lastName = lastName;
    birthDate = birthDate;
    sendBirthdayReminders = sendBirthdayReminders;
    anniversary = anniversary;
    sendAnniversaryReminders = sendAnniversaryReminders;
    anniversaryType = anniversaryType;
    relationshipType  = relationshipType;
    randomReminders = randomReminders;
    parentUserID = parentUserID;
  }

  Map<String, dynamic> toJson() => {
    cFirstName: firstName,
    cLastName: lastName,
    cBirthDate: birthDate,
    cSendBirthdayReminders: sendBirthdayReminders,
    cAnniversary: anniversary,
    cSendAnniversaryReminders: sendAnniversaryReminders,
    cAnniversaryType: cAnniversaryType,
    cRelationshipType: relationshipType,
    cRandomReminders: randomReminders,
    cUserId: parentUserID,
  };
  static Relationship fromJson(Map<String, dynamic> json) => Relationship(
    firstName: json.toString().contains(cFirstName) ? json[cFirstName] : "", // firstName: json['firstname'],
    lastName: json.toString().contains(cLastName) ? json[cLastName] : "",
    birthDate: json.toString().contains(cBirthDate) ? json[cBirthDate] : DateTime.now(),
    sendBirthdayReminders: json.toString().contains(cSendBirthdayReminders)? json[cSendBirthdayReminders] : false,
    anniversary: json.toString().contains(cAnniversary) ? json[cAnniversary] : DateTime.now(),
    sendAnniversaryReminders: json.toString().contains(cSendAnniversaryReminders)? json[cSendAnniversaryReminders] : false,
    anniversaryType: json.toString().contains(cAnniversaryType) ? json[cAnniversaryType]: "",
    relationshipType: json.toString().contains(cRelationshipType) ? json[cRelationshipType] : "",
    randomReminders: json.toString().contains(cRandomReminders) ? json[cRandomReminders]: 0,
    parentUserID: json.toString().contains(cUserId) ? json[cUserId] : "",
  );

}