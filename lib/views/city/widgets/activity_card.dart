import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity.modele.dart';

class Activity_card extends StatelessWidget {

  final Activity activity;

 Activity_card({ this.activity});

  @override
  Widget build(BuildContext context) {
    return (
      //margin: EdgeInsets.only(bottom: 10.0),
      Container(
        //double.infinity -> helper -> permet de prendre la plus grande largeur possible
        width: double.infinity,
        child: Image.asset(
          activity.image,
           fit: BoxFit.cover,),
      )
    );
  }
}
