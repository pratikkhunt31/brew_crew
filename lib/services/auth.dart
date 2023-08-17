// ignore_for_file: avoid_print, unnecessary_null_comparison, unnecessary_import, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:brew_crew/module/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User1? _userFromFirebeaseUser(User user) {
    return user!= null ? User1(uid: user.uid) : null;
  }

  //auth change user Stream
  Stream<User1?> get user{
    return _auth.authStateChanges()
        .map((user) => _userFromFirebeaseUser(user!));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebeaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebeaseUser(user!);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future regWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with uid
      await DataBaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFirebeaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}



