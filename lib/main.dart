import 'package:brew/Models/users.dart';
import 'package:brew/screen/authentication/wrapper.dart';
import 'package:brew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      child: MaterialApp(
        home: Wrapper(),
      ),
      value: AuthService().user,
    );
  }
}

