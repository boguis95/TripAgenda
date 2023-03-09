import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/views/trips/widgets/Trip_list.dart';

class TripsView extends StatefulWidget {
  final List<Trip> trips;
  final List<City> cities;

  const TripsView({Key key, this.trips, this.cities}) : super(key: key);
  static const String routeName = "/trips";

  @override
  _TripsViewState createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  @override
  Widget build(BuildContext context) {
   final List<Trip> pastTrips = widget.trips.where((trip) => trip.date.isBefore(DateTime.now())).toList();
   final List<Trip> futureTrips = widget.trips.where((trip) => trip.date.isAfter(DateTime.now())).toList();

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
             TripList(trips: futureTrips, cities: cities),
             TripList(trips: pastTrips,)
      ],
        )
        ,
      ) ,
    );
  }
}
