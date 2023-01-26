import 'package:flutter/material.dart';
import 'package:flutter_app/views/city/city.dart';
import 'views/home/home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: City(),
    );
  }
}

