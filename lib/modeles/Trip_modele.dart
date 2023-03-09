
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';

class Trip {

  String city;
  //les id des activités
  List<Activity> activities;
  DateTime date;

  Trip({
    @required  this.city,
    @required  this.activities,
    this.date});
}