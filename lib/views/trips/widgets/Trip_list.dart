import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/views/trip/trip_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TripList extends StatelessWidget {

  final List<Trip> trips;


   TripList({Key key, this.trips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // List<City> cities = Provider.of<CityProvider>(context).cities;

    return ListView.builder(
      itemCount: trips.length ,
      itemBuilder: (context, index){
        City city = Provider.of<CityProvider>(context).getCityByName(trips[index].city);
        return ListTile(

          title: Text(trips[index].city),
          subtitle: trips[index].date != null ? Text(DateFormat("d/M/y").format(trips[index].date)) : Text("date pas encore définie"),
          onTap: () => Navigator.pushNamed(context, TripView.routeName, arguments: {"trip" : trips[index], "city": city}) ,
          trailing: IconButton(
            icon: Icon(Icons.info)),
        );
      },
    );
  }
}
