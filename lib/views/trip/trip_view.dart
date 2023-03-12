import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/views/trip/widgets/trip_activities.dart';

class TripView extends StatelessWidget {

  static const String routeName = "/trip_view";


  @override
  Widget build(BuildContext context) {
     City city =  (ModalRoute.of(context).settings.arguments as Map<String, Object>)["city"];
     Trip trip = (ModalRoute.of(context).settings.arguments as Map<String, Object>)["trip"];
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(city.image,
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
              TripActivities(activities: trip.activities,)
            ],
          ),

      ),
    );
  }
}
