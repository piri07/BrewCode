import 'package:brew/Models/users.dart';
import 'package:brew/screen/authentication/authentication/authenticate.dart';
import 'package:brew/screen/authentication/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return home for authenticate
    if (user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
