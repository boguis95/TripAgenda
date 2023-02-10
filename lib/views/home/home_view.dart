import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/views/home/widgets/city_card.dart';



class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

// Les donnée vont se gerer dans la classe d'etat
class _HomeViewState extends State<HomeView> {

  List cities = [
   City(name: "Paris", image: "assets/Paris.jpg"),
   City(name: "Lyon", image: "assets/lyon.jpg"),
   City(name: "Nice", image: "assets/Nice.jpg")
  ];


  // Dans le cas d'un statefullwidget -> la méthode build se trouve dans
  //la classe d'etat
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text("Boguis App"),
        actions: [Icon(Icons.more_vert)],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //map() -> retourne un array de widget City -> on utilise l'operateur spreed pour acceder aux widget
            ...cities.map((city){
             return City_card(city : city);
            })
            //il faut fournir un container au card pour pouvoir lui fournir les dimension voulues
           ,

          ],
        ),
      ),
    );
  }
}
