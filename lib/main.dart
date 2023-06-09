
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dataBase/CityRepo.dart';
import 'package:flutter_app/providers/CityProvider.dart';
import 'package:flutter_app/providers/TripProvider.dart';
import 'package:flutter_app/servicies/Authenytication.dart';
import 'package:flutter_app/views/authentication/sign_in.dart';
import 'package:flutter_app/views/city/city_view.dart';
import 'package:flutter_app/views/home/switcherViewWrapper.dart';
import 'package:flutter_app/views/trip/trip_view.dart';
import 'package:flutter_app/views/trips/trips_view.dart';
import 'package:flutter_app/widget_utils/404.dart';
import 'package:flutter_app/widget_utils/DataWidget.dart';
import 'package:provider/provider.dart';
import 'dataBase/ActivityRepo.dart';
import 'modeles/City_modele.dart';
import 'modeles/Trip_modele.dart';
import 'modeles/User.dart';
import 'views/home/home_view.dart';
import 'package:flutter_app/data/data.dart' as data;

Future<void> main() async {
  //initialisation de firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await ActivityRepo().saveActivities();

  //CityRepo().saveCities();
  // quand on utilise les inherithed widgets -> on enveloppe notre widget main par ce dernier
  //DataWidget(child: MyApp())
  runApp(TriPlan());
}

class TriPlan extends StatefulWidget {

  //final List<City> cities = data.cities;

  @override
  _TriPlanState createState() => _TriPlanState();
}

class _TriPlanState extends State<TriPlan> {





  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Color(0xFF26474E);

    MaterialColor primarySwatch = MaterialColor(
      primaryColor.value,
      <int, Color>{
        50: primaryColor.withOpacity(0.1),
        100: primaryColor.withOpacity(0.2),
        200: primaryColor.withOpacity(0.3),
        300: primaryColor.withOpacity(0.4),
        400: primaryColor.withOpacity(0.5),
        500: primaryColor.withOpacity(0.6),
        600: primaryColor.withOpacity(0.7),
        700: primaryColor.withOpacity(0.8),
        800: primaryColor.withOpacity(0.9),
        900: primaryColor.withOpacity(1.0),
      },
    );


    //Mutiprovider -> permet de brancher plusieurs providers
    //ChangeNotifierProvider -> permet de notifier aux widegt qui consomme la données une mise à jour de ladonnée pour qu'ils puissent rebuild
    //Vu qu'on utilise pas le context -> on peut directement utiliser le constructeur nommé ChangeNotifierProvider.value de ChangeNotifierProvider
    return MultiProvider(
      providers: [
        //StreamProvider -> permet de brancher notre stream qui va écouter l'etat d'authentification du user
        StreamProvider<AppUser?>.value(
          value: AuthenticationService().user,
          initialData: null,
          catchError: (_, error) {
            throw error.toString();
            return AppUser(uid: "", email: "", firstName: "", lastName: "");
          },
        ),
        ChangeNotifierProvider.value(value: CityProvider()),
        ChangeNotifierProvider.value(value: TripProvider())
      ],
      child:  MaterialApp(
        //ThemeData est un inheritWidget natif -> appliquer des crateistique à tout l'application
        theme: ThemeData(
          //primarySwatch -> permet d'appliquer aléatoirement des gradiants de la couleur à notre application
            primarySwatch: primarySwatch
        ),
        debugShowCheckedModeBanner: false,
        //On enveloppe notre Widget City() par l'inheritWidget DataWidget
        //   -> permet aux widgets enfants d'acceder au données placées dans l'inheritWidget grace au context
        home: SwitcherViewWrapper(),
        routes: {
          CityView.routeName : (context) => CityView(),
          //on peut utiliser un _ à la place de context parcequ'on ne se sert pas de ce dernier
          TripView.routeName : (_) => TripView(),
          TripsView.routeName : (_) => TripsView()
        },
        onUnknownRoute: (settings) =>  MaterialPageRoute(builder: (context) => NotFoundRoute()),

      ),
    );

  }


}

