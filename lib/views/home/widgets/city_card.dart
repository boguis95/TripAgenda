import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/views/city/city_view.dart';

class City_card extends StatelessWidget {

  //on utilise final et pas const -> parcequ'on va les instancieer au moment de l'invocation du constructeur
 final City city;

  const City_card({ this.city}) ;


  @override
  Widget build(BuildContext context) {
    //Card prendra les dimension de son child
    return    Card(
      elevation: 5.0,
      child: Container(
        width: 500.0,
        height: 150.0,
        //permet de placer des élément en pile(les un en dessus des autre suivant la hierarchie)
        child: Stack(
          fit: StackFit.expand,
          children: [
            //Image.asset(
            //  'assets/Paris.jpg',
              // BoxFit.cover -> va faire que l'image prend l'intégralité de l'espace disponible sans le déformer
             // fit: BoxFit.cover,),
            //Ink.imagr -> permet d'utiliser Inkwell lorsqu'on a
            // a une image dans notre widget
            //InkWell -> permet d'avoir un effet de clique lorque l'utlisateur clique sur notre widget
            //        -> peut etre fournit comme child de la card en absence d'image
            Ink.image(
              fit: BoxFit.cover,
              image: AssetImage(
            // on lui passe directement la propriété image -> qui prendra sa valeur(passé au contructor)lors de l'utilisation du widget
                city.image
              ),
              child: InkWell(
                onTap: () => {
                  //Navigator.pushNamed() -> permet de faire une redirection
                  //                      -> on lui précise le context et le nom de la route défini dans le widget principal
                  Navigator.pushNamed(
                      context,
                      '/city',
                       //arguments: permet de gerer les parametres -> pour afficher la page avec les données correctes
                      //          -> prend un objet
                       //         -> ici on lui fourni l'instance de City en cours -> du city_card sur le quel on clique
                      //                                                           -> pour récuperer les données à afficher selon la ville
                       arguments: city)
                },
              ),
            ),
           //Positioned() -> permet de positionner nos éléments dans un endroit précis
            //            -> ici l'élément à positionner est notre container
           Positioned(
             left: 10.0,
             top: 5.0,
             child: Container(
               color: Colors.black45,
               padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
               child: Text(city.name,
               style: TextStyle(fontSize: 25.0, color: Colors.white),),
             ),


           )
          ],
        ),
      ),
    );
  }
}
