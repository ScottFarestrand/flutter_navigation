import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/people.dart';
class RelationShip_Screen extends StatefulWidget {
  const RelationShip_Screen({Key? key}) : super(key: key);
  static const id = "Relationship_Screen";

  @override
  State<RelationShip_Screen> createState() => _RelationShip_ScreenState();
}

class _RelationShip_ScreenState extends State<RelationShip_Screen> {
  final formGlobalKey = GlobalKey<FormState>();
  final dateFormat = new DateFormat('MMM d, y');
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final anniversaryDateController = TextEditingController();

  DateTime birthDate = DateTime.now();
  DateTime anniversaryDate = DateTime.now();
  List<String> types = ['', 'Immediate Family', "Relatives", "Other" ];
  List<String> immediateFamily = ['', 'Wife', "Husband", "Daughter", "Son", "Cat", "Dog", "Other"];
  List<String> extendedFamily = ['', 'Grandmother', "Grandfather", "Aunt", "Uncle", "Cousin", "Great Grandmother", "Great Grandfather"];
  List<String> other = ['','Friend', 'Employee', 'other'];
  List<String> anniversaryType = ['', 'Marriage', 'Partnership', 'First Date', 'Other'];
  // List<String> items = ['Wife', 'Husband', 'Daughter', 'Son,' 'Cat', 'Dog'];
  List<int> randomReminders = [0, 1, 2, 3, 4, 5, 6, 7 ];
  int reminderCount = 0;
  String? selectedRelationshipType ='';
  String? selectedRelationship ='';
  String? selectedAnniveraryType = '';
  List<String> relationshipTypes = [];
  bool celebrateBirthDay = true;
  bool celebrateAnniversary = false;
  DateTime selectedBirthDate = DateTime.now();
  DateTime selectedAnnversaryDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    firstNameController.text = "LeeAnn";
    lastNameController.text = "Farestrand";

    print("Relationship SCreen");
    return Scaffold(
      appBar: AppBar(title: Text("Add person"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formGlobalKey,
          child: Column(children: [
            SizedBox(height: 20),
            buildTextFormField(firstNameController, "First Name"),
            buildTextFormField(lastNameController, "Last Name"),
            Row(
              children: [
                Text("Send BirthDay Reminders?", style: TextStyle(fontSize: 18),),
                Checkbox(value: celebrateBirthDay,
                    onChanged: (bool? value){
                      setState(() {
                        celebrateBirthDay = value!;
                      });
                    }),
              ],
            ),
            Visibility(
              visible: celebrateBirthDay,
                child: buildDateTextFormField( birthDateController, 'Birth Date',birthDate)),
            Row(
              children: [
                Text("Send Anniversary Reminders?", style: TextStyle(fontSize: 18),),
                Checkbox(value: celebrateAnniversary,
                    onChanged: (bool? value){
                      setState(() {
                        celebrateAnniversary = value!;
                      });
                    }),
              ],
            ),
            Visibility(
                visible: celebrateAnniversary,
                child: buildDateTextFormField(anniversaryDateController, "Anniversary Date", anniversaryDate)),
            SizedBox(height: 10,),
            Visibility(
              visible: celebrateAnniversary,
              child: Row(
              children: [
                Text('Type of Anniversary', style: TextStyle(fontSize: 16),),
                SizedBox(width: 10,),
                DropdownButton<String>(
                  hint: Text("Type of Anniversary"),
                  value: selectedAnniveraryType,
                  items: anniversaryType.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 16),),
                    );
                  }).toList(),
                  onChanged: (item) {
                    print(item);
                    setState(() {
                      selectedAnniveraryType = item;
                    });
                  },
                ),
              ],
            ),),
            Row(
              children: [
                Text('Type of Replationship', style: TextStyle(fontSize: 16),),
                SizedBox(width: 10,),
                DropdownButton<String>(
                  hint: Text("Relationship Type"),
                  value: selectedRelationshipType,
                  items: types.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 16),),
                    );
                  }).toList(),
                  onChanged: onChangedCallback,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 15,),
                Text('Select Replationship', style: TextStyle(fontSize: 16),),
                SizedBox(width: 10,),
                DropdownButton<String>(
                  value: selectedRelationship,
                  items: relationshipTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 16),),
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      selectedRelationship = item!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width *.70,
                    child: Text("# of Random Reminders")),
                // TextFormField(decoration: InputDecoration(
                //   labelText: "Random Reminders per year",
                //   labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),),
                Container(
                  width: MediaQuery.of(context).size.width * .15,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("Number of Random Reminders"),
                    value: reminderCount.toString(),
                    items: randomReminders.map((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString(), style: TextStyle(fontSize: 16),),
                      );
                    }).toList(),
                    onChanged: (count){
                      setState(() {

                        reminderCount = int.parse(count!);
                        print(reminderCount);
                        print(count);
                      });

                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: (){
                  print("Validating");
                  if(formGlobalKey.currentState!.validate())
                    {
                      print("Trying");
                      final Relationship newrel = Relationship(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          birthDate: Timestamp.fromDate(birthDate),
                          sendBirthdayReminders: celebrateBirthDay,
                          anniversary: Timestamp.fromDate(anniversaryDate),
                          sendAnniversaryReminders: celebrateAnniversary,
                          anniversaryType: selectedAnniveraryType!,
                          relationshipType: selectedRelationship!,
                          randomReminders: reminderCount,
                          parentUserID:  FirebaseAuth.instance.currentUser!.uid);
                      if ((celebrateAnniversary) && selectedAnniveraryType == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                            content: Text("Select Relationship Type before adding new person"),
                            ),);
                          };
                      if (selectedRelationshipType == '' ){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Select Relationship Type before adding new person"),
                            ));
                            }
                      if (selectedRelationship== '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Select Relationship before adding new person")),
                        );
                      }
                    }
                  else
                    {ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Review Form errors before adding new person")),
                    );}

                }, child: Text('Add Person')
            ),

          ],),
          ),
      ),
    );
  }
  void addPerson(){

  }
  TextFormField buildDateTextFormField(
      TextEditingController textEditingController,
      String labelText,
      DateTime dateTime,
      ) {
    return TextFormField(
          validator: (value){
            if (value == null || value.isEmpty) {
              return "Please enter $labelText";
            }
            return null;
            },
          onTap: () {_selectDate(context, textEditingController, dateTime);},
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontStyle: FontStyle.italic),
          ),
          style: TextStyle(fontSize: 18),
          controller: textEditingController,
          keyboardType: TextInputType.none,
        );
  }

  TextFormField buildTextFormField(TextEditingController textEditingController, String labelText) {
    return TextFormField(
          controller: textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontStyle: FontStyle.italic),
          ),
          style: TextStyle(fontSize: 18),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $labelText";
            }
            return null;
          }
      );
  }
  Future<void> _selectDate(BuildContext context, TextEditingController selectedDate, DateTime dateTime) async {
    final dateFormat = new DateFormat('MMM d, y');
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 125),
      lastDate: DateTime(DateTime.now().year + 1),);

    if (pickedDate != null && pickedDate != birthDate)
      setState(() {
        dateTime = pickedDate;
        selectedDate.text = dateFormat.format(dateTime);
        print(dateTime);
      });
  }
  void onChangedCallback(relationshipType) {
    if (relationshipType == 'Immediate Family') {
      relationshipTypes = immediateFamily;
    } else if (relationshipType == "Relatives") {
      relationshipTypes = extendedFamily;
    } else {
      relationshipTypes = other;
    }
    setState(() {
      selectedRelationshipType = relationshipType;
    });
  }
}
