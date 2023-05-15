import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:intl/intl.dart';

class TripProvider with ChangeNotifier {

  //Stream<List<Trip>> trips;
  var docRef;
  final CollectionReference TripCollection = FirebaseFirestore.instance
      .collection("trips");

  String tripId;

/*
  Stream<List<Trip>> get trips {
    return TripCollection.snapshots().map((col) =>
        col.docs.map((doc) => Trip.fromJson(doc.data())).toList());
  }

 */


  // ignore: missing_return
  Future<String> saveTrip(data) async {

    var doc = TripCollection.add(data);
    String id ;
    doc.then((value) {
      id = value.id;
    });
    return id;
    notifyListeners();
  }

  readDate(Timestamp dateTime) {
    DateTime date = DateTime.parse(dateTime.toDate().toString());
    // add DateFormat What you want. Look at the below comment example
    //String formatedDate = DateFormat('dd-MMM-yyy').format(date);
    String formatedDate = DateFormat.yMMMMd().format(date);
    return date;
  }

  Stream<List<Trip>> getTrips() {
    return TripCollection.snapshots().map((col) =>
        col.docs.map((doc) {
          return Trip.fromJson(doc.id,doc.data());
        }).toList());
  }

  String get  id{
    return tripId;
  }

   set id(String id) {
     this.tripId = id;
  }


  Stream<List<Trip>> getPastTrips() {

    return TripCollection.snapshots().map((col) =>
        col.docs.where((trip) {
         // tripId = trip.id;
          //print("tripId - TripProvider : "+tripId);
          DateTime date = Trip().readDate(trip.data()['date']);
          return date.isBefore(DateTime.now());
        }
        ).map((doc) => Trip.fromJson(tripId,doc.data())).toList());
  }

  Stream<List<Trip>> getFutureTrips() {
    String tripId;
    return TripCollection.snapshots().map((col) =>
        col.docs.where((trip) {
         id = trip.id;
          //print("tripId - TripProvider : "+tripId);
          DateTime date = Trip().readDate(trip.data()['date']);
          return date.isAfter(DateTime.now());
        }
        ).map((doc) => Trip.fromJson(tripId,doc.data())).toList());
  }


  void setActivitiesStatut(Trip trip) {
    trip.activitiesIdByStatut = {
      ActivityIdStatut.onGoing: trip.activitiesId,
      ActivityIdStatut.done: [],

    };
  }
  void updateActivityStatus(String tripId, String activityId) async {
    DocumentSnapshot tripSnapshot = await TripCollection.doc(tripId).get();
    Trip tripData = Trip.fromJson(tripId, tripSnapshot.data());
    List<String> activitiesId = tripData.activitiesId;
    Map<ActivityIdStatut, dynamic> activitiesIdByStatut = tripData.activitiesIdByStatut;


    int index = activitiesId.indexOf(activityId);
    if(index != -1 ){
      activitiesIdByStatut[ActivityIdStatut.onGoing].remove(activityId);
      activitiesIdByStatut[ActivityIdStatut.onGoing].add(activityId);
    }
    TripCollection.doc(id).update({"activitiesIdByStatut": {
      ActivityIdStatut.done.toString():activitiesIdByStatut[ActivityIdStatut.done],
      ActivityIdStatut.onGoing.toString(): activitiesIdByStatut[ActivityIdStatut.onGoing],
    }});
    notifyListeners();

  }

/*
  void setActivityToDone(Trip trip,String activityId) {
      trip.activitiesIdByStatut[ActivityIdStatut.onGoing].remove(activityId);
      trip.activitiesIdByStatut[ActivityIdStatut.onGoing].add(activityId);

    }

 */

    //permet d'ajouter un trip à notre liste de trip
    //notifyListerners() -> permet de notifier aux widgets qui consomme la donnée l'ajout d'un nouveau trip -> la mise à jour de la liste
/* void addTrip(Trip trip)  {
  // db.collection("trips").add(trip as Map<String, dynamic> ).then((value) => null);
   trips.add(trip);
   notifyListeners();
 }

 List<Trip> getPastTrips(){
   return trips.where((trip) => trip.date.isBefore(DateTime.now())).toList();
 }

 List<Trip> getFutureTrips(){
   return trips.where((trip) => trip.date.isAfter(DateTime.now())).toList();
 }

 */


  }
