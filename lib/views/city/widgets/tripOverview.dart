import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:intl/intl.dart';

class TripOverview extends StatelessWidget {

  final Function setDate;

  final Trip trip;
  final String cityName;
  final double amount;
  final bool isDateSet;


  const TripOverview({ required this.setDate, required this.trip, required this.cityName, required this.amount, required this.isDateSet}) ;



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      // pour gerer la largeur du widget avec l'affichage en landscape.
      //double.infinity -> permet de prendre tout l'espace disponible en mode portrait(affichage en longueur)
      //                -> on pouvait le remplacer par size.width -> pour prendre toute la largeur
        width: orientation == Orientation.landscape ? size.width * 0.5 : double.infinity,
        padding: EdgeInsets.all(5.0),
        height: 200.0,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // on affiche le nom de la ville sur la quelle on a cliqué dans la liste des ville
              cityName,
              style: TextStyle(
                  fontSize: 25.0, decoration: TextDecoration.underline
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                // Ici Expanded va s'appliquer que sur l'horizontale
                Expanded(
                  child: Text(
                    //DateFormat() -> formater la date avec le modèle qu'on lui a fourni
                    isDateSet == true ? DateFormat("d/M/y").format(trip.date)
                        : "Choisissez une date",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text("Sélectionner une date"),
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_){
                      setDate();
                    });

                  }
                )
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                //on récupere la valeur retournée par le getter amount en précisant juste le nom
                //On échappe le $
                Expanded(
                    child: Text(
                      "Montant / personne : ",
                      style: TextStyle(fontSize: 20.0),)
                ),

                Text(" $amount \$",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )

              ],
            )
          ],
        )
    );
  }
}
