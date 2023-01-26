import 'package:flutter/material.dart';
import 'package:flutter_app/views/home/widgets/city_card.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

// Les donnée vont se gerer dans la classe d'etat
class _HomeState extends State<Home> {

  List cities = [
    { "name": "Paris", "image": "assets/Paris.jpg", "checked": false},
    { "name": "Lyon", "image": "assets/lyon.jpg", "checked": false},
    { "name": "Nice", "image": "assets/Nice.jpg", "checked": false},
  ];

  void  switchCheck(city) {
    int index = cities.indexOf(city);
    setState(() {
      cities[index]["checked"] = !cities[index]["checked"];
    });

  }

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
             return City_card(name: city["name"], image: city["image"], isChecked: city["checked"], updateCheck: () => switchCheck(city),);
            })
            //il faut fournir un container au card pour pouvoir lui fournir les dimension voulues
           ,

          ],
        ),
      ),
    );
  }
}

