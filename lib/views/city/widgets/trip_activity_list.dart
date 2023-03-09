import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';

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
                  //Scaffold.of(context) -> permet de recuperer le Scaffold(Vue) le plus proche dans notre arbe de widget
                  //                            -> la ou on va afficher notre snackbar
                  // les .. permet  d'appeller sur un meme objet plusieurs méthodes
                  // removeCurrentSnackBar() et showSnackBar() sont tous les deux appelé sur ScaffoldMessenger.of(context)
                  // removeCurrentSnackBar() -> permet de supprimer le snackbar actuel -> permet affichage fluide en cas de suppression de plusieurs éléments en meme temps
                  ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                    SnackBar(
                      //padding: EdgeInsets.all(30.0),
                      //pour définir un padding ou un margin -> il faut préciser un behavior: SnackBarBehavior.floating
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20.0),
                      content: Text("Activité supprimée"),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                    )
                  );
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
