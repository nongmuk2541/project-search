import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:New_Project_KMUTTNEWS/screens/login_view.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Itim',
          ),
        ),
        
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.login_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              firebaseAuth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              });
            },
          ),
        ],
      ),
      
      body: Column(
        children: [
          SizedBox( height: 15.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
             SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                color: Colors.orange[500],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                  'Send Request',
                   style: TextStyle(
                   color: Colors.white,
                   fontSize: 13,
                   fontFamily: 'Itim',
                   fontWeight: FontWeight.bold),
      ),
                onPressed: () {
                  firebaseAuth.sendPasswordResetEmail(email: _email);
                  Navigator.of(context).pop();
                },
                // color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
