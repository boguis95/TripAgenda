
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';

class City {
  String id;
  String name;
  String image;
  List<String> activities;

  City({
    required this.id,
    required this.name,
    required this.image,
    required this.activities});


  City.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        name = json['name'],
        image = json['image'],
        activities =  List<String>.from(json['activitiesId']);
}