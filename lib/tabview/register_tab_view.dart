import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:New_Project_KMUTTNEWS/launcher.dart';
import 'package:New_Project_KMUTTNEWS/screens/news_view.dart';
import 'package:New_Project_KMUTTNEWS/service/add_user_service.dart';

class RegisterTabView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String displayString, emailString, passwordString;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance; //firebase

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false, //แก้ปัญหาขึ้น Bottom Overflowed
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: formKey,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  nameText(),
                  SizedBox(height: 15),
                  emailText(),
                  SizedBox(height: 15),
                  passwordText(),
                  // SizedBox(height: 15),
                  // repasswordText(),
                  SizedBox(height: 15),
                  SizedBox(height: 5),
                  clearButton(),
                  SizedBox(height: 10),
                  registerButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nameText() {
    return TextFormField(
      style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200], width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: 'DisplayName',
        hintText: "XoXo",
        // helperText: "Password can't be empty",

        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey[200]),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return ' Please Enter Name ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        displayString = value.trim();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200], width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: 'Email',
        hintText: "something@example.com",
        // helperText: "Password can't be empty",

        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey[200]),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return ' Please Enter Email ';
        }
        // if (!((value.contains('@')) && (value.contains('.')))) {
        //   return 'Please Enter Value Email';
        // }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return 'Please a valid Email';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
        // profile.email = emailString ;
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      obscureText: true, //ปิดบัง password
      style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200], width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: 'Password',
        hintText: "xxxxxxx",
        // helperText: "Password can't be empty",

        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey[200]),
      ),

      validator: (String value) {
        if (value.isEmpty) {
          return 'Please a Enter Password';
        }
        if (value.length < 6) {
          return 'Please must be least 6 charactors';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
        // profile.email = passwordString ;
      },
    );
  }

  Widget clearButton() {
    return FlatButton(
      child: Text(
        "Clear",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 11,
          fontFamily: 'Itim',
        ),
      ),
      onPressed: () {
        formKey.currentState.reset();
      },
    );
  }

  Widget registerButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        "Create new account",
        style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontFamily: 'Itim',
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          formKey.currentState.reset();
          registerThread(
              context); //ถ้าเมื่อไรที่ได้ค่า name email pass ให้ไปทำงานที่  registerThread()
          print('เข้า insertinformation');
        }
      },
    );
  }

  Future<void> registerThread(context) async {
    print('RegisterThread');

    await Firebase.initializeApp();
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailString,
      password: passwordString,
    );
    User updateUser = FirebaseAuth.instance.currentUser;
    updateUser.updateProfile(displayName: displayString);
    userSetup(displayString, emailString);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Launcher()));

    Fluttertoast.showToast(
        msg: "Register Success", gravity: ToastGravity.TOP); //alert
    print('Register Success for Email = $emailString');
    //   setupDisplayName(); //เมื่อไรที่สมัครสมาชิกสำเร็จ ให้ call setupDisplayName ให้ทำงาน
  }
}
