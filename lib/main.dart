import 'package:flutter/material.dart';
import 'package:flutter_app/views/city/city_view.dart';
import 'package:flutter_app/widget_utils/404.dart';
import 'package:flutter_app/widget_utils/DataWidget.dart';
import 'views/home/home_view.dart';

void main(){
  runApp(DataWidget(child: MyApp()) ,);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          '/city' : (context) {
            return CityView();
    }
        },
      onUnknownRoute: (settings) =>  MaterialPageRoute(builder: (context) {
        return NotFoundRoute();
      }),
      //home: DataWidget(child: CityView(),) ,
    );
  }
}

