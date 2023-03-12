import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/providers/TripProvider.dart';
import 'package:flutter_app/views/trips/widgets/Trip_list.dart';
import 'package:provider/provider.dart';

class TripsView extends StatelessWidget {

  static const String routeName = "/trips";


  @override
  Widget build(BuildContext context) {
   // List<Trip> trips = Provider.of<TripProvider>(context).trips;

   final List<Trip> pastTrips = Provider.of<TripProvider>(context).getPastTrips();
   final List<Trip> futureTrips = Provider.of<TripProvider>(context).getFutureTrips();

    return DefaultTabController(
      length: 2,
      child:    Scaffold(
        appBar: AppBar(
          title: Text("Mes voyages"),
          bottom: TabBar(
            labelColor: Colors.white70,
            labelStyle: TextStyle(fontSize: 18.0) ,
            unselectedLabelColor: Colors.black,
            indicatorPadding: EdgeInsets.all(3.0),
            indicatorColor: Colors.black45,
            indicatorWeight: 5.0,
            tabs:<Widget>[
              Tab(text: "A venir"),
              Tab(text: "Passés")],
          ),),
        body: TabBarView(
          children: [
             TripList(trips: futureTrips),
             TripList(trips: pastTrips,)
      ],
        )
        ,
      ) ,
    );
  }
}
