

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/modeles/User.dart';

//class de configuration de firebaseAuth
class AuthenticationService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //cette methode convertit le user de firebase en notre user personnalisé
  AppUser userFromFirebaseToAppUser(User user){
    return user != null ? AppUser(user.uid) : null;
  }

  //lz Stream se charge de verifier l'état d'authentification de l'utilsateur vourant
  Stream<AppUser> get user {
    return _auth.authStateChanges().map(userFromFirebaseToAppUser);
  }

  //méthode qui gere la connexion
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result =await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return userFromFirebaseToAppUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //méthode qui gere l'inscription
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
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