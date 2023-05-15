
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/data/data.dart' as data;

//with ChangeNotifier est une mixin -> permet de notifier un changement de données au wideget à qui les données sont provides(fourni)
//                                  -> les widgets pourront rebuild
class CityProvider with ChangeNotifier{

  //final List<City> _cities = data.cities;
  //final CollectionReference cityCollection = FirebaseFirestore.instance.collection("cities");
  Future<QuerySnapshot> activitiesSnapshot ;
  Future<QuerySnapshot> citiesSnap;
  Future<QuerySnapshot> _citiesSnap = FirebaseFirestore.instance.collection('cities').get();

  final CollectionReference cityCollection = FirebaseFirestore.instance.collection("cities");

  Future<QuerySnapshot> getProCityActivities(cityName) {
    activitiesSnapshot = FirebaseFirestore.instance.collection('activities').where('city',isEqualTo: cityName).get();
    return activitiesSnapshot;
  }

  Future<QuerySnapshot> getProCityByName(cityName) {
    citiesSnap = FirebaseFirestore.instance.collection('cities').where('name',isEqualTo: cityName).get();
    return citiesSnap;
  }
/*
  List<Activity> getProCityActivities(cityName) {
    activitiesSnapshot = ge
    List<Activity> activities = [];
    activitiesSnapshot.then((col) {
      col.docs.forEach((doc) {
        Activity activity = Activity.fromSnapshot(doc);
        activity.id = doc.id;
        activities.add(activity);
        print(activity.name);
      });
      print(activities.length);
    });
    return activities;
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



  City getProsCityByName (String cityName) {
    List<City> cities = [];
    _citiesSnap.then((col) {
      col.docs.forEach((doc) {
        City city = City.fromJson(doc.data());
        city.id = doc.id;
        cities.add(city);

      });
    });
    return cities.firstWhere((city) => city.name == cityName);
  }


//UnmodifiableListView -> va empecher la modification des éléments de notre liste au niveau des widgets qui utilise les données
  //  -> les données ne peuvent etre modifier qu'au niveau du Provider

 /*
 UnmodifiableListView<City>  get cities {
    return UnmodifiableListView(_cities);
  }*/

 /* City getCityByName (String cityName) {
    return cities.firstWhere((city) => city.name == cityName);
        }

  List<City> get cities {
    List<City> cities = [];
    citiesSnap.then((col) {
      col.docs.map((doc) {
        City city ;
        city.name = doc.data()['name'];
        city.image = doc.data()['image'];
        city.id = doc.id;
        cities.add(city);
        print(city.name);
        return cities;

      });

    });
    return cities;
  }

*/

 /*
 City getCityByName (String cityName) {
  // return _cities.firstWhere((city) => city.name == cityName);
  }
  */

}