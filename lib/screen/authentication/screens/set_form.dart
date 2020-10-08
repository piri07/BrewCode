import 'package:brew/Models/users.dart';
import 'package:brew/services/DataBase.dart';
import 'package:brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew/shared/constant.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      // ignore: missing_return
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            // ignore: missing_return
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("update the user", style: TextStyle(fontSize: 15.0),),
                SizedBox(height: 10.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  onChanged: (val) => setState(() => _currentName = val),
                  validator: (val) => val.isEmpty ? 'Please enter a name':null,
                ),
                SizedBox(height: 10.0),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val),
                ),

                //slider
                Slider(
                  value: (_currentStrength ?? 100 ).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? 100],
                  inactiveColor: Colors.brown[_currentStrength ?? 100],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(()=> _currentStrength = val.round()),
                ),

                RaisedButton(
                  color: Colors.pink[500],
                  child: Text("update",style: TextStyle(color: Colors.white),),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength??userData.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
