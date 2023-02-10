//InheritedWidget -> qui permet de faire passer de la data grace à l'utilisation du context
//                -> aux  widgets enfants

import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/data/data.dart' as data;

class DataWidget extends InheritedWidget {

  final List<Activity> activities = data.activities;
  //le constructeur prend toujours une propriété child de type Widget
  //doit aussi appellé celle du parent
   DataWidget({
    @required Widget child,
  })  : assert(child != null),
        super(child: child);

  //permet d'acceder directement aux données à partir du context
  static DataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataWidget>();
  }

  //permet de notifier la modifications des données du enheritWidget aux widgets enfants
  //pour qu'il puisse rebuild quand elle return true
  // s'il return false -> les enfants ne rebuild pas
  @override
  bool updateShouldNotify(DataWidget old) {
    return true;
  }
}