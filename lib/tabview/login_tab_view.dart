import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:New_Project_KMUTTNEWS/screens/resetPassword.dart';
import 'package:New_Project_KMUTTNEWS/launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginTabView extends StatelessWidget {
  // static const routeName = '/login';
  // @override
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  String _email;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

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
                  emailText(),
                  SizedBox(height: 15),
                  passwordText(),
                  SizedBox(height: 20),
                  forgotPassword(context),
                  SizedBox(height: 15),
                  registerButton(context),
                  SizedBox(height: 15),
                  textContinue(),
                  SizedBox(height: 15),
                  signUpGoogle(context),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
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
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return 'Please a valid Email';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
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
        if (value.length < 6) {
          return 'Please must be least 6 charactors';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  Widget forgotPassword(BuildContext context) {
    return TextButton(
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
      // onPressed: () {
      //   _reset(context);
      // },
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ResetScreen()),
      ),
    );
  }

  // Future<void> _reset(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(
  //             'Reset Password',
  //             style: TextStyle(
  //               fontSize: 15,
  //               fontFamily: 'Itim',
  //               color: Colors.grey,
  //             ),
  //           ),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Container(
  //                   height: 45,
  //                   child: TextFormField(
  //                     style: TextStyle(fontSize: 11, fontFamily: 'Itim'),
  //                     decoration: InputDecoration(
  //                       enabledBorder: OutlineInputBorder(
  //                           borderSide:
  //                               BorderSide(color: Colors.grey[200], width: 2),
  //                           borderRadius:
  //                               BorderRadius.all(Radius.circular(10))),
  //                       focusedBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(
  //                         color: Colors.orange,
  //                         width: 2,
  //                       )),
  //                       hintText: "Enter your",
  //                       labelStyle: TextStyle(color: Colors.grey),
  //                       hintStyle: TextStyle(color: Colors.grey[200]),
  //                     ),
  //                     // onChanged: (value) {
  //                     //   setState(() {
  //                     //     emailString = value.trim();
  //                     //   });
  //                     // },
  //                   ),
  //                 ),
  //                 SizedBox(height: 15),
  //                 saveFName(context),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // Widget saveFName(BuildContext context) {
  //   return RaisedButton(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  //     color: Colors.orange[500],
  //     padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
  //     child: Text(
  //       " Save ",
  //       style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 13,
  //           fontFamily: 'Itim',
  //           fontWeight: FontWeight.bold),
  //     ),
  //     onPressed: () {
  //       Map<String, dynamic> updateUser = new Map<String, dynamic>();
  //       updateUser['emails'] = emailString;
  //       Firestore.instance
  //           .collection("Users")
  //           .document(firebaseAuth.currentUser.uid)
  //           .updateData(updateUser)
  //           .whenComplete(() {});
  //       print(firebaseAuth.currentUser.uid);
  //     },
  //   );
  // }

//////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////////
//////////////////////////////////////////////////////

  Widget textContinue() {
    return Text(
      "Continue with social media",
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'Itim',
        color: Colors.grey,
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        "LOGIN",
        style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: 'Itim',
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          registerThread(
              context); //ถ้าเมื่อไรที่ได้ค่า name email pass ให้ไปทำงานที่  registerThread()
        }
      },
    );
  }

  Future<void> registerThread(context) async {
    // await Firebase.initializeApp();
    print('RegisterThread');
    await firebaseAuth //await คือต้องทำงานให้สำเร็จ
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Launcher()));

      Fluttertoast.showToast(
          msg: "Login Success", gravity: ToastGravity.TOP); //alert
    }).catchError((response) {
      print('เข้า EROR');
      Fluttertoast.showToast(msg: "Try again", gravity: ToastGravity.TOP);
    });
  }

  Widget signUpGoogle(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    return OutlineButton.icon(
      label: Text(
        'Sign In With Google',
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
          fontFamily: 'Itim',
        ),
      ),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      borderSide: BorderSide(color: Colors.black),
      icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
      onPressed: () async {
        signInWithGoogle();
      },
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
