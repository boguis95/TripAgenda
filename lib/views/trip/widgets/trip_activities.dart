import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/providers/TripProvider.dart';
import 'package:flutter_app/views/trip/widgets/trip_activities_list.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TripActivities extends StatefulWidget {

  List<Activity> activities;
  Trip trip;


  TripActivities({ required this.activities, required this.trip}) : super();
  @override
  _TripActivitiesState createState() => _TripActivitiesState();
}

class _TripActivitiesState extends State<TripActivities> {

  late List<Activity> activities;
  late Trip trip;

  void settripState() {
    setState(() {
      trip = widget.trip;
      activities = widget.activities;
    });

  }




  void setActivityToDown(String activityId) async{
    setState(()  {

      trip.activitiesIdByStatut[ActivityIdStatut.onGoing]?.remove(activityId);
      trip.activitiesIdByStatut[ActivityIdStatut.done]?.add(activityId);


      Activity activity = activities.firstWhere((activity) => activity.id == activityId);
      activities.remove(activity);

    });

    String id = trip.id;
    print("id-tripactivities-list : "+id.toString());
    //print(id);
    await Provider.of<TripProvider>(context).updateActivityStatus(id, activityId);

  }


  Widget build(BuildContext context) {
    settripState();
    print("build TripActivities - activityStatutOngoing : "+widget.trip.activitiesIdByStatut[ActivityIdStatut.onGoing]!.length.toString());
    print("build TripActivities : " + widget.activities.length.toString());
    print("build TripActivities-tripId : "+widget.trip.id.toString());

    return  Container(
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
              child:  widget.activities.length == 0 ? Center(child: CircularProgressIndicator(),): TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TripActivitiesList(activities: activities.where((activity) => trip.activitiesIdByStatut[ActivityIdStatut.onGoing]!.contains(activity.id)).toList(),
                                 filter : ActivityIdStatut.onGoing, trip: trip, setActivityToDown: setActivityToDown),
                  TripActivitiesList(activities: activities.where((activity) => trip.activitiesIdByStatut[ActivityIdStatut.done]!.contains(activity.id)).toList(),
                                     filter : ActivityIdStatut.done, setActivityToDown: setActivityToDown, trip: trip,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
