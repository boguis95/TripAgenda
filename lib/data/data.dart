
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/City_modele.dart';

List<City> cities = [
  City(name: "Paris",
      image: "assets/Paris.jpg",
      activities:  [
        Activity(
            image: 'assets/activities/louvre.jpg',
            name: 'Le Louvre',
            id: '1',
            city: 'Paris',
            price: 15.0),

        Activity(
            image: 'assets/activities/chaumont.jpg',
            name: 'Les buttes Chaumont',
            id: '2',
            city: 'Paris',
            price: 00.0),
        Activity(
            image: 'assets/activities/dame.jpg',
            name: 'Notre Dame',
            id: '3',
            city: 'Paris',
            price: 12.0),
        Activity(
            image: 'assets/activities/la_defense.jpg',
            name: 'La Défense',
            id: '4',
            city: 'Paris',
            price: 00.0),
      ] ),
  City(name: "Lyon",
      image: "assets/lyon.jpg",
      activities:  [
    Activity(
        image: 'assets/activities/louvre.jpg',
        name: 'Le Louvre',
        id: '5',
        city: 'Lyon',
        price: 15.0),

    Activity(
        image: 'assets/activities/chaumont.jpg',
        name: 'Les buttes Chaumont',
        id: '6',
        city: 'Lyon',
        price: 00.0),
    Activity(
        image: 'assets/activities/dame.jpg',
        name: 'Notre Dame',
        id: '7',
        city: 'Lyon',
        price: 12.0),
    Activity(
        image: 'assets/activities/la_defense.jpg',
        name: 'La Défense',
        id: '8',
        city: 'Lyon',
        price: 00.0),
  ]),
  City(name: "Nice",
      image: "assets/Nice.jpg",
      activities:  [
      Activity(
      image: 'assets/activities/louvre.jpg',
      name: 'Le Louvre',
      id: '9',
      city: 'Nice',
      price: 15.0),

  Activity(
      image: 'assets/activities/chaumont.jpg',
      name: 'Les buttes Chaumont',
      id: '10',
      city: 'Nice',
      price: 00.0),
  Activity(
      image: 'assets/activities/dame.jpg',
      name: 'Notre Dame',
      id: '11',
      city: 'Nice',
      price: 12.0),
  Activity(
      image: 'assets/activities/la_defense.jpg',
      name: 'La Défense',
      id: '12',
      city: 'Nice',
      price: 00.0),
])
];

