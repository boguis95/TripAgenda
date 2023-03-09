
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ActivityStatut{ onGoig, done}
class Activity {

String name;
String image;
String id;
String city;
double price;
ActivityStatut statut;


Activity({
  @required this.name,
  @required this.image,
  @required this.id,
  @required this.city,
  @required this.price}) : statut = ActivityStatut.onGoig;

//En Dart pas besoin de créer le getter et setter, c'est faot implicitement
}