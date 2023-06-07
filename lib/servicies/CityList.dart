import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/views/home/widgets/city_card.dart';
import 'package:provider/provider.dart';

class CityList extends StatefulWidget {
  const CityList() : super();

  @override
  _CityListState createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  @override
  Widget build(BuildContext context) {
   final cities = Provider.of<List<City>>(context, listen: false) ?? [];

   return Column(
     // crossAxisAlignment: CrossAxisAlignment.stretch,
     children: [
       //map() -> retourne un array de widget City -> on utilise l'operateur spreed pour acceder aux widget
       ...cities.map((city){
         return City_card(city : city);
       })
       //il faut fournir un container au card pour pouvoir lui fournir les dimension voulues
       ,

     ],
   );

}
}