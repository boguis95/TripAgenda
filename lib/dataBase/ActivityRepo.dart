

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/data/data.dart' as data;
import 'package:flutter_app/modeles/Activity_modele.dart';

class ActivityRepo {

  //CollectionReference -> fait reference à une collection (nom)
 static final  activityCollection = FirebaseFirestore.instance.collection("activities");

  //CityRepo();
  // ignore: missing_return
  Future<void> saveActivities() async  {
    List<Activity> activities = data.activities1;
    activities.forEach((activity)async {
      await activityCollection.doc(activity.id).set({
    "image": activity.image,
    "name": activity.name,
    //"id": activity.id,
    "city": activity.city,
    "price": activity.price,

      });
      print("save activities");
   });


  }

  //on va streamer -> récuperation à temps réel(mise à jour prise en compte) les activités relatif à la ville séléctionné
 static Stream<List<Activity>> getActivitiesByCity(String cityName) {
    return activityCollection.where('city',isEqualTo: cityName).snapshots().map((col) => col.docs.map((doc) => Activity.fromSnapshot(doc)).toList()) ;
  }


 Future<List<Activity>> getActivities(String cityName) async {
   QuerySnapshot col = await activityCollection.get();
   final List<Activity> activities = [];
     col.docs.forEach((doc) {
       Activity activity = Activity();
       if(doc.data()['city'] == cityName){
         activity.id = doc.id;
         activity.name = doc.data()['name'];
         activity.city =  doc.data()['city'];
         activity.image =  doc.data()['image'];
         activity.price =  doc.data()['price'];
         activity.activityStatut =  doc.data()['activityStatut'];
         activities.add(activity);
       }

      // print(activity.name);
     //  print(activities.length);
     });
    // print(activities.length);
     return activities;

  // print(activities.length);

 }
/*
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
*/


}