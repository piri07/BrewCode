import 'package:brew/Models/brew.dart';
import 'package:brew/Models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService{
  final String uid;

  //takes uid from the server and then assigns the uid to the declared uid
  DatabaseService({this.uid});


  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData (String sugars,String name,int strength) async{
    return await brewCollection.document(uid).setData({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength,
    });

  }
  //brewlist from snapshot

  List<Brew> _brewListFromSnapshots(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength']?? 0,
        sugars: doc.data['sugars'] ?? ''
      );
    }).toList();
  }

  //userData from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'] ,
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'] ,
    );
  }


  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshots);
  }

  //get user data stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }




}