import 'package:flutter/cupertino.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';

import 'activity_card.dart';

class ActivityList extends StatelessWidget {
 final List<Activity> activities;
 final Function toggleActivity;
 //ne contient que les id des activités séléctionnées qui sont des string
 final List<String> selectedActivities;

  const ActivityList({ this.activities, this.toggleActivity, this.selectedActivities}) ;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(


      //construit les éléments que lorsqu'ils apparaissent à l'écran et les détruisent lorsqu'ils n'apparaissent plus
      // ->ListView.builder() plus performant que Lisview()
      // NB: Listview.separated() -> fonction de la meme maniere que ListView.builder()
      //    -> mais prend une propriété separatorBuilder -> qui prend en valeur un Divider() ou un SizedBox()
      //                                                 -> séparant les items
      // separatorBuilder -> prend une fonction idéntique à celle de itemBuilder et retourne le séparateur( Divider() ou un SizedBox())
      itemBuilder: (context, index){
        return ActivityCard(activity: activities[index],
                             //activities[index].id -> id de l'activity sur le quel on est placé
                             isSelected: selectedActivities.contains(activities[index].id),
                             toggleActivity: () {
                              toggleActivity(activities[index]);
                             });
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 5.0),
      //itemCount -> nombre de fois la fonction passée à itemBuilder doit etre invoqué
      itemCount: activities.length,
    );
  }
}
