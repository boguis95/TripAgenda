import 'package:flutter/material.dart';

class NotFoundRoute extends StatelessWidget {
  const NotFoundRoute() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Oops route not found"),
            ElevatedButton(
              child: Text("Page d'accueil"),
              onPressed: () => Navigator.pushNamed(context, "/"),

            )
          ],
        ) ,

      ),

    );
  }
}
