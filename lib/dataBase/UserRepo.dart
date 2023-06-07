
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/modeles/User.dart';

class UserRepo {

  String uid;

  UserRepo({required this.uid});

  //CollectionReference -> fait reference à une collection (nom)
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> saveUser(String firsName, String lastName, String email) async {
    return await userCollection.doc(uid).set({
      'firstName': firsName,
      'lastName' : lastName,
      'email'    : email
    });
  }

  //DocumentSnapshot -> fait reference à un document
  //QuerySnapshot -> par contre fait reference à une liste de documents
  AppUser userFromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AppUser(
      uid: uid,
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      email: snapshot['email'],
    );
  }

  Stream<AppUser> get user {
    return userCollection.doc(uid).snapshots().map(userFromSnapshot);
  }
/*
  Stream<List<AppUser>> get users {
    return userCollection.get().map(userFromSnapshot);
  }

 */


  //recuperation de la liste des utilisateurs de firebase et mappage en AppUser
  /*
  List<AppUser> userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return userFromSnapshot(doc);
    });
  }

   */
}