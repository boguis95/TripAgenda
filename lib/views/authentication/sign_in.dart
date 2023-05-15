import 'package:flutter/material.dart';
import 'package:flutter_app/dataBase/CityRepo.dart';
import 'package:flutter_app/servicies/Authenytication.dart';
import 'package:flutter_app/views/authentication/utils/constantes.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _fromKey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool showSignIn = true;

  final AuthenticationService _auth = AuthenticationService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      //_fromKey.currentState.reset();
      error = '';
      emailController.text = '';
      passwordController.text = '';
      firstNameController.text = '';
      lastNameController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(width: 40,),
      /*  title: Text(showSignIn
            ? 'Création de compte'
            :  'Connexion',
            style: TextStyle(color: Colors.white)),*/

        actions: [
          TextButton.icon(
            icon: Icon(!showSignIn ? Icons.login: Icons.person_add, color: Colors.white,),
            label: Text(!showSignIn
                ? 'Connexion'
                : 'Inscription' ,
            style: TextStyle(color: Colors.white),),
            onPressed: () => toggleView(),
          )
        ],

      ),
      body: SingleChildScrollView(
        child: Container(
          /*decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ Colors.black87,Colors.black87, Theme.of(context).primaryColor.withOpacity(0.8)]
          ))*/
          constraints: BoxConstraints(maxHeight: 800.0),
          padding: EdgeInsets.symmetric(vertical: 130.0, horizontal: 15.0),
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                !showSignIn ?
               TextFormField(
                  controller: firstNameController,
                  decoration: textInputDecoration.copyWith(hintText: 'prénom', hintStyle: TextStyle(color: Colors.grey[400])),
                  validator: (value) => value.isEmpty ? "entrer un prénom valide" : null,
                ) : Container(),
                SizedBox(height:  !showSignIn ? 10.0 : 0.0,),
                !showSignIn ?
                TextFormField(
                  controller: lastNameController,
                  decoration: textInputDecoration.copyWith(hintText: 'nom',  hintStyle: TextStyle(color: Colors.grey[400])),
                  validator: (value) => value.isEmpty ? "entrer un nom valide" : null,
                )  : Container(),
                SizedBox(height:  !showSignIn ? 10.0 : 0.0,),
                TextFormField(
                  controller: emailController,
                  decoration: textInputDecoration.copyWith(hintText: 'email',  hintStyle: TextStyle(color: Colors.grey[400])),
                  validator: (value) => value.isEmpty ? "entrer un eamil valide" : null,
                ),
                SizedBox(height: 10.0 ),
                TextFormField(
                  //cacher le mot de passe
                  obscureText: true,
                  controller: passwordController,
                  decoration: textInputDecoration.copyWith(hintText: 'mot de passe',  hintStyle: TextStyle(color: Colors.grey[400])),
                  validator: (value) => value.length < 8 ? "le mot de passe ne peut pas contenir moins de 8 caractères" : null,
                ),
                SizedBox(height: 10.0,),
                Container(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    child:  Text(
                      !showSignIn ? "s'incrire" : "se connecter",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),) ,
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if(_fromKey.currentState.validate()){


                          var password = passwordController.value.text;
                          var email = emailController.value.text;
                          var firstName = firstNameController.value.text;
                          var lastName = lastNameController.value.text;


                          dynamic result =  ! showSignIn
                              ? await _auth.registerWithEmailAndPassword(firstName,lastName, email, password)
                              : await _auth.signInWithEmailAndPassword(email, password);



                          if(result == null) {
                            setState(() {
                              error = 'Veuillez entrer un mot de passe correct';
                            });
                          }

                      }


                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
