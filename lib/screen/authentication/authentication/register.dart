import 'package:brew/services/auth.dart';
import 'package:brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


class register extends StatefulWidget {
  final Function toggleView;
  register({this.toggleView});
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email= '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 10.0,
        title: new Text("Register to Brew Code"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){widget.toggleView();}, icon: Icon(Icons.account_circle), label:Text("Sign In")
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 70.0),
        child: Form(
          key: _formkey,
          child:  Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: "Email",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink,width: 2.0)
                    ),
                  ),
                  validator: (val)=> val.isEmpty ? 'enter email':null,

                  onChanged: (val){
                    setState(() {
                      email=val;
                    });
                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink,width: 2.0)
                  ),
                ),
                validator: (val)=> val.length<6 ? 'enter a password longer than 6 chars':null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: new Text("Register", style: TextStyle(color: Colors.white),),
                onPressed: ()async{
                  if(_formkey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() {
                        error= 'please supply a valid email or password';
                        loading=false;
                      });
                    }

                  }

                },

              ),
              SizedBox(height: 15.0),
              Text(error,style: TextStyle(color: Colors.red,fontSize: 15.0),),
            ],
          ),
        ),
      ),
    );
  }
}

