import 'package:cloud_firestore/cloud_firestore.dart';

class Relationship{
  String firstName;
  String lastName;
  Timestamp birthDate;
  Timestamp anniversary;
  String relationshipType;
  int randomReminders;
  String parentUserID;

  Relationship({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.anniversary,
    required this.relationshipType,
    required this.randomReminders,
    required this.parentUserID
});
  void updateRelationship(
    String firstName,
    String lastName,
    Timestamp birthDate,
    Timestamp anniversary,
    String relationshipType,
    int randomReminders,
    String parentUserID,
      )
  {
    firstName = firstName;
    lastName = lastName;
    birthDate = birthDate;
    anniversary = anniversary;
    relationshipType  = relationshipType;
    randomReminders = randomReminders;
    parentUserID = parentUserID;
  }

  Map<String, dynamic> toJson() => {
    'firstname': firstName,
    'lastname': lastName,
    'birthdate': birthDate,
    'anniersary': anniversary,
    'relationshiptype': relationshipType,
    'randomreminders': randomReminders,
    'userid': parentUserID,
  };
  static Relationship fromJson(Map<String, dynamic> json) => Relationship(
    firstName: json.toString().contains("firstname") ? json['firstname'] : "", // firstName: json['firstname'],
    lastName: json.toString().contains("lastname") ? json['lastname'] : "",
    birthDate: json.toString().contains("birthdate") ? json['birthdate'] : DateTime.now(),
    anniversary: json.toString().contains("anniversary") ? json['anniversary'] : DateTime.now(),
    relationshipType: json.toString().contains("relationshiptype") ? json['relationshiptype'] : "",
    randomReminders: json.toString().contains("randomreminders") ? json['randomreminders']: 0,
    parentUserID: json.toString().contains("userid") ? json['userid'] : "",
  );

}