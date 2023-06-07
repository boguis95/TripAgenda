import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/providers/TripProvider.dart';
import 'package:provider/provider.dart';

class TripActivitiesList extends StatefulWidget {
   List<Activity> activities;
   ActivityIdStatut filter;
   Trip trip;
   Function setActivityToDown;

  TripActivitiesList({ required this.activities, required this.filter, required this.trip, required this.setActivityToDown}) : super();
  @override
  _TripActivitiesListState createState() => _TripActivitiesListState();
}
  


class _TripActivitiesListState extends State<TripActivitiesList> {
  late Trip trip;
  late List<Activity> activities;
  late List<Activity> activities2;

  void setActivityToDown(String activityId) async {
    setState(()  {
     trip = widget.trip;
   trip.activitiesIdByStatut[ActivityIdStatut.onGoing]?.remove(activityId);
   trip.activitiesIdByStatut[ActivityIdStatut.done]?.add(activityId);

      //activities = widget.activities;
     Activity activity = activities.firstWhere((activity) => activity.id == activityId);
      activities.remove(activity);


    });

    String id = trip.id;
    print("id-tripactivities-list : "+id.toString());
    //print(id);
    await Provider.of<TripProvider>(context, listen: false).updateActivityStatus(id, activityId);
  }

void doSetState(){
    setState(() {
      activities = widget.activities;
    });
}


  @override
  Widget build(BuildContext context) {
    doSetState();
    print("build TripActivitiesList : "+activities.length.toString());
    return  ListView.builder(
        itemCount: activities.length ,
        itemBuilder: (context, i){
          //Dismissible permet de valider une activité réalisé comme dans le cas de l'archivage des email avec gmail
          // en le poussant vers un coté
          // elle prend forcément un key qui doit etre unique
          return Container(
            child: widget.filter == ActivityIdStatut.onGoing ?
            Dismissible(
              key: ValueKey<String>(activities[i].id),
              //direction du dismised -> permet de définir une direction unique
              direction: DismissDirection.endToStart,
              child: Card(
                child:ListTile(
                  title: Text(activities[i].name),
                ),
              ) ,
              //background -> correspond au widget qui apparait lorqu'on dismiss l'élément
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Icon(Icons.check, size: 25.0, color: Colors.white,),
              ),
              //onDismissed-> fonction qui se déclenche lorsque l'on dismiss
              //parametre correspond à la direction de déclenchement sila direction n'était pas unique
              //ici on met un _ pour ignorer le parametre parceque la direction est unique
              onDismissed: (DismissDirection direction) async{
                //String id = Provider.of<TripProvider>(context).id;

                setActivityToDown(activities[i].id);
                setState(() {
                });
                print("dismised");
              },
            )
                :
            Card(
                child:ListTile(
                  title: Text(activities[i].name, style: TextStyle(color: Colors.grey[400]),),
                )
            ),
          );

        },
      );

  }
}
