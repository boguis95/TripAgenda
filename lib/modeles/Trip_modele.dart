
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';

enum ActivityIdStatut{ onGoing, done}
class Trip {
  String id;
  String city;
  //les id des activités
  List<String> activitiesId;
  Map<ActivityIdStatut, List<String>> activitiesIdByStatut;
  DateTime date;
  double amount;

  Trip({
    @required  this.city,
    @required  this.activitiesId,
    this.amount,
    this.date,
    this.activitiesIdByStatut});

  readDate(Timestamp dateTime) {
    DateTime date = DateTime.parse(dateTime.toDate().toString());
    // add DateFormat What you want. Look at the below comment example
    //String formatedDate = DateFormat('dd-MMM-yyy').format(date);
    //String formatedDate = DateFormat.yMMMMd().format(date);
    return date;
  }

 Trip.fromJson(String id, Map<String, dynamic> json)
 {
   //this.id = json['id'];
   city = json['city'];
   activitiesId = List<String>.from(json['activities'].map((id) => id).toList());
   amount = json['amount'];
   date = readDate(json['date']);
   //activitiesIdByStatut= json['activitiesIdByStatut'];
   activitiesIdByStatut = {
     ActivityIdStatut.onGoing: List<String>.from(json['activitiesIdByStatut'][ActivityIdStatut.onGoing.toString()].map((id) => id).toList()),
     ActivityIdStatut.done: List<String>.from(json['activitiesIdByStatut'][ActivityIdStatut.done.toString()].map((id) => id).toList()),
   };

 }

  Map<String, dynamic> toJson() =>
      {
        'city': city,
        'activities': activitiesId,
        'date': date,
        'amount': amount,
        "activitiesIdByStatut": {
          ActivityIdStatut.done.toString():activitiesIdByStatut[ActivityIdStatut.done],
          ActivityIdStatut.onGoing.toString(): activitiesIdByStatut[ActivityIdStatut.onGoing],
        }
      };
}