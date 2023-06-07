import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/dataBase/CityRepo.dart';
import 'package:flutter_app/dataBase/TripRepo.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/modeles/Trip_modele.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/providers/TripProvider.dart';
import 'package:flutter_app/views/trips/widgets/Trip_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class TripsView extends StatefulWidget {

  static const String routeName = "/trips";

  @override
  _State createState() => _State();
}

class _State extends State<TripsView> {
 // Stream<List<Trip>> trips;

  final List  tabs =  [
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];


  // ignore: non_constant_identifier_names
  final CollectionReference TripCollection = FirebaseFirestore.instance.collection("trips");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     //trips = TripCollection.snapshots().map((col) => col.docs.map((doc) => Trip.fromJson(doc.data())).toList()) ;

}
/*
  Stream<List<Trip>> myTrips(TabController tabController, int i){
    var trips ;
    tabController.addListener(() {
      if (tabController.index == i) {
            trips = TripRepo().getFutureTrips();
      }else{
        trips = TripRepo().getFutureTrips();
      }
      });
            return trips;
    }

 */



  @override
  Widget build(BuildContext context) {
    // List<Trip> trips = Provider.of<TripProvider>(context).trips;


    return DefaultTabController(
      length: tabs.length,
      child:    Scaffold(
          appBar: AppBar(
            title: Text("Mes voyages"),
            bottom: TabBar(
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 18.0),
              unselectedLabelColor: Colors.white70,
              indicatorPadding: EdgeInsets.all(3.0),
              indicatorColor: Colors.white70,
              indicatorWeight: 5.0,
              tabs: <Widget>[
                Tab(text: "A venir"),
                Tab(text: "Passés")],
            ),),
          body: TabBarView(
            children: [
              StreamBuilder<List<Trip>>(
                stream: Provider.of<TripProvider>(context, listen: false).getFutureTrips(context),
                initialData: [],
                builder: ( context,
                    AsyncSnapshot<List<Trip>> snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.hasError){
                final error = snapshot.error;
                throw error !;
                print(snapshot.error);
                return Center(child: Text('some error encured'),);
              }else if (snapshot.hasData) {
                final trips = snapshot.data ?? [];
                return  TripList(trips: trips);
              } else {
                //print(trips.length);
                return Center(child: CircularProgressIndicator(),);
              }
                },
              ),

              StreamBuilder<List<Trip>>(
                stream: Provider.of<TripProvider>(context).getPastTrips(context),
                initialData: [],
                builder: (BuildContext context,
                    AsyncSnapshot<List<Trip>> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }else if(snapshot.hasError){
                    final error = snapshot.error;
                    throw error !;
                    print(snapshot.error);
                    return Center(child: Text('some error encured'),);
                  }else if (snapshot.hasData) {
                    final trips = snapshot.data ?? [];
                    return  TripList(trips: trips);
                  } else {
                    //print(trips.length);
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              )
            ],
          )

        /* TabBarView(
          children: [

          TripList(trips: futureTrips),
             TripList(trips: pastTrips,)
      ],
        ) */
      )

     /* Builder(
          builder: (BuildContext context) {
            final TabController tabController = DefaultTabController.of(context);
            tabController.addListener(() {
              if (tabController.index == 0) {
                // Your code goes here.
                // To get index of current tab use tabController.index
              }
            });
            return Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: tabs,
                ),
              ),
              body: TabBarView(
                children: [

                  TripList(trips: futureTrips),
                  TripList(trips: pastTrips,)
                ],
              ),
            );
          }
      ),
     */


    );
  }

}