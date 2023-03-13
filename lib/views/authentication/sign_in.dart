import 'package:flutter/material.dart';
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
            icon: Icon(Icons.login, color: Colors.white,),
            label: Text(showSignIn
                ? 'Connexion'
                : 'Inscription' ,
            style: TextStyle(color: Colors.white),),
            onPressed: () => toggleView(),
          )
        ],

      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxHeight: 600),
          padding: EdgeInsets.symmetric(vertical: 130.0, horizontal: 15.0),
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: textInputDecoration.copyWith(hintText: 'email'),
                  validator: (value) => value.isEmpty ? "entrer un eamil valide" : null,
                ),
                SizedBox(height: 10.0 ),
                TextFormField(
                  //cacher le mot de passe
                  obscureText: true,
                  controller: passwordController,
                  decoration: textInputDecoration.copyWith(hintText: 'mot de passe'),
                  validator: (value) => value.length < 8 ? "le mot de passe ne peut pas contenir moins de 8 caractères" : null,
                ),
                SizedBox(height: 10.0,),
                Container(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    child:  Text(
                      showSignIn ? "s'incrire" : "se connecter",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),) ,
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if(_fromKey.currentState.validate()){

                          var password = passwordController.value.text;
                          var email = emailController.value.text;

                          dynamic result =  showSignIn
                              ? await _auth.registerWithEmailAndPassword(email, password)
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
