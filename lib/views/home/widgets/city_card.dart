import 'package:flutter/material.dart';

class City_card extends StatelessWidget {

  //on utilise final et pas const -> parcequ'on va les instancieer au moment de l'invocation du constructeur
  final String name;
  final String image;
  final bool isChecked;
  final Function updateCheck;

  const City_card({ this.name, this.image, this.isChecked, this.updateCheck}) ;


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
                image
              ),
              child: InkWell(
                onTap: () => {
                  updateCheck()
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isChecked ? Icons.star_border : Icons.star ,
                          color: Colors.white,
                          size: 40.0,)
                      ],
                    ),
                  )

                  ,Row(
                    children: [
                      Text(name,
                        style: TextStyle(fontSize: 40.0, color: Colors.white),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
