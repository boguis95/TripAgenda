
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';

class City {

  String name;
  String image;
  List<Activity> activities;

  City({
    @required this.name,
    @required  this.image,
    @required  this.activities});
}