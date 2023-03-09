import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';

class TripActivitiesList extends StatelessWidget {
 final List<Activity> activities;
  const TripActivitiesList({Key key, this.activities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: activities.length ,
        itemBuilder: (context, i){
          //Dismissible permet de valider une activité réalisé comme dans le cas de l'archivage des email avec gmail
          // en le poussant vers un coté
          // elle prend forcément un key qui doit etre unique
          return Dismissible(
            key: ValueKey(activities[i].id) ,
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
            onDismissed: (_){
              print("dismised");
            },
          ) ;
        },
      ),
    );
  }
}
