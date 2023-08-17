// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:brew_crew/module/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DataBaseService(uid: '').brews,
      // initialData: null,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person,
                color: Colors.black,
              ),
              label: Text('Log out',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.settings,
                color: Colors.black,
              ),
              label: Text('Settings',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
         body: Container(
           decoration: BoxDecoration(
             image: DecorationImage(
               image: AssetImage('assets/coffee_bg.png'),
               fit: BoxFit.cover,
             )
           ),
             child: BrewList()
         ),
      ),
    );
  }
}
