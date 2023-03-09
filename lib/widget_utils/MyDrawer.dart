import 'package:flutter/material.dart';
import 'package:flutter_app/views/trips/trips_view.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
                "My Drawer",
                style: TextStyle(color: Colors.white, fontSize: 30.0),),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.7)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight

              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Accueil"),
            onTap: () => Navigator.pushNamed(context, "/"),
          ),
          ListTile(
            leading: Icon(Icons.flight),
            title: Text("Voyage"),
            onTap: () => Navigator.pushNamed(context, TripsView.routeName),
          )
        ],
      ),
    );
  }
}
