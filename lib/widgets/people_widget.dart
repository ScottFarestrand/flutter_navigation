import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/people.dart';
class People_Widget extends StatelessWidget {
  const People_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Building Container");
    return Container(
      child: StreamBuilder<List<Relationship>>(
          stream: readRelationships(),
          builder: (context, snapshot){
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final relationships = snapshot.data!;
              return ListView(children: relationships.map(buildRelationship).toList(),);
            } else {
              print(snapshot.error.toString());
              return Center(child:  CircularProgressIndicator());
            }
          }),
    );
  }
  Widget buildRelationship(Relationship relationship) => ListTile(
    leading: Text(relationship.firstName),
    title: Text(relationship.lastName),
    subtitle: Text('WOW'),
  );
  Stream<List<Relationship>> readRelationships() =>

      FirebaseFirestore.instance.
      collection('People').
      snapshots().
      map((snapshot) =>
        snapshot.docs.map((doc) => Relationship.fromJson(doc.data())).toList());

}
