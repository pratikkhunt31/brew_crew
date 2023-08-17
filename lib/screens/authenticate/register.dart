// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';


class Register extends StatefulWidget {
  // const Register({Key? key}) : super(key: key);

  final Function toggleView;
  Register({ required this.toggleView });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '' ;
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        leadingWidth: 30.0,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Brew Crew'),
        actions: <Widget>[
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
            ),
            icon: Icon(Icons.person,
            color: Colors.black,
            ),
            label: Text('Sign In',
            style: TextStyle(
              color: Colors.black,
            ),
            ),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password have 6 character' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.regWithEmailAndPass(email, password);
                    if (result == null){
                      setState(() {
                        error = 'Please Enter Valid Email';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
