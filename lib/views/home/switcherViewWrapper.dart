import 'package:flutter/material.dart';
import 'package:flutter_app/modeles/User.dart';
import 'package:flutter_app/views/authentication/sign_in.dart';
import 'package:flutter_app/views/home/home_view.dart';
import 'package:provider/provider.dart';

class SwitcherViewWrapper extends StatelessWidget {
  const SwitcherViewWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    if(user == null) {
      return SignIn();
    }else{
      return HomeView();
    }
  }
}
