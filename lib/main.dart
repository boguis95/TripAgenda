import 'package:flutter/material.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/views/city/city_view.dart';
import 'package:flutter_app/views/trip/trip_view.dart';
import 'package:flutter_app/views/trips/trips_view.dart';
import 'package:flutter_app/widget_utils/404.dart';
import 'package:flutter_app/widget_utils/DataWidget.dart';
import 'package:provider/provider.dart';
import 'modeles/City_modele.dart';
import 'modeles/Trip_modele.dart';
import 'views/home/home_view.dart';
import 'package:flutter_app/data/data.dart' as data;

void main(){
  // quand on utilise les inherithed widgets -> on enveloppe notre widget main par ce dernier
  //DataWidget(child: MyApp())
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  //final List<City> cities = data.cities;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 final List<Trip> trips = [];

 void addTrip(Trip trip) {
   setState(() {
     trips.add(trip);
   });
 }

  @override
  Widget build(BuildContext context) {
   //ChangeNotifierProvider -> un des objet de privider qui permet de notifier une mise à jour de données du provider au widgets qui consomment ces données
    return ChangeNotifierProvider(
        create: (BuildContext context){
          return CityProvider();
        },
        child:   MaterialApp(
          //ThemeData est un inheritWidget natif -> appliquer des crateistique à tout l'application
          theme: ThemeData(
            //primarySwatch -> permet d'appliquer aléatoirement des gradiants de la couleur à notre application
              primarySwatch: Colors.lightGreen
          ),
          debugShowCheckedModeBanner: false,
          //On enveloppe notre Widget City() par l'inheritWidget DataWidget
          //   -> permet aux widgets enfants d'acceder au données placées dans l'inheritWidget grace au context
          home: HomeView(),
          /*     routes: {
          '/city' : (context) {
            return CityView();
    }
        },*/
          //on utilise le ongerateRoute parcequ'on voudrait passer des arguments qui modifieront les voyages selon la liste de l'utilisateur
          /*    onGenerateRoute: (settings){
            switch(settings.name){
              case TripsView.routeName :{
                return MaterialPageRoute(
                    builder: (context){
                      return TripsView(trips: trips, cities: widget.cities,);
                    }
                  // ignore: missing_return, missing_return
                );
              }
              case CityView.routeName : { // ignore: missing_return
              return MaterialPageRoute(
                  builder: (context){
              final City city = settings.arguments;
                  return CityView(city: city, addTrip: addTrip);
    }
    // ignore: missing_return, missing_return
    );
    }
              case TripView.routeName : {
                return MaterialPageRoute(
                  builder: (context){
                    final Trip trip = (settings.arguments as Map<String, Object>)["trip"];
                    final City city = (settings.arguments as Map<String, Object>)["city"];
                    return TripView(trip: trip, city: city);
                  }
                );
              }
              }

            },
*/
          onUnknownRoute: (settings) =>  MaterialPageRoute(builder: (context) {
            return NotFoundRoute();
          }),
          //home: DataWidget(child: CityView(),) ,
        )
    );

  }


}

