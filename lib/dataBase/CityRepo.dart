
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/modeles/User.dart';
import 'package:flutter_app/data/data.dart' as data;

class CityRepo {

 final List<City> cities = [];


  //CollectionReference -> fait reference à une collection (nom)
  final CollectionReference cityCollection = FirebaseFirestore.instance.collection("cities");

  //CityRepo();
  // ignore: missing_return
 /*
 Future<void> saveCities() async  {
    List<City> cities = data.cities;

    cities.forEach((city)async {
      //List<String> activitiesId ;
     // city.activities.map((e) => activitiesId.add(e));
      await cityCollection.add({
        'name': city.name,
        'image' : city.image,
        //'activities'    : activitiesId
      });
      print("save cities");
    });


  }

  */
  /*
  //DocumentSnapshot -> fait reference à un document
  //QuerySnapshot -> par contre fait reference à une liste de documents
  City cityFromSnapshot(DocumentSnapshot snapshot) {
    return City(
     // uid: uid,
      activities: snapshot.data()['activities'],
      image: snapshot.data()['image'],
      name: snapshot.data()['name']
    );
  }

  Stream<List<City>> get citiesList {
    return cityCollection.snapshots().map(cityListFromSnapshot);
  }

/*
 City getCityByName (String cityName) {
   List<City> cities =  listOfCities();
   return cities.firstWhere((city) => city.name == cityName, orElse: () => null);
 }

 List<City>  listOfCities() {
   List<City> cities = [];
   cityCollection.get().then((col) {
      col.docs.forEach((doc) {
       City city = City() ;
       city.name = doc.data()['name'];
       city.image = doc.data()['image'];
       city.id = doc.id;
       cities.add(city);
       print(city.name);

     });
   });
   return cities;
 }

 */


 Future<List<City>> listOfCities() async {
   List<City> cities = [];
   QuerySnapshot col = await cityCollection.get();
   col.docs.forEach((doc) {
     City city = City() ;
     city.name = doc.data()['name'];
     city.image = doc.data()['image'];
     city.id = doc.id;
     cities.add(city);
     print(city.name);
   });
   return cities;
 }

 Future<City> getCityByName(String cityName) async {
   List<City> cities = await listOfCities();
   return cities.firstWhere((city) => city.name == cityName, orElse: () => null);
 }



  //recuperation de la liste des utilisateurs de firebase et mappage en AppUser
  List<City> cityListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return cityFromSnapshot(doc);
    });
  }

   */


}