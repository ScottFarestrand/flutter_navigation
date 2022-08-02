import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  // List<String> items = ['Wife', 'Husband', 'Daughter', 'Son,' 'Cat', 'Dog'];
  List<int> randomReminders = [0, 1, 2, 3, 4, 5, 6, 7 ];
  int reminderCount = 0;
  String? selectedItem = '';
  String? selectedType = '';
  List<String> relationshipTypes = [];
  bool celebrateBirthDay = true;
  bool celebrateAnniversary = false;
  @override
  Widget build(BuildContext context) {

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
            Row(
              children: [
                Text('Type of Replationship', style: TextStyle(fontSize: 16),),
                SizedBox(width: 10,),
                DropdownButton<String>(
                  hint: Text("Relationship Type"),
                  value: selectedType,
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
                  value: selectedItem,
                  items: relationshipTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 16),),
                    );
                  }).toList(),
                  onChanged: (item) {
                    print(item);
                    setState(() {
                      selectedItem = item;
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
                        print(count);
                      });

                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: (){
                  if(formGlobalKey.currentState!.validate())
                    {
                      print("Valid");
                      print(selectedItem);
                      if (selectedType == '' ){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Select Relationship Type before adding new person"),
                            ));
                            }
                      if (selectedItem == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Select Relationship  before adding new person")),
                        );
                      }
                    }
                  else
                    {ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Review Form errors before adding new person")),
                    );}

                }, child: Text('Add Person')
            ),



            // TextFormField(
            //     controller: firstNameController,
            //     keyboardType: TextInputType.text,
            //     decoration: InputDecoration(
            //       labelText: "First Name",
            //       labelStyle: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //     style: TextStyle(fontSize: 20),
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return "Please enter First Name";
            //       }
            //       return null;
            //     }
            // ),
            // buildTextFormField(lastNameController, "Last Name"),
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
      DateTime dateTime) {
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
      selectedItem = null;
      selectedType= relationshipType;
    });
  }
}
