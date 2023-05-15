

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/dataBase/ActivityRepo.dart';
import 'package:flutter_app/dataBase/CityRepo.dart';
import 'package:flutter_app/dataBase/UserRepo.dart';
import 'package:flutter_app/modeles/User.dart';

//class de configuration de firebaseAuth
class AuthenticationService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //cette methode convertit le user de firebase en notre user personnalisé
  AppUser userFromFirebaseToAppUser(User user){
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //lz Stream se charge de verifier l'état d'authentification de l'utilsateur courant
  //  et le fournir à tous les widgets grace à StreamProvider
  Stream<AppUser> get user {
    return _auth.authStateChanges().map(userFromFirebaseToAppUser);
  }

  //méthode qui gere la connexion
  Future signInWithEmailAndPassword(String email, String password) async{
    //await ActivityRepo().saveActivities();
    //await CityRepo().saveCities();
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      return userFromFirebaseToAppUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //méthode qui gere l'inscription
  Future registerWithEmailAndPassword(String firsName, String lastName, String email, String password) async{
   //await ActivityRepo().saveActivities();
    try{
      UserCredential result =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      UserRepo(uid: user.uid).saveUser(firsName, lastName, email);
      return userFromFirebaseToAppUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}