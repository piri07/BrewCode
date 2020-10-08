import 'package:brew/screen/authentication/authentication/register.dart';
import 'package:brew/services/auth.dart';
import 'package:brew/shared/loading.dart';
import 'package:flutter/material.dart';

class signIn extends StatefulWidget {
  final Function toggleView;
  signIn({this.toggleView});
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field stat

  String email= '';
  String password = '';
  String error = '';



  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: new Text("Sign In to Brew Code"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label:Text("Register")
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
                  fillColor: Colors.white,
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
                validator: (val)=> val.length<6 ? 'e':null,
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
                child: new Text("Sing In", style: TextStyle(color: Colors.white),),

                onPressed: ()async{
                  if(_formkey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.singInWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() {
                        error= 'enter a valid email and password';
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
