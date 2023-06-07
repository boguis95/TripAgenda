import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/Activity_modele.dart';

class ActivityCard extends StatelessWidget {

  final Activity activity;
  final bool isSelected;
  final Function toggleActivity;


 ActivityCard({ required this.activity, required this.isSelected, required this.toggleActivity});

  @override
  Widget build(BuildContext context) {
    return (
      //margin: EdgeInsets.only(bottom: 10.0),
      Container(
        //double.infinity -> helper -> permet de prendre la plus grande largeur possible
        width: double.infinity,
        child: Stack(
          children: [
            Ink.image(
              image: NetworkImage(activity.image),
              fit: BoxFit.cover,
              child: InkWell(
                onTap:  () {
                  // Wrap the toggleActivity call inside addPostFrameCallback
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    toggleActivity();
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       if(isSelected) Icon(
                           Icons.check,
                           size: 40.0,
                           color: Colors.white,)
                      ],
                    ),

                  ),
                  Row(children: [
                    Flexible(
                      child: Text(activity.name,
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    )
               ]
                    ,)
                ],
              ),
            )
          ],
        )

     ,
      )
    );
  }
}
