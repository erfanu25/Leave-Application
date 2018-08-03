import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';
import 'leaveRequest.dart';
import 'lists.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'status.dart';

class TodoHome extends StatefulWidget {
  @override
  _BasicAppBarSampleState createState() => _BasicAppBarSampleState();
}


class _BasicAppBarSampleState extends State<TodoHome> {

  final GoogleSignIn googleSignIn = new GoogleSignIn();


  Future<Null> _Alert() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Alert'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Do you want to exit?'),
              ],
            ),
          ),
          actions: <Widget>[
            new Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text('Yes'),
                  onPressed: ()=> exit(0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                new FlatButton(
                  child: new Text('No'),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Application",
          style: new TextStyle(color: Colors.black,)
        ),
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
          centerTitle: true
      ),
    body: new Stack(
    fit: StackFit.expand,
    children: <Widget>[
      new Image(image: new AssetImage("assets/back.jpg"),
        fit: BoxFit.fill,
        color: Colors.white30,
        colorBlendMode: BlendMode.darken,
      ),
      new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new Text("Welcome "+uname),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>new Request()),
              );
            },
            child: new Container(
              //color: Colors.yellow,
              width: 48.0,
              height: 48.0,
             child: new Image(image: new AssetImage("assets/Approval.png")
                 ,fit: BoxFit.fill),


            ),
          ),
          new Text("Request for Leave",
          style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 35.0),
          ),
          new GestureDetector(
            onTap: (){
              Future<void> status() async {
                final FirebaseApp app = await FirebaseApp.configure(
                  name: 'test',
                  options: const FirebaseOptions(
                    googleAppID: '1:171440196242:android:7738fe742be9f442',
                    gcmSenderID: '79601577497',
                    apiKey: 'AIzaSyD5BxaCejI4d90UBvvfdvan67MpgjNiQ9k',
                    projectID: 'flutterapp-d8e8f',
                  ),
                );
                final Firestore firestore = new Firestore(app: app);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>new Status(firestore: firestore)),
                );
              }
              status();

            },
            child: new Container(
              //color: Colors.yellow,
              width: 48.0,
              height: 48.0,
              child: new Image(image: new AssetImage("assets/pending.png"),
                  fit: BoxFit.fill),


            ),
          ),
          new Text("My Request Status",
              style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 35.0),
          ),
          new GestureDetector(
            onTap: (){
              Future<void> conn() async {
                final FirebaseApp app = await FirebaseApp.configure(
                  name: 'test',
                  options: const FirebaseOptions(
                    googleAppID: '1:171440196242:android:7738fe742be9f442',
                    gcmSenderID: '79601577497',
                    apiKey: 'AIzaSyD5BxaCejI4d90UBvvfdvan67MpgjNiQ9k',
                    projectID: 'flutterapp-d8e8f',
                  ),
                );
                final Firestore firestore = new Firestore(app: app);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>new ReqList(firestore: firestore)),
                );
              }
              conn();

            },
            child: new Container(
              //color: Colors.yellow,
              width: 48.0,
              height: 48.0,
              child: new Image(image: new AssetImage("assets/lve.png"),
                  fit: BoxFit.fill),
            ),
          ),
          new Text("Employee's Leave Requests",
              style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 35.0),
          ),
          new GestureDetector(
            onTap: (){
                     googleSignIn.signOut();
                     _Alert();
                     //print("user signed out");
                     //Navigator.pop(context);

                   },
            child: new Container(
              //color: Colors.yellow,
              width: 48.0,
              height: 48.0,
              child: new Image(image: new AssetImage("assets/out.png"),
                  fit: BoxFit.fill),
            ),
          ),
          new Text("Sign Out",
              style: new TextStyle(fontSize: 15.0,color: Colors.red,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
          ),
        ],
      )

    ]
    )
    );
  }
}


