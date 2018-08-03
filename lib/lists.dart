import 'main.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MessageList extends StatelessWidget {
  MessageList({this.firestore});

  final Firestore firestore;

  @override
  Widget build(BuildContext context) {

    //pop up message
    Future<Null> _neverSatisfied(String name,String email,String phone,String from,String to,String type,String reason,int index) async {
      return showDialog<Null>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new Text('Request Details',textAlign: TextAlign.center),

            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text('    Employee Name:',
                          style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                      ),
                      new Text(name),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('    Email:',
                          style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                      ),
                      new Text(email),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('    Phone No:',
                          style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                      ),
                      new Text(phone),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('    Leave Type:',
                          style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                      ),
                      new Text(type),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('    From:',
                          style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                      ),
                      new Text(from),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('    To:',
                          style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                      ),
                      new Text(to),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('    Reason Details:',
                          style: new TextStyle(fontSize: 15.0,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                      ),
                      new Text(reason),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new MaterialButton(
                        onPressed: null,
                        child: new Text("Accept",
                          style: new TextStyle(fontSize: 17.0,color: Colors.green,fontWeight: FontWeight.bold),
                        ),
                      ),
                      new MaterialButton(
                        onPressed: null,
                        child: new Text("Reject",
                          style: new TextStyle(fontSize: 17.0,color: Colors.red,fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new MaterialButton(
                        onPressed: (){Navigator.of(context).pop();},
                        child: new Text("Cancel",
                          style: new TextStyle(fontSize: 17.0,color: Colors.black45,fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )

                ],
              ),
              
                ],
          );
        },
      );
    }

    return new StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(uemail).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final int messageCount = snapshot.data.documents.length;
        return new ListView.builder(
          itemCount: messageCount,
          itemBuilder: (_, int index) {

            final DocumentSnapshot document = snapshot.data.documents[index];

           return new GestureDetector(
             onTap: (){_neverSatisfied(document['name'],document['email'],document['phone'],document['from'],document['to'],document['leave'],document['reason'],index);},
              child: new Column(
               children: <Widget>[
                 new Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                 ),
                 new Container(
                   child: new ListTile(
                     title: new Text("Employee Name: "+document['name']+"\nLeave Type: "+document['leave']+
                         "\nLeave Status: "+document['status']
                         ?? '<No message retrieved>'),
                     subtitle: new Text('Message ${index + 1} of $messageCount'),
                   ),

                 ),
                 new Divider(height: 20.5,color: Colors.deepPurple,),
               ],

              )

            );

          },
        );
      },
    );
  }
}

class ReqList extends StatelessWidget {
  ReqList({this.firestore});
  final Firestore firestore;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Employee Requests'),
      ),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(image: new AssetImage("assets/form.jpg"),
            fit: BoxFit.fill,
            color: Colors.white30,
            colorBlendMode: BlendMode.darken,
          ),
          new MessageList(firestore: firestore),


        ],
      )



    );
  }
}
