import 'package:flutter/material.dart';
import 'package:flutter_app/dataBase/CityRepo.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/views/trip/trip_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TripList extends StatelessWidget {

  final List<Trip> trips;


   TripList({ required this.trips}) : super();

  Future<City> loadCity(String cityName, BuildContext context) async {
    City city = await Provider.of<CityProvider>(context, listen: false).getCityByName(cityName);
    if (city != null) {
      print("Loaded city: ${city.name}");
      return city;
    } else {
      print("City not found");
    }
    return city;
  }

  @override
  Widget build(BuildContext context) {
   // List<City> cities = Provider.of<CityProvider>(context).cities;

    return ListView.builder(
      itemCount: trips.length ,
      itemBuilder: (context, index){
       // City city = CityRepo().getCityByName(trips[index].city);
        return trips[index].date.isBefore(DateTime.now()) ? ListTile(

          title: Text(trips[index].city, style: TextStyle(color: Colors.grey),),
          subtitle: trips[index].date != null ?
          Text(DateFormat("d/M/y").format(trips[index].date),style: TextStyle(color: Colors.grey))
              : Text("date pas encore définie"),
          onTap: () => {
           // Navigator.pushNamed(context, TripView.routeName, arguments: {"trip" : trips[index], "city": loadCity(trips[index].city)})
          } ,
          /*trailing: IconButton(
            icon: Icon(Icons.info),
          onPressed: ()async {
              City city = await  loadCity(trips[index].city, context);
              Navigator.pushNamed(context, TripView.routeName, arguments: {"trip" : trips[index], "city": city});
          },)
          ,
           */
        ) : ListTile(

          title: Text(trips[index].city,),
          subtitle: trips[index].date != null ?
          Text(DateFormat("d/M/y").format(trips[index].date),)
              : Text("date pas encore définie"),
          onTap: ()async {
            City city = await  loadCity(trips[index].city, context);
            Navigator.pushNamed(context, TripView.routeName, arguments: {"trip" : trips[index], "city": city});
          } ,
          trailing: IconButton(
            icon: Icon(Icons.info),
          onPressed: ()async {
              City city = await  loadCity(trips[index].city, context);
              Navigator.pushNamed(context, TripView.routeName, arguments: {"trip" : trips[index], "city": city});
          },)
          ,

        );
      },
    );
  }
}
