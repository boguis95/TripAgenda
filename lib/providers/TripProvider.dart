import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/modeles/User.dart';
import 'package:flutter_app/servicies/Authenytication.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TripProvider with ChangeNotifier {

  //Stream<List<Trip>> trips;
  var docRef;
  final CollectionReference TripCollection = FirebaseFirestore.instance
      .collection("trips");

  late String tripId;
  bool isLoading = false;

/*
  Stream<List<Trip>> get trips {
    return TripCollection.snapshots().map((col) =>
        col.docs.map((doc) => Trip.fromJson(doc.data())).toList());
  }

 */


  // ignore: missing_return
  Future<String> saveTrip(data) async {
    var doc = await TripCollection.add(data);
    String id = doc.id;
    notifyListeners();
    return id;
  }

  readDate(Timestamp dateTime) {
    DateTime date = DateTime.parse(dateTime.toDate().toString());
    // add DateFormat What you want. Look at the below comment example
    //String formatedDate = DateFormat('dd-MMM-yyy').format(date);
    String formatedDate = DateFormat.yMMMMd().format(date);
    return date;
  }
/*
  Stream<List<Trip>> getTrips() {
    return TripCollection.snapshots().map((col) =>
        col.docs.map((doc) {
          return Trip.fromJson(doc.id,doc.data());
        }).toList());
  }

 */

  String get  id{
    return tripId;
  }

   set id(String id) {
     this.tripId = id;
  }




  Stream<List<Trip>> getPastTrips(BuildContext context) {

    return TripCollection.snapshots().map((col) =>
        col.docs.where((trip) {
         // tripId = trip.id;
          //print("tripId - TripProvider : "+tripId);
          var myTrip = trip.data() as Map<String, dynamic>;
          DateTime date = readDate(myTrip['date']);
          return date.isBefore(DateTime.now());
        }
        ).where((element) {
          var elem = element.data() as Map<String, dynamic>;
          return elem['uId'] == Provider.of<AppUser>(context, listen: false).uid;
        }).map((doc) {
          var docu = doc.data() as Map<String, dynamic>;
          id = doc.id;
          return Trip.fromJson(id,docu);
        }).toList());
  }

  Stream<List<Trip>> getFutureTrips(BuildContext context) {
    return TripCollection.snapshots().map((col) =>
        col.docs.where((trip) {
          // tripId = trip.id;
          //print("tripId - TripProvider : "+tripId);
          var myTrip = trip.data() as Map<String, dynamic>;
          DateTime date = readDate(myTrip['date']);
          return date.isAfter(DateTime.now());
        }
        ).where((element) {
          var elem = element.data() as Map<String, dynamic>;
          return elem['uId'] == Provider.of<AppUser>(context, listen: false).uid;
        }).map((doc) {
          id = doc.id;
          var docu = doc.data() as Map<String, dynamic>;
          return Trip.fromJson(id,docu);
        }).toList());
  }


  void setActivitiesStatut(Trip trip) {
    trip.activitiesIdByStatut = {
      ActivityIdStatut.onGoing: trip.activitiesId,
      ActivityIdStatut.done: [],

    };
  }

/*
  void updateStatut(){
    // Effectuez l'action de mise à jour ici
    // Par exemple, mettez à jour le champ activitiesIdByStatut

    Map<ActivityIdStatut, List<String>> updatedActivitiesIdByStatut = {
      ActivityIdStatut.inProgress: ['nouvelles_id_activites'],
      ActivityIdStatut.completed: activitiesIdByStatut[ActivityIdStatut.completed],
      ActivityIdStatut.cancelled: activitiesIdByStatut[ActivityIdStatut.cancelled],
    };

    Firestore.instance
        .collection('votre_collection')
        .doc(documentId)
        .update({'activitiesIdByStatut': updatedActivitiesIdByStatut});
  }
  }

 */
/*
  void updateActivitySta(String tripId, String activityId){

    TripCollection
        .doc(tripId)
        .update({'activitiesIdByStatut': updatedActivitiesIdByStatut});
  }

 */

  // ignore: missing_return
  Future<void> updateActivityStatus(String tripId, String activityId) async {
    DocumentSnapshot tripSnapshot = await TripCollection.doc(tripId).get();
    Trip tripData = Trip.fromJson(tripId, tripSnapshot.data() as Map<String, dynamic>);
    List<String> activitiesId = tripData.activitiesId;
    Map<ActivityIdStatut, dynamic> activitiesIdByStatut = tripData.activitiesIdByStatut;

    List<String> activitiesIdOngoing;
    List<String> activitiesIdDone;
        int index = activitiesId.indexOf(activityId);
    if(index != -1 ){
    activitiesIdByStatut[ActivityIdStatut.onGoing].remove(activityId);
     activitiesIdByStatut[ActivityIdStatut.done].add(activityId);
     notifyListeners();
    }
 var value = await TripCollection.doc(tripId).update({"activitiesIdByStatut": {
      ActivityIdStatut.done.toString(): activitiesIdByStatut[ActivityIdStatut.done],
      ActivityIdStatut.onGoing.toString(): activitiesIdByStatut[ActivityIdStatut.onGoing],
    }}).then((value) =>    notifyListeners());
  notifyListeners();
  return value;
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
