import 'package:brew/screen/authentication/authentication/register.dart';
import 'package:brew/screen/authentication/authentication/sing_in.dart';
import 'package:flutter/material.dart';



class Authenticate extends StatefulWidget {

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return signIn(toggleView:toggleView);
    }else{
      return register(toggleView:toggleView);
    }
  }
}
