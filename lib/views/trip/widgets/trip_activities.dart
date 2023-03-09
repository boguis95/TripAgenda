import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/views/trip/widgets/trip_activities_list.dart';

class TripActivities extends StatelessWidget {

  List<Activity> activities;

   TripActivities({Key key, this.activities}) : super(key: key);

  Widget build(BuildContext context) {
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
                  TripActivitiesList(activities : activities),
                  TripActivitiesList(activities: activities,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
