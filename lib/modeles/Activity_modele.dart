
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ActivityStatut{ onGoig, done}
class Activity {

String name;
String image;
String id;
String city;
double price;
ActivityStatut activityStatut;


Activity({
  @required this.name,
  @required this.image,
  @required this.id,
  @required this.city,
  @required this.price,
  this.activityStatut = ActivityStatut.onGoig
 }) ;

factory Activity.fromSnapshot(DocumentSnapshot snap){
  var snapshot = snap.data();

  return Activity(
      id : snapshot['id'],
      name : snapshot['name'],
      image : snapshot['image'],
      city : snapshot['city'],
      price : snapshot['price'],
      activityStatut : snapshot['activityStatut']
  );
}


Activity.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      image = json['image'],
      city = json['city'],
      price = json['price'],
      activityStatut = json['activityStatut'] == 0 ? ActivityStatut.onGoig: ActivityStatut.done;
}



//En Dart pas besoin de créer le getter et setter, c'est faot implicitement
