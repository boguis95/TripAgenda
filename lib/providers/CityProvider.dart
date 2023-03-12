
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/data/data.dart' as data;

//with ChangeNotifier est une mixin -> permet de notifier un changement de données au wideget à qui les données sont provides(fourni)
//                                  -> les widgets pourront rebuild
class CityProvider with ChangeNotifier{

  final List<City> _cities = data.cities;

  //UnmodifiableListView -> va empecher la modification des éléments de notre liste au niveau des widgets qui utilise les données
  //  -> les données ne peuvent etre modifier qu'au niveau du Provider
 UnmodifiableListView<City>  get cities {
    return UnmodifiableListView(_cities);
  }

  City getCityByName (String cityName) {
   return _cities.firstWhere((city) => city.name == cityName);
  }
}