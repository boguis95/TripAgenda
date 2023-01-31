import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity.modele.dart';

class TripActivityList extends StatelessWidget {

  List<Activity> selectedActivities;
  final Function deleteActivity;

TripActivityList({this.selectedActivities, this.deleteActivity});
  @override
  Widget build(BuildContext context) {
    return Container(
      //ListView() va permettre de scroller quand on a un nombre d'élément qui dépasse l'écran
      //   -> contrairement au column
      //   -> mais pas très performant lorsque l'on a un grand nombre d'éléments
      child: ListView.builder(
        itemBuilder: (context, index) {
          var activity = selectedActivities[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage(activity.image) ,
              ),
              title: Text(activity.name),
              subtitle: Text(activity.city),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  deleteActivity(activity.id);
                },
              ),
            )
            ,) ;
        },
        itemCount: selectedActivities.length,
      ),
    );

  }
}
