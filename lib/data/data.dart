
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/City_modele.dart';

List<City> cities = [
  City(name: "Paris",
      image: "assets/Paris.jpg",
      activities:  [
        Activity(
            image: 'assets/activities/louvre.jpg',
            name: 'Le Louvre',
            id: 'a1',
            city: 'Paris',
            price: 15.0),

        Activity(
            image: 'assets/activities/chaumont.jpg',
            name: 'Les buttes Chaumont',
            id: 'a2',
            city: 'Paris',
            price: 00.0),
        Activity(
            image: 'assets/activities/dame.jpg',
            name: 'Notre Dame',
            id: 'a3',
            city: 'Paris',
            price: 12.0),
        Activity(
            image: 'assets/activities/la_defense.jpg',
            name: 'La Défense',
            id: 'a4',
            city: 'Paris',
            price: 00.0),
      ] ),
  City(name: "Lyon",
      image: "assets/lyon.jpg",
      activities:  [
    Activity(
        image: 'assets/activities/louvre.jpg',
        name: 'Le Louvre',
        id: 'a1',
        city: 'Lyon',
        price: 15.0),

    Activity(
        image: 'assets/activities/chaumont.jpg',
        name: 'Les buttes Chaumont',
        id: 'a2',
        city: 'Lyon',
        price: 00.0),
    Activity(
        image: 'assets/activities/dame.jpg',
        name: 'Notre Dame',
        id: 'a3',
        city: 'Lyon',
        price: 12.0),
    Activity(
        image: 'assets/activities/la_defense.jpg',
        name: 'La Défense',
        id: 'a4',
        city: 'Lyon',
        price: 00.0),
  ]),
  City(name: "Nice",
      image: "assets/Nice.jpg",
      activities:  [
      Activity(
      image: 'assets/activities/louvre.jpg',
      name: 'Le Louvre',
      id: 'a1',
      city: 'Nice',
      price: 15.0),

  Activity(
      image: 'assets/activities/chaumont.jpg',
      name: 'Les buttes Chaumont',
      id: 'a2',
      city: 'Nice',
      price: 00.0),
  Activity(
      image: 'assets/activities/dame.jpg',
      name: 'Notre Dame',
      id: 'a3',
      city: 'Nice',
      price: 12.0),
  Activity(
      image: 'assets/activities/la_defense.jpg',
      name: 'La Défense',
      id: 'a4',
      city: 'Nice',
      price: 00.0),
])
];

