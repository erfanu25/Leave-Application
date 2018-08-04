import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'home.dart';
import 'package:intl/intl.dart';

class Contact {
  String name;
  String fromDate;
  String toDate;
  String phone = '';
  String email = '';
  String leaveType = '';
  String reason = '';
}

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}


class _RequestState extends State<Request> {


  Contact newContact = new Contact();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _reasons = <String>['', 'Maternity Leave', 'Special Leave', 'Study Leave', 'Sick Leave', 'Others'];
  String _reason = '';



  //form submission to hr
  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
     // print('Form is not valid!  Please review and correct.');
      _Satisfied();
    } else {
      form.save(); //This invokes each onSaved event
      final DocumentReference userdoc =Firestore.instance.collection(uname).document();
      //date formatter
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd H:m:s');
      String formatted = formatter.format(now);
      final DocumentReference documentReference = Firestore.instance.document(newContact.email+"/"+uemail+" "+DateTime.now().toString());
      Map<String, String> data = <String, String>{
        "name": newContact.name,
        "phone": newContact.phone ,
        "leave": newContact.leaveType ,
        "from": newContact.fromDate,
        "to": newContact.toDate,
        "reason": newContact.reason,
        "time": formatted,
        "email":uemail,
      };
      userdoc.setData(data);
      documentReference.setData(data).whenComplete(() {
        //print("Document Added");
        _neverSatisfied();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>new TodoHome()),
        );

      }).catchError((e) => print(e));


    }
  }

  //pop up message
  Future<Null> _neverSatisfied() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Successful'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Your leave request successfully send to your HR.'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> _Satisfied() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Alert'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Data are not valid!  Please review and correct.'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //validation
  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null ;
  }
  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }
  bool isValidPhoneNumber(String input) {
    final RegExp regex = new RegExp(r'^\d\d\d\d\d\d\d\d\d\d\d$');
    return regex.hasMatch(input);
  }

  //for date picker
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();
  final TextEditingController _controller3 = new TextEditingController();
  final TextEditingController _controller4 = new TextEditingController();
  final TextEditingController _controller5 = new TextEditingController();
  final TextEditingController _controller6 = new TextEditingController();

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 2018 && initialDate.year <= 2100 ? initialDate : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2100));

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);

    });
  }
  Future _chooseDate2(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now) ? initialDate : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2100));

    if (result == null) return;

    setState(() {
      _controller2.text = new DateFormat.yMd().format(result);

    });
  }

  DateTime convertToDate(String input) {
    try
    {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.cyan,
      appBar: AppBar(
          title: Text("Request for Leave",
              style: new TextStyle(color: Colors.black,)
          ),
          backgroundColor: Colors.cyan,
          automaticallyImplyLeading: false,
          centerTitle: true
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Image(image: new AssetImage("assets/form.jpg"),
                fit: BoxFit.fill,
                color: Colors.white30,
                colorBlendMode: BlendMode.darken,
              ),
              new Form(
                  key: _formKey,
                  autovalidate: true,
                  child: new ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: <Widget>[
                      new TextFormField(
                        controller: _controller3,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.email),
                          hintText: 'Enter email address',
                          labelText: 'HRM'+"'s"+' Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => isValidEmail(value) ? null : 'Please enter a valid email address',
                        onSaved: (val) => newContact.email = val,
                      ),
                      new TextFormField(
                        controller: _controller4,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter your first and last name',
                          labelText: 'Your Name',
                        ),
                        validator: (val) => val.isEmpty ? 'Name is required' : null,
                        onSaved: (val) => newContact.name = val,
                      ),
                      new TextFormField(
                        controller: _controller5,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.phone),
                          hintText: 'Enter a phone number',
                          labelText: 'Your Phone',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => isValidPhoneNumber(value) ? null : 'Phone number must be valid and 11 digit',
                        onSaved: (val) => newContact.phone = val,
                      ),
                      new InputDecorator(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.assignment_late),
                          labelText: 'Leave Type',
                        ),
                        isEmpty: _reason == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: _reason,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                newContact.leaveType = newValue;
                                _reason = newValue;
                              });
                            },
                            items: _reasons.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      new Row(children: <Widget>[
                        new Expanded(
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                icon: const Icon(Icons.calendar_today),
                                hintText: 'Enter Form Date',
                                labelText: 'Form Date',
                              ),
                              controller: _controller,
                              keyboardType: TextInputType.datetime,
                             validator: (val) => isValidDob(val) ? null : 'Not a valid date',
                              onSaved: (val) => newContact.fromDate = val,
                            )),
                        new IconButton(
                          icon: new Icon(Icons.more_horiz),
                          tooltip: 'Choose date',
                          onPressed: (() {
                            _chooseDate(context, _controller.text);
                          }),
                        )
                      ]),
                      new Row(children: <Widget>[
                        new Expanded(
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                icon: const Icon(Icons.calendar_today),
                                hintText: 'Enter To Date',
                                labelText: 'To Date',
                              ),
                              controller: _controller2,
                              keyboardType: TextInputType.datetime,
                              validator: (val) => isValidDob(val) ? null : 'Not a valid date',
                              onSaved: (val) => newContact.toDate = val,
                              //convertToDate(val)
                            )),
                        new IconButton(
                          icon: new Icon(Icons.more_horiz),
                          tooltip: 'Choose date',
                          onPressed: (() {
                            _chooseDate2(context, _controller2.text);
                          }),
                        )
                      ]),
                      new TextFormField(
                        maxLines: 2,
                        controller: _controller6,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.announcement),
                          hintText: 'Enter Leave request reason',
                          labelText: 'Reason',
                        ),
                        validator: (val) => val.isEmpty ? 'Reason is required' : null,
                        onSaved: (val) => newContact.reason = val,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new RaisedButton(
                                child: const Text('Submit'),
                                onPressed: (){
                                  _submitForm();
                                }
                            ),
                            new Container(
                              width: 12.0,
                            ),
                            new RaisedButton(
                                child: const Text('Clear'),
                                onPressed: (){
                                  _controller.clear();
                                  _controller2.clear();
                                  _controller3.clear();
                                  _controller4.clear();
                                  _controller5.clear();
                                  _controller6.clear();
                            })
                          ],
                          ),
                    ],
                  ))
            ],
          )),
    );
  }
}
