
import 'package:flutter_app/modeles/Activity_modele.dart';
import 'package:flutter_app/modeles/City_modele.dart';

List<City> cities = [
  City(name: "Paris",
      image: "https://cdn.pariscityvision.com/library/image/5257.jpg",
      activities:  [
       "p1", "p2", "p3", "p4"
      ] ),
  City(name: "Lyon",
      image: "https://www.voyagetips.com/wp-content/uploads/2018/08/Cathedrale-saint-jean-lyon-840x815.jpg",
      activities:  [
        "l1", "l2", "l3", "l4"
  ]),
  City(name: "Nice",
      image: "https://www.voyagetips.com/wp-content/uploads/2017/03/promenade-des-anglais-840x473.jpg",
      activities:  [
        "n1", "n2", "n3", "n4"
]
)];




List<Activity> activities1 = [
  Activity(
      image: 'https://cdn.pariscityvision.com/library/image/5257.jpg',
      name: 'Le Louvre',
      id: 'p1',
      city: 'Paris',
      price: 15.0),

  Activity(
      image: 'https://cdn.pariscityvision.com/library/image/5485.jpg',
      name: 'Les Champs Élysées',
      id: 'p2',
      city: 'Paris',
      price: 00.0),
  Activity(
      image: 'https://cdn.pariscityvision.com/library/image/5255.jpg',
      name: 'Notre Dame',
      id: 'p3',
      city: 'Paris',
      price: 12.0),
  Activity(
      image: 'https://cdn.pariscityvision.com/library/image/5489.jpg',
      name: 'Jardin du Luxembourg',
      id: 'p4',
      city: 'Paris',
      price: 00.0),
  Activity(
      image: 'https://www.voyagetips.com/wp-content/uploads/2018/08/Cathedrale-saint-jean-lyon-840x815.jpg',
      name: 'La Cathédrale Saint-Jean',
      id: 'l1',
      city: 'Lyon',
      price: 15.0),

  Activity(
      image: 'https://www.voyagetips.com/wp-content/uploads/2018/08/basilique-de-fourvi%C3%A8re-840x467.jpg',
      name: 'La Basilique de Fourvière',
      id: 'l2',
      city: 'Lyon',
      price: 00.0),
  Activity(
      image: 'https://www.voyagetips.com/wp-content/uploads/2018/08/croisi%C3%A8re-sur-le-rhone-840x465.jpg',
      name: 'Faire une croisière sur le Rhône',
      id: 'l3',
      city: 'Lyon',
      price: 12.0),
  Activity(
      image: 'https://www.voyagetips.com/wp-content/uploads/2018/08/musee-des-beaux-arts-lyon-840x488.jpg',
      name: 'Le musée des beaux arts de Lyon',
      id: 'l4',
      city: 'Lyon',
      price: 00.0),
  Activity(
      image: 'https://www.voyagetips.com/wp-content/uploads/2017/03/promenade-des-anglais-840x473.jpg',
      name: 'Promenade des Anglais',
      id: 'n1',
      city: 'Nice',
      price: 15.0),

  Activity(
      image: 'https://www.voyagetips.com/wp-content/uploads/2017/03/vieux-nice-840x356.jpg',
      name: 'Vieux Nice',
      id: 'n2',
      city: 'Nice',
      price: 00.0),
  Activity(
      image: 'https://www.voyagetips.com/wp-content/uploads/2017/03/arenes-de-cimiez-nice-840x505.jpg',
      name: 'les Arènes de Cimiez, à Nice',
      id: 'n3',
      city: 'Nice',
      price: 12.0),
  Activity(
      image: 'https://www.voyagetips.com/wp-content/uploads/2017/03/sentier-du-littoral-nice.jpg',
      name: 'Sentier du littoral de Nice',
      id: 'n4',
      city: 'Nice',
      price: 00.0),

];

