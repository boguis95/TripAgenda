
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/modeles/User.dart';
import 'package:flutter_app/data/data.dart' as data;
import 'package:intl/intl.dart';

class TripRepo {

  final List<City> cities = [];


  //CollectionReference -> fait reference à une collection (nom)
  // ignore: non_constant_identifier_names
  final CollectionReference TripCollection = FirebaseFirestore.instance.collection("trips");

  //CityRepo();
  // ignore: missing_return
 /* Future<void> saveTrip(data) async  {
   TripCollection.add(data);


  }

  readDate(Timestamp dateTime) {
    DateTime date = DateTime.parse(dateTime.toDate().toString());
    // add DateFormat What you want. Look at the below comment example
    //String formatedDate = DateFormat('dd-MMM-yyy').format(date);
    String formatedDate = DateFormat.yMMMMd().format(date);
    return date;
  }

      Stream<List<Trip>> getTrips() {
       return TripCollection.snapshots().map((col) => col.docs.map((doc) {

         return Trip.fromJson(doc.data());
         } ).toList()) ;
     }



  Stream<List<Trip>> getPastTrips(){

    return TripCollection.snapshots().map((col) =>col.docs.where((trip) {
      DateTime date = Trip().readDate(trip.data()['date']);
      return date.isBefore(DateTime.now());
    }
    ).map((doc) => Trip.fromJson(doc.data())).toList() );
  }

  Stream<List<Trip>> getFutureTrips(){

    return TripCollection.snapshots().map((col) =>col.docs.where((trip) {
      DateTime date = Trip().readDate(trip.data()['date']);
      return date.isAfter(DateTime.now());
    }
    ).map((doc) => Trip.fromJson(doc.data())).toList() );
  }

  */
  //DocumentSnapshot -> fait reference à un document
  //QuerySnapshot -> par contre fait reference à une liste de documents

}