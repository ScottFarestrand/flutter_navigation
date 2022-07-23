class Relationship{
  String firstName;
  String lastName;
  DateTime birthDate;
  DateTime anniversaryDate;
  String relationshipType;
  int randomReminders;
  String parentUserID;

  Relationship({
   required this.firstName,
   required this.lastName,
   required this.birthDate,
   required this.anniversaryDate,
   required this.relationshipType,
   required this.randomReminders,
   required this.parentUserID
});
  void updateRelationship(
    String firstName,
    String lastName,
    DateTime birthDate,
    DateTime anniversaryDate,
    String relationshipType,
    int randomReminders,
    String parentUserID,
      )
  {
    firstName = firstName;
    lastName = lastName;
    birthDate = birthDate;
    anniversaryDate = anniversaryDate;
    relationshipType  = relationshipType;
    randomReminders = randomReminders;
    parentUserID = parentUserID;
  }

  Map<String, dynamic> toJson() => {
    'firstname': firstName,
    'lastname': lastName,
    'birthdate': birthDate,
    'anniversarydate': anniversaryDate,
    'relationshiptype': relationshipType,
    'randomreminders': randomReminders,
    'userid': parentUserID,
  };
  static Relationship fromJson(Map<String, dynamic> json) => Relationship(
    firstName: json.toString().contains("firstname") ? json['firstname'] : "",
    // firstName: json['firstname'],
    lastName: json['lastname'],
    birthDate: json['birthdate'],
    anniversaryDate: json['anniversarydate'],
    relationshipType: json['relationshiptype'],
    randomReminders: json['randomreminders'],
    parentUserID: json['userid'],
  );

}