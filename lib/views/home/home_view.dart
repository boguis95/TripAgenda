import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/servicies/Authenytication.dart';
import 'package:flutter_app/views/home/widgets/city_card.dart';
import 'package:flutter_app/widget_utils/MyDrawer.dart';
import 'package:provider/provider.dart';



class HomeView extends StatefulWidget {

  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();

}

// Les donnée vont se gerer dans la classe d'etat
class _HomeViewState extends State<HomeView> {



  // Dans le cas d'un statefullwidget -> la méthode build se trouve dans
  //la classe d'etat
  @override
  Widget build(BuildContext context) {
    List<City> cities = Provider.of<CityProvider>(context).cities;
    return Scaffold(
      appBar: AppBar(
       // leading: Icon(Icons.home),
        title: Text("Boguis App"),
        actions: [IconButton(
           icon: Icon(Icons.logout),
          onPressed: () async => await AuthenticationService().signOut(),
        )],
      ),
      drawer: MyDrawer(),
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

