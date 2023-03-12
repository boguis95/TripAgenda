
 import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';

class TripProvider with ChangeNotifier {

 final List<Trip> _trips = [];

 List<Trip> get trips {
   return _trips;
 }

 //permet d'ajouter un trip à notre liste de trip
 //notifyListerners() -> permet de notifier aux widgets qui consomme la donnée l'ajout d'un nouveau trip -> la mise à jour de la liste
 void addTrip(Trip trip) {
   trips.add(trip);
   notifyListeners();
 }

 List<Trip> getPastTrips(){
   return trips.where((trip) => trip.date.isBefore(DateTime.now())).toList();
 }

 List<Trip> getFutureTrips(){
   return trips.where((trip) => trip.date.isAfter(DateTime.now())).toList();
 }

 void setActivityToDown(Activity activity){
   activity.activityStatut = ActivityStatut.done;
   notifyListeners();
 }
}