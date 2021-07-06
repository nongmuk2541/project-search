import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:New_Project_KMUTTNEWS/screens/login_view.dart';
import 'package:New_Project_KMUTTNEWS/screens/editProfile.dart';


class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //bool circular = false;
  PickedFile _imageFile;
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
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
              auth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              });
            },
          ),
        ],
      ),
      // backgroundColor: Colors.deepOrange[100],

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        children: <Widget>[
          SizedBox(height: 20),
          imageProfile(),
          SizedBox(height: 25),
          displayText(),
          SizedBox(height: 5),
          showDisplayName(),
          SizedBox(height: 15),
          fnameText(),
          SizedBox(height: 5),
          showFName(),
          SizedBox(height: 15),
          lnameText(),
          SizedBox(height: 5),
          showLName(),
          SizedBox(height: 15),
          emailText(),
          SizedBox(height: 5),
          showEmail(),
          SizedBox(height: 15),
          yearsBranchText(),
          SizedBox(height: 5),
          yearsBranchShow(),
          SizedBox(height: 15),
          facultyText(),
          SizedBox(height: 5),
          showFaculty(),
          SizedBox(height: 25),
          registerButton(context),
          SizedBox(height: 10),
          deleteUser(),
          SizedBox(height: 100),
      
        ],
      ),
    );
  }

  Widget displayText() {
    return Container(
      margin: EdgeInsets.only(right: 200.0),
      child: Text(
        "DisplayName : ",
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget showDisplayName() {
    return Container(
      height: 45,
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("Users")
              .where('uid', isEqualTo: auth.currentUser.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["displayName"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget fnameText() {
    return Container(
      // margin: EdgeInsets.only(right: 250.0),
      child: Text(
        "FistName : ",
        //textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget lnameText() {
    return Container(
      // margin: EdgeInsets.only(right: 250.0),
      child: Text(
        "LastName : ",
        //textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget showFName() {
    return Container(
      height: 45,
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("Users")
              .where('uid', isEqualTo: auth.currentUser.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["fname"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget showLName() {
    return Container(
      height: 45,
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("Users")
              .where('uid', isEqualTo: auth.currentUser.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["lname"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget emailText() {
    return Container(
      margin: EdgeInsets.only(right: 250.0),
      child: Text(
        "Email : ",
        //textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget showEmail() {
    return Container(
      height: 45,
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("Users")
              .where('uid', isEqualTo: auth.currentUser.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["email"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget yearsBranchText() {
    return Row(
      children: [
        Container(
          child: Text(
            "Years : ",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Itim',
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50.0),
          child: Text(
            "Branch : ",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Itim',
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget yearsBranchShow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Users")
                  .where('uid', isEqualTo: auth.currentUser.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: snapshot.data.docs.map((document) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                        child: Text(
                          document["years"],
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Itim',
                            color: Colors.grey[400],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
        ),
        Container(
          height: 45,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Users")
                  .where('uid', isEqualTo: auth.currentUser.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: snapshot.data.docs.map((document) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                        child: Text(
                          document["branch"],
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Itim',
                            color: Colors.grey[400],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget facultyText() {
    return Container(
      margin: EdgeInsets.only(right: 200.0),
      child: Text(
        "Faculty : ",
        //textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget showFaculty() {
    return Container(
      height: 45,
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("Users")
              .where('uid', isEqualTo: auth.currentUser.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["faculty"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .where('uid', isEqualTo: auth.currentUser.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot item = snapshot.data.documents[index];
                  return Center(
                    child: Stack(children: <Widget>[
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(item['UrlImage']),
                        // fit: BoxFit.fill
                      ),
                    ]),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget registerButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      //padding: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Text(
        "Edit Profile",
        style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: 'Itim',
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditProfile()));
      },
    );
  }

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////////////////////////

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Please Confirm',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Itim',
              color: Colors.grey[800],
            ),
          ),
          content: Text(
            'Are you sure to delete Data ?',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Itim',
              color: Colors.grey,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "YES",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Itim',
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                Firestore.instance
                    .collection("Users")
                    .document(auth.currentUser.uid)
                    .delete();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
            FlatButton(
              child: Text(
                "NO",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Itim',
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget deleteUser() {
    return TextButton(
      child: Text(
        "Delete Data",
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
      onPressed: () => showAlert(context),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

















// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(" Information ")),
    


//      body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("Users").snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return ListView(
//               children: snapshot.data.docs.map((document) {
              
              
              
              
//                 return Container(
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 30,
//                                         backgroundImage: NetworkImage(document['UrlImage']),

//                     ),
//                     title:
//                         Text(document["displayName"]),
//                     subtitle: Text(document["email"]),
//                   ),
//                 );




//               }).toList(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }






//    body: new ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, int index) {
//           return new Dismissible(
//             key: new Key(items[index]),
//             onDismissed: (direction) {
//               items.removeAt(index);
//               Scaffold.of(context).showSnackBar(
//                   new SnackBar(content: new Text("Item dismissed successfully")));
//             },
//             background: new Container(
//               color: Colors.red,
//             ),



//             child: Container(
//               child: new ListTile(
//                 leading: Icon(Icons.list),
//                 title: new Text("GFG " + "${items[index]}"),
//                 trailing: Icon(Icons.done_all,color: Colors.green,),
//               ),
//             ),










 
//  class DataState extends State<Data> {
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(title: Text(" Information ")),
     
     
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("Users").snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return ListView(
//               children: snapshot.data.docs.map((document) {
//                 return Container(

//                   child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 30,
//                         backgroundImage: NetworkImage(document['UrlImage']),
//                     ),
//                     title:
//                         Text(document["displayName"]),
//                     subtitle: Text(document["email"]),
//                   ),

                  
//                 );
//               }).toList(),
//             );
//           }
//         },

        
//       ),
//     );
//   }
// }












// class _HomePageState extends State<HomePage> {
//   // Dummy Product Data Here
//   final List myProducts = List.generate(100, (index) {
//     return {"id": index, "title": "Product \#$index", "price": index + 1};
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Kindacode.com'),
//         ),
//         body: Container(
//           child: ListView.builder(
//             itemCount: myProducts.length,
//             itemBuilder: (BuildContext ctx, index) {
//               // Display the list item
//               return Dismissible(
//                 key: UniqueKey(),

//                 // only allows the user swipe from right to left
//                 direction: DismissDirection.endToStart,

//                 // Remove this product from the list 
//                 // In production enviroment, you may want to send some request to delete it on server side
//                 onDismissed: (_){
//                   setState(() {
//                     myProducts.removeAt(index);
//                   });
//                 },

//                 // Display item's title, price...
//                 child: Card(
//                   margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       child: Text(myProducts[index]["id"].toString()),
//                     ),
//                     title: Text(myProducts[index]["title"]),
//                     subtitle:
//                         Text("\$${myProducts[index]["price"].toString()}"),
//                     trailing: Icon(Icons.arrow_back),
//                   ),
//                 ),

//                 // This will show up when the user performs dismissal action
//                 // It is a red background and a trash icon
//                 background: Container(
//                   color: Colors.red,
//                   margin: EdgeInsets.symmetric(horizontal: 15),
//                   alignment: Alignment.centerRight,
//                   child: Icon(
//                     Icons.delete,
//                     color: Colors.white,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ));
//   }

// }
