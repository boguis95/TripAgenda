import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/providers/TripProvider.dart';
import 'package:flutter_app/views/trip/widgets/trip_activities_list.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TripActivities extends StatelessWidget {

  List<Activity> activities;
  Trip trip;

   TripActivities({Key key, this.activities, this.trip}) : super(key: key);


  void setActivityToDown(BuildContext context,String activityId){

    // activity.activityStatut = ActivityStatut.done;
    trip.activitiesIdByStatut[ActivityIdStatut.onGoing].remove(activityId);
    trip.activitiesIdByStatut[ActivityIdStatut.done].remove(activityId);

    String id = Provider.of<TripProvider>(context).id;
    print(id);
    Provider.of<TripProvider>(context).updateActivityStatus(id, activityId);

  }


  Widget build(BuildContext context) {
    print("build TripActivities - activityStatutOngoing"+trip.activitiesIdByStatut[ActivityIdStatut.onGoing].length.toString());
    print("build TripActivities : "+activities.length.toString());
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              child: TabBar(
                indicatorPadding: EdgeInsets.all(3.0),
                indicatorWeight: 5.0,
                indicatorColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.green[800] ,
                tabs: [
                  Tab(text: "En cours",),
                  Tab(text: "Terminés",)
                ],
              ),
            ),
            Container(
              height: 600.0,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TripActivitiesList(activities: activities.where((activity) => trip.activitiesIdByStatut[ActivityIdStatut.onGoing].contains(activity.id)).toList(),
                                 filter : ActivityIdStatut.onGoing, trip: trip, setActivityToDown: setActivityToDown),
                  TripActivitiesList(activities: activities.where((activity) => trip.activitiesIdByStatut[ActivityIdStatut.done].contains(activity.id)).toList(),
                                     filter : ActivityIdStatut.done)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
