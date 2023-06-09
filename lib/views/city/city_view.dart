

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dataBase/ActivityRepo.dart';
import 'package:flutter_app/dataBase/TripRepo.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/City_modele.dart';

import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/modeles/User.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/providers/TripProvider.dart';
import 'package:flutter_app/servicies/Authenytication.dart';
import 'package:flutter_app/views/city/widgets/activity_card.dart';
import 'package:flutter_app/views/city/widgets/activity_list.dart';
import 'package:flutter_app/views/city/widgets/tripOverview.dart';
import 'package:flutter_app/views/city/widgets/trip_activity_list.dart';
import 'package:flutter_app/widget_utils/DataWidget.dart';
import 'package:flutter_app/widget_utils/MyDrawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/data/data.dart' as data;



// ignore: must_be_immutable
class CityView extends StatefulWidget {


  //la liste des activités n'est pas appelé à etre modifié puisqu'il est installé en dur
  //tout ce qui est déclaré dans une classe widget est imutable
 // List<Activity> activities = data.activities1;

  static const String routeName = "/city";

   CityView() ;




   showContent({required BuildContext context, required List<Widget> children}) {
    //Ici On recupere l'orientation de l'écran à l'instant t (landscape -> sur la largeur, portrait -> sur la longueur
    //  -> grace à l'inheritidet natif MediaQuery
  /*  final orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.landscape){
     return Row(
       //on veut que notre Row() prend toute la hauteur  disponible
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: children,);
    }else{

   */
     return Column(children: children,);
    //}
  }

  @override
  _CityViewState createState() => _CityViewState();
}

class _CityViewState extends State<CityView> {


  late City city;
  //List<Activity> activities;
  late Trip myTrip;
  late int index;
  bool isDateSet = false;
  Map<ActivityIdStatut, List<String>> activityStatusMap = {
    ActivityIdStatut.onGoing: [],
    ActivityIdStatut.done: [],
  };





  //initState permet d'initialiser notre state
  //fourni les données initiales qui pourront etre mis à jour avec setState()

  @override
  void initState() {
    super.initState();
    myTrip = Trip(city: "", activitiesId:[], date: new DateTime(0), activitiesIdByStatut: activityStatusMap, id: '', uId: '', amount: 0.0 );
    index = 0;

  }

  //permet d'écouter les changement des donné du widget parent(inherited widget)
  //les changement lui sont notifié par la méthode updateShouldNotify() de l'inheritedWidget
  // -> entraine un rebuild du widget s'il ya modification du parent
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
     city = (ModalRoute.of(context)?.settings.arguments as City?)!;
   // _activitiesSnapshot = FirebaseFirestore.instance.collection('activities').where('city',isEqualTo: city.name).get();
    //on fait appel à la méthode static of() de l'inheritWidget DataWidget
    // of() return context.dependOnInheritedWidgetOfExactType<DataWidget>() -> qui permet d'acceder aux données dans l'inheritWidget DataWidget
    //activities = DataWidget.of(context).activities;

  }
/*
  List<Activity> getActivities() {
    List<Activity> activities = [];
    _activitiesSnapshot.then((col) {
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

  /*
  City getCityByName (String cityName) {
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

   */

  double getAmount(City city, List<Activity> activities) {
    //fold -> nous permet d'incrémenter une valeur initialement fournit
    //0.0 -> valeur initiale
    //previously -> valeur précedant
    //firtWhere() -> l'incrémentation se fera si l'activité en question verifie la condition
    //               -> si son id est présent dans la lites des id des activités séléctionnées
    //            -> on a également une décrémentation quand la condition n'est plus verifié
    return myTrip.activitiesId.fold(0.0, (previousValue, element){
    Activity activity = activities.firstWhere((activity) => activity.id == element);

    //reviousValue + activity.price -> donnera une nouvelle valeur à la valeur initiale
    //on retourne la valeur la plus récente
    //print(previousValue + activity.price);
    double amount = previousValue + activity.price;
    myTrip?.amount = amount;
    return amount;

    });
  }
/*
  void setStatut(List<Activity> activities, id){
    Activity activity = activities.firstWhere((activity) => activity.id == id);
    activity.activityStatut = ActivityStatut.onGoig;
  }

 */

  //permet  de mettre à jour l'idex du widget sur le quel on a tapé
  void switchIndex(newIndex){
      setState(() {
        index = newIndex;
      });


  }

  void setCityName(City city){
       setState(() {
         myTrip?.city = city.name ;
       });


  }

  void setActivitiesStatut(BuildContext context){
    Provider.of<TripProvider>(context, listen: false).setActivitiesStatut(myTrip!);
  }

  //permet d'ajouter ou d'enlever une activité dans la liste des activité séléctionné
  void toggleActivity(Activity activity) {

      //si l'id de l'activité est présent nous allons le supprimé quand on tape dessus
      //sinon on l'ajoute
    setState(() {
      myTrip!.activitiesId.contains(activity.id) ?
      myTrip?.activitiesId.remove(activity.id) :
      myTrip?.activitiesId.add(activity.id);
    });


   // print(myTrip.activities);
  }

  // nous fournit la liste des activités séléctionnées(cochées);
  //where() -> nous permet de cibler les activuités dont les id sont présent dans le tableaux myTrip.activities
  //        -> return un itterable -> converti en list(toList)
 /*
  List<Activity>  getSelectedActivities( ) {
    return myTrip.activitiesId.map((activitiesId) {
      getActivities().where((acivity) => acivity.id == activitiesId).toList();
    }).toList()
    ;
  }

  */

  void deleteActivity(Activity activity){
      setState(() {
        myTrip?.activitiesId.remove(activity.id);
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
              myTrip?.date = newDate!;
              isDateSet = true;
            });


    });

  }

  void saveDialog(City city) async {
    //showDialog() ->methode qui permet de creer des fenetre de dialogue(ou pop up ou modal)
    //             -> positionne ce dernier en haut du stack du fenetre de navigation
    //             -> return un Future(promesse) -> qui est le résultat de la réponse -> enregistrer avec le Naviagator.pop()
    final String result = await showDialog(
        context: context,
        builder: (context) {
          //SimpleDialog() -> widget qui permet de mettre en place un pop up
          return SimpleDialog(
            title: Text("Voulez vous enregistrer ?"),
            contentPadding: EdgeInsets.all(20.0),
            //permte de créer un bordure et de la personnaliser
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.black45,
                  width: 1.0
                ),
                borderRadius: BorderRadius.circular(10)),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: Text("Sauvegarder"),
                    style: ElevatedButton.styleFrom(
                      primary: index == 0 ? Colors.blue : Colors.grey,
                    ),
                    //Navigator.pop() -> ferme la fenetre et retourne  la réponse comme  promesse -> qui sera retourné par showDialog()
                    onPressed: () => Navigator.pop(context, "save"),

                  ),
                  ElevatedButton(
                    child: Text("Annuler"),
                    style: ElevatedButton.styleFrom(
                      primary: index == 0 ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () => Navigator.pop(context, "annuler"),
                  )
                ],
              )
            ],
          );
        });
    //print(result);
    if(result == "save"){
      if(myTrip?.date == null) {
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("attention !"),
                titleTextStyle: TextStyle(color: Colors.red[900], fontSize: 20.0),
                content: Text("Vous n'avez pas choisi une date "),
                actions: [
                  ElevatedButton(
                      child: Text("OK", style: TextStyle(fontSize: 15.0),),
                      onPressed:()=> Navigator.pop(context))],
              );
            }
        );
      }else{
        setCityName(city);
        setActivitiesStatut(context);
     // Provider.of<TripProvider>(context).addTrip(myTrip);
        myTrip?.uId = Provider.of<AppUser>(context, listen: false).uid;
        Provider.of<TripProvider>(context, listen: false).saveTrip(myTrip?.toJson()).then((value) {myTrip?.id = value.toString();});
      Navigator.pushNamed(context, "/");
    }
    }

  }

  //getter qui permet de récuperer le prix d'une activité séléctionner


  @override
  Widget build(BuildContext context) {
    //ModalRoute.of(context).settings.arguments
    //   -> permet de recuperer l'argument passé à notre fonction de redirection dans city_card
     //String cityName = ModalRoute.of(context).settings.arguments;
    // getCityByName() ->
  //   City city = getCityByName(cityName);

   // print(city);
    //on peut aussi commme pour didChangeDependencies() acceder aux données de notre inheritedWidget DataWidget
    //  -> directement dans notre méthode build -> on a acces au context
    //activities = DataWidget.of(context).activities;
    return  Scaffold(
      appBar: AppBar(

        title: Text("Organisation de voyage"),
        actions: [Icon(Icons.more_vert)],
      ),
      drawer: MyDrawer(),
      body: Container(
        //widget -> parceque notre méthode est placée dans la classe widget
        child: FutureBuilder(
            future: Provider.of<CityProvider>(context).getProCityActivities(city.name),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              List<Activity> activities2 = [];
              if (snapshot.hasData) {
                snapshot.data?.docs.forEach((doc) {
                  var docu = doc.data() as Map<String, dynamic>;
                  Activity activity = Activity.fromJson(docu, doc.id);
                  activity.id = doc.id;
                  activities2.add(
                      activity
                  );
                });
              }
              return widget.showContent(
              context: context,
              children: [
    TripOverview(cityName : city.name, setDate: setDate, trip: myTrip, amount: getAmount(city, activities2), isDateSet: isDateSet),
    //on wrap le Gridview.builder() -> pour qu'il prenne tout l'espace restant disponible
    // -> sinon il va vouloir prendre tout l'espace du widget parent et proqué un bug
    Expanded(
    child:  index == 0
    ? ActivityList(activities: activities2.where((activity) => activity.city == city.name).toList(),
    toggleActivity: toggleActivity,
    selectedActivities: myTrip.activitiesId)
        : TripActivityList(activities: activities2.where((activity) => activity.city == city.name).toList(),
    selectedActivities: myTrip.activitiesId,
    deleteActivity: deleteActivity)

    )]
    );  })
     /*
  */


      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        //fait appel à la fonction saveDialog()
        onPressed:() {

          WidgetsBinding.instance.addPostFrameCallback((_){
            saveDialog(city);
          });
        }
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
