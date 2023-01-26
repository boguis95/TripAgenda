

import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity.modele.dart';
import 'package:flutter_app/data/data.dart' as data;
import 'package:flutter_app/modeles/Trip.modele.dart';
import 'package:flutter_app/views/city/widgets/activity_card.dart';
import 'package:flutter_app/views/city/widgets/activity_list.dart';
import 'package:flutter_app/views/city/widgets/tripOverview.dart';
import 'package:flutter_app/views/city/widgets/trip_activity_list.dart';
import 'package:intl/intl.dart';


class City extends StatefulWidget {
  //la liste des activités n'est pas appelé à etre modifié puisqu'il est installé en dur
  //tout ce qui est déclaré dans une classe widget est imutable
 final List<Activity> activities = data.activities;

  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {

  Trip myTrip;
  int index;

  //initState permet d'initialiser notre state
  //fourni les données initiales qui pourront etre mis à jour avec setState()
  @override
  void initState() {
    super.initState();
    myTrip = Trip(city: "Paris", activities:[], date: null);
    index = 0;
  }

  //permet  de mettre à jour l'idex du widget sur le quel on a tapé
  void switchIndex(newIndex){
    setState(() {
      index = newIndex;
    });
  }

  void toggleActivity(String id) {
    setState(() {
      myTrip.activities.contains(id) ?
          myTrip.activities.remove(id) :
          myTrip.activities.add(id);
    });
  }

  // permet de définir la date du voyage
  void setDate() {
    //showDatePicker -> permet d'afficher un calendier pour séléctionner une date
    // elle retourne une promesse qui correspond à la date séléctionnée
    showDatePicker(
      // on a acces au context dans la classe state
        context: context,
        //la date à partir de la quelle on peut séléctionner une date -> elle est exclu
        firstDate: DateTime.now(),
        //premiere date séléctionnable
        initialDate: DateTime.now().add(Duration(days: 1)),
        //derniere date séléctionnable -> ici ce sera le 1/1/2024
        lastDate: DateTime(2024),
        //permet de presonnaliser les jours séléctionnable -> ici que les 5 premiers jours de la semaine
       //selectableDayPredicate: (d) => d.weekday < 6,
        )
        // on récupere la promesse(date choisi) et on met à jour la date séléctionnéem
        .then((newDate) {
          setState(() {
            myTrip.date = newDate;
          });
    });

  }

  //getter qui permet de récuperer le prix d'une activité séléctionner


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organisation de voyage"),
        leading: Icon(Icons.chevron_left),
        actions: [Icon(Icons.more_vert)],
      ),
      body: Container(
        //ListView() va permettre de scroller quand on a un nombre d'élément qui dépasse l'écran
        //   -> contrairement au column
        //   -> mais pas très performant lorsque l'on a un grand nombre d'éléments
        child: Column(
          children: [
            TripOverview(setDate: setDate, trip: myTrip,),
            //on wrap le Gridview.builder() -> pour qu'il prenne tout l'espace restant disponible
            // -> sinon il va vouloir prendre tout l'espace du widget parent et proqué un bug
            Expanded(
              child: index == 0
                  ? ActivityList(activities: widget.activities,
                                toggleActivity: toggleActivity)
                  : TripActivityList(),
            )

          ],
        )


      ),
      bottomNavigationBar: BottomNavigationBar(
        //l'index de l'item acctuel
        //permet de changer l'activeItem
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Découverte"

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: "Mes activités"
          )
        ],
        //ontap -> permet de récuperer la valeur de  l'index de l'item sur le quel on tap
        // l'index de l'item sur le quel on a tapé va directement etre attribué au parametre newIndex
        onTap: switchIndex,
      ),
    );
  }
}
