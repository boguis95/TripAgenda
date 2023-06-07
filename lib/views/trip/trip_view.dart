import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dataBase/ActivityRepo.dart';
import 'package:flutter_app/dataBase/TripRepo.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/views/trip/widgets/trip_activities.dart';
import 'package:flutter_app/data/data.dart' as data;




    class TripView extends StatefulWidget {


      static const String routeName = "/trip_view";
    @override
    _State createState() => _State();
    }

    class _State extends State<TripView> {

  List<Activity> activities = [];
  late City city;
  late Trip trip;

@override
void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, Object?>;
      city = arguments["city"]! as City;
      trip = arguments["trip"]! as Trip;
    });

    getTripActivities(city.name, trip);
    //print(activities.length);
  }

  void tripActivitiesOngoing(){
  if(trip.activitiesIdByStatut != null){
    print("build tripView - activityStatutOngoing"+trip.activitiesIdByStatut[ActivityIdStatut.onGoing]!.length.toString());
  }

  }


 void getTripActivities(String cityName, Trip trip) async {

    List<Activity> value = await ActivityRepo().getActivities(cityName);
    value.forEach((element) {
      if (trip.activitiesId.contains(element.id)) {
        setState(() {
          activities.add(element);
        });

     //   print(activities.length);
      }
    });
  //  print(activities.length);

  }


  @override
  Widget build(BuildContext context) {
  //   City city =  (ModalRoute.of(context).settings.arguments as Map<String, Object>)["city"];
  //   Trip trip = (ModalRoute.of(context).settings.arguments as Map<String, Object>)["trip"];

     print("Build tripView : "+activities.length.toString());
     tripActivitiesOngoing();

     return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(city.image,
                      fit: BoxFit.cover,),
                    // Container(color:),
                    Container(
                      color: Colors.black26,
                      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),)
                            ],
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                              city.name,
                                style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white),),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              TripActivities(activities:activities, trip: trip)
            ],
          ),

      ),
    );
  }
}
