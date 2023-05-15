import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dataBase/CityRepo.dart';
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
  Future<QuerySnapshot> _citiesSnap;

  @override
  initState() {
    super.initState();
     //_citiesSnap = Provider.of<CityProvider>(context).citiesSnap;
    _citiesSnap = FirebaseFirestore.instance.collection('cities').get();
  }

  // Dans le cas d'un statefullwidget -> la méthode build se trouve dans
  //la classe d'etat
  @override
  Widget build(BuildContext context) {
    //final cities = Provider.of<CityProvider>(context).cities;
    //final cities =  CityRepo().myCities();
    return     Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.home),
          title: Text("Boguis App"),
          actions: [IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async => await AuthenticationService().signOut(),
          )],
        ),
        drawer: MyDrawer(),
        body:SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: _citiesSnap,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  List<Widget> _citiesWidget = List<Widget>();
                  if (snapshot.hasData) {
                    snapshot.data.docs.forEach((doc) {
                      City city = City.fromJson(doc.data());
                      city.id = doc.id;
                      _citiesWidget.add(
                          City_card(city : city)
                      );
                    });
                  } else {
                    _citiesWidget.add(Text('loading'));
                  }
                  return Column(
                    children: _citiesWidget,
                  );
                },
              )
          ),
        )
    );
    /*
      Scaffold(
      appBar: AppBar(
       // leading: Icon(Icons.home),
        title: Text("Boguis App"),
        actions: [IconButton(
           icon: Icon(Icons.logout),
          onPressed: () async => await AuthenticationService().signOut(),
        )],
      ),
      drawer: MyDrawer(),
      body:SingleChildScrollView(
        child: Container(
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
      )
    )
      */

      /*

    */


    ;
  }
}

