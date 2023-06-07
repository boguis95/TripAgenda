import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/trips/trips_view.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer() : super();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50)
        ),
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                "Triplan",
                style: TextStyle(color: Colors.blueGrey[900], fontSize: 30.0),),

            ),
            Divider(
              color: Colors.grey,
              height: 2.0,
              thickness: 3.0,
            ),
            ListTile(
              leading: Icon(Icons.home,size: 30.0,color: Colors.black
                ,),
              title: Text("Accueil", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              onTap: () => Navigator.pushNamed(context, "/"),
            ),
            ListTile(
              leading: Icon(Icons.flight,
              size: 30.0,color: Colors.black
                ,),
              title: Text("Voyage", style: TextStyle(fontSize: 16, color: Colors.grey[600]
                ),),
              onTap: () => Navigator.pushNamed(context, TripsView.routeName),
            )
          ],
        ),
      )
      
    );
  }
}
