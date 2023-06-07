import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dataBase/CityRepo.dart';
import 'package:flutter_app/modeles/City_modele.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/servicies/Authenytication.dart';
import 'package:flutter_app/views/home/widgets/city_card.dart';
import 'package:flutter_app/widget_utils/MyDrawer.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<QuerySnapshot<Map<String, dynamic>>> _citiesSnap;

  @override
  void initState() {
    super.initState();
    //_citiesSnap = Provider.of<CityProvider>(context).citiesSnap;
    _citiesSnap = FirebaseFirestore.instance.collection('cities').get();
  }

  @override
  Widget build(BuildContext context) {
    //final cities = Provider.of<CityProvider>(context).cities;
    //final cities =  CityRepo().myCities();
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.home),
        title: const Text("TriPlan"),
        titleSpacing: 100.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => await AuthenticationService().signOut(),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: _citiesSnap,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              List<Widget> _citiesWidget = <Widget>[];

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(child: Text('Some error occurred'));
                //throw snapshot.error;
              } else if (snapshot.hasData) {
                snapshot.data!.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
                  City city = City.fromJson(doc.data(), doc.id);
                  city.id = doc.id;
                  _citiesWidget.add(City_card(city: city));
                });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: _citiesWidget,
              );
            },
          ),
        ),
      ),
    );
  }
}
