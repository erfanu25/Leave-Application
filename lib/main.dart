import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

String uname,uemail;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPage(),
      theme: new ThemeData(
          primarySwatch: Colors.blue
      )
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();



    Future<FirebaseUser>_validation() async{
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

      FirebaseUser user = await _auth.signInWithGoogle(
          idToken: gSA.idToken,
          accessToken: gSA.accessToken
      );
     // print("User Name : ${user.displayName}");
      // return user;
     uname=user.displayName;
     uemail=user.email;
     //print(uname);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>new TodoHome()),
      );
    }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black12,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(image: new AssetImage("assets/home.jpg"),
          fit: BoxFit.fill,
          color: Colors.white30,
          colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: 100.0
              ),
              new Text("Leave App",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 2.0,
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              new IconButton(icon: new Icon(Icons.input),
                  iconSize: 40.0,
                  onPressed: _validation,
                  splashColor: Colors.redAccent,
              )
            ],
          )
        ],
      ),

    );
  }

}


