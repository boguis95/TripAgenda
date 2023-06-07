
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:provider/provider.dart';

enum ActivityIdStatut{ onGoing, done}
class Trip {
  late String uId;
  late String id;
  late String city;
  late List<String> activitiesId;
  late Map<ActivityIdStatut, List<String>> activitiesIdByStatut;
  late DateTime date;
  late double amount;

  Trip({
    required this.id,
    required this.uId,
    required this.city,
    required this.activitiesId,
    required this.amount,
    required this.date,
    required this.activitiesIdByStatut});

  readDate(Timestamp dateTime) {
    DateTime date = DateTime.parse(dateTime.toDate().toString());
    // add DateFormat What you want. Look at the below comment example
    //String formatedDate = DateFormat('dd-MMM-yyy').format(date);
    //String formatedDate = DateFormat.yMMMMd().format(date);
    return date;
  }

 Trip.fromJson(String id, Map<String, dynamic> json)
 {
   this.id = id;
   uId = json['uId'];
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
        'uId': uId,
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