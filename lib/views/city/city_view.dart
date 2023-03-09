

import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/City_modele.dart';

import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/views/city/widgets/activity_card.dart';
import 'package:flutter_app/views/city/widgets/activity_list.dart';
import 'package:flutter_app/views/city/widgets/tripOverview.dart';
import 'package:flutter_app/views/city/widgets/trip_activity_list.dart';
import 'package:flutter_app/widget_utils/DataWidget.dart';
import 'package:flutter_app/widget_utils/MyDrawer.dart';
import 'package:intl/intl.dart';



// ignore: must_be_immutable
class CityView extends StatefulWidget {

  final City city;
  final Function addTrip;
  //la liste des activités n'est pas appelé à etre modifié puisqu'il est installé en dur
  //tout ce qui est déclaré dans une classe widget est imutable

  static const String routeName = "/city";

   CityView({ this.city, this.addTrip}) ;

   List<Activity> get activities {
     return city.activities;
   }


   showContent({BuildContext context, List<Widget> children}) {
    //Ici On recupere l'orientation de l'écran à l'instant t (landscape -> sur la largeur, portrait -> sur la longueur
    //  -> grace à l'inheritidet natif MediaQuery
    final orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.landscape){
     return Row(
       //on veut que notre Row() prend toute la hauteur  disponible
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: children,);
    }else{
     return Column(children: children,);
    }
  }

  @override
  _CityViewState createState() => _CityViewState();
}

class _CityViewState extends State<CityView> {

  //List<Activity> activities;
  Trip myTrip;
  int index;



  //initState permet d'initialiser notre state
  //fourni les données initiales qui pourront etre mis à jour avec setState()
  @override
  void initState() {
    super.initState();
    myTrip = Trip(city: "", activities:[], date: null);
    index = 0;
  }

  //permet d'écouter les changement des donné du widget parent(inherited widget)
  //les changement lui sont notifié par la méthode updateShouldNotify() de l'inheritedWidget
  // -> entraine un rebuild du widget s'il ya modification du parent
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //on fait appel à la méthode static of() de l'inheritWidget DataWidget
    // of() return context.dependOnInheritedWidgetOfExactType<DataWidget>() -> qui permet d'acceder aux données dans l'inheritWidget DataWidget
    //activities = DataWidget.of(context).activities;

  }

  double get amount {
    //fold -> nous permet d'incrémenter une valeur initialement fournit
    //0.0 -> valeur initiale
    //previously -> valeur précedant
    //firtWhere() -> l'incrémentation se fera si l'activité en question verifie la condition
    //               -> si son id est présent dans la lites des id des activités séléctionnées
    //            -> on a également une décrémentation quand la condition n'est plus verifié
    return myTrip.activities.fold(0.0, (previousValue, element){
    Activity activity = widget.activities.firstWhere((activity) => activity == element);

    //reviousValue + activity.price -> donnera une nouvelle valeur à la valeur initiale
    //on retourne la valeur la plus récente
    //print(previousValue + activity.price);
    return (previousValue + activity.price);

    });
  }

  //permet  de mettre à jour l'idex du widget sur le quel on a tapé
  void switchIndex(newIndex){
    setState(() {
      index = newIndex;
    });
  }

  void setCityName(){
    setState(() {
      myTrip.city = widget.city.name ;
    });
  }

  //permet d'ajouter ou d'enlever une activité dans la liste des activité séléctionné
  void toggleActivity(Activity activity) {
    setState(() {
      //si l'id de l'activité est présent nous allons le supprimé quand on tape dessus
      //sinon on l'ajoute
      myTrip.activities.contains(activity) ?
          myTrip.activities.remove(activity) :
          myTrip.activities.add(activity);
    });
   // print(myTrip.activities);
  }

  // nous fournit la liste des activités séléctionnées(cochées);
  //where() -> nous permet de cibler les activuités dont les id sont présent dans le tableaux myTrip.activities
  //        -> return un itterable -> converti en list(toList)
  List<Activity> get getSelectedActivities {
    return widget.activities;
  }

  void deleteActivity(Activity activity){
    setState(() {
      myTrip.activities.remove(activity);
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

  void saveDialog() async {
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
                  RaisedButton(
                    child: Text("Sauvegarder"),
                    color: Theme
                        .of(context)
                        .primaryColor,
                    //Navigator.pop() -> ferme la fenetre et retourne  la réponse comme  promesse -> qui sera retourné par showDialog()
                    onPressed: () => Navigator.pop(context, "save"),

                  ),
                  RaisedButton(
                    child: Text("Annuler"),
                    color: Colors.red,
                    onPressed: () => Navigator.pop(context, "annuler"),
                  )
                ],
              )
            ],
          );
        });
    //print(result);
    if(result == "save"){
      if(myTrip.date == null) {
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("attention !"),
                titleTextStyle: TextStyle(color: Colors.red[900], fontSize: 20.0),
                content: Text("Vous n'avez pas choisi une date "),
                actions: [
                  FlatButton(
                      child: Text("OK", style: TextStyle(fontSize: 15.0),),
                      onPressed:()=> Navigator.pop(context))],
              );
            }
        );
      }else{
      setCityName();
      widget.addTrip(myTrip);
      Navigator.pushNamed(context, "/");
    }
    }

  }

  //getter qui permet de récuperer le prix d'une activité séléctionner


  @override
  Widget build(BuildContext context) {
    //ModalRoute.of(context).settings.arguments
    //   -> permet de recuperer l'argument passé à notre fonction de redirection dans city_card
    //final City city = ModalRoute.of(context).settings.arguments;
   // print(city);
    //on peut aussi commme pour didChangeDependencies() acceder aux données de notre inheritedWidget DataWidget
    //  -> directement dans notre méthode build -> on a acces au context
    //activities = DataWidget.of(context).activities;
    return Scaffold(
      appBar: AppBar(

        title: Text("Organisation de voyage"),
        actions: [Icon(Icons.more_vert)],
      ),
      drawer: MyDrawer(),
      body: Container(
        //widget -> parceque notre méthode est placée dans la classe widget
        child: widget.showContent(
            context: context,
            children: [
              TripOverview(cityName : widget.city.name, setDate: setDate, trip: myTrip, amount: amount,),
              //on wrap le Gridview.builder() -> pour qu'il prenne tout l'espace restant disponible
              // -> sinon il va vouloir prendre tout l'espace du widget parent et proqué un bug
              Expanded(
                child: index == 0
                    ? ActivityList(activities: widget.activities,
                    toggleActivity: toggleActivity,
                    selectedActivities: myTrip.activities)
                    : TripActivityList(selectedActivities: getSelectedActivities,
                    deleteActivity: deleteActivity),
              )
            ] ),


      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        //fait appel à la fonction saveDialog()
        onPressed: saveDialog,
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
