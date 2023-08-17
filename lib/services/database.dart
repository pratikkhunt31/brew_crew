// ignore_for_file: empty_constructor_bodies, avoid_returning_null_for_void

import 'package:brew_crew/module/brew.dart';
import 'package:brew_crew/module/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/home/brew_list.dart';

class DataBaseService {

  final String uid;
  DataBaseService({required this.uid});

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  //brew from snapshot
  List<Brew> _brewlistFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? '0'
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewlistFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}

