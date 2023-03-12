import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/providers/TripProvider.dart';
import 'package:provider/provider.dart';

class TripActivitiesList extends StatefulWidget {
  final List<Activity> activities;
  final ActivityStatut filter;

  TripActivitiesList({Key key, this.activities, this.filter}) : super(key: key);
  @override
  _TripActivitiesListState createState() => _TripActivitiesListState();
}
  


class _TripActivitiesListState extends State<TripActivitiesList> {

  void setActivityToDown(Activity activity){
    setState(() {
     // activity.activityStatut = ActivityStatut.done;
    Provider.of<TripProvider>(context).setActivityToDown(activity);
    });
   
  }


  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: widget.activities.length ,
        itemBuilder: (context, i){
          //Dismissible permet de valider une activité réalisé comme dans le cas de l'archivage des email avec gmail
          // en le poussant vers un coté
          // elle prend forcément un key qui doit etre unique
          return Container(
            child: widget.filter == ActivityStatut.onGoig ?
            Dismissible(
              key: ValueKey<String>(widget.activities[i].id),
              //direction du dismised -> permet de définir une direction unique
              direction: DismissDirection.endToStart,
              child: Card(
                child:ListTile(
                  title: Text(widget.activities[i].name),
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
              onDismissed: (DismissDirection direction){
                setActivityToDown(widget.activities[i]);
                print("dismised");
              },
            )
                : Card(
                child:ListTile(
                  title: Text(widget.activities[i].name, style: TextStyle(color: Colors.grey[400]),),
                )
            ),
          );

        },
      );

  }
}
