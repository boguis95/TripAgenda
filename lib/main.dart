import 'package:flutter/material.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/providers/TripProvider.dart';
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





  @override
  Widget build(BuildContext context) {

   //Mutiprovider -> permet de brancher plusieurs providers
    //ChangeNotifierProvider -> permet de notifier aux widegt qui consomme la données une mise à jour de ladonnée pour qu'ils puissent rebuild
    //Vu qu'on utilise pas le context -> on peut directement utiliser le constructeur nommé ChangeNotifierProvider.value de ChangeNotifierProvider
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: CityProvider()),
          ChangeNotifierProvider.value(value: TripProvider())
        ],
      child:  MaterialApp(
        //ThemeData est un inheritWidget natif -> appliquer des crateistique à tout l'application
        theme: ThemeData(
          //primarySwatch -> permet d'appliquer aléatoirement des gradiants de la couleur à notre application
            primarySwatch: Colors.lightGreen
        ),
        debugShowCheckedModeBanner: false,
        //On enveloppe notre Widget City() par l'inheritWidget DataWidget
        //   -> permet aux widgets enfants d'acceder au données placées dans l'inheritWidget grace au context
        home: HomeView(),
        routes: {
          CityView.routeName : (context) => CityView(),
          //on peut utiliser un _ à la place de context parcequ'on ne se sert pas de ce dernier
          TripView.routeName : (_) => TripView(),
          TripsView.routeName : (_) => TripsView()
        },
        onUnknownRoute: (settings) =>  MaterialPageRoute(builder: (context) => NotFoundRoute()),

      ),
    );

  }


}

