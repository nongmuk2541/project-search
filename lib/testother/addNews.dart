// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as Path;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:New_Project_KMUTTNEWS/service/searchservice.dart';

// class editProfile extends StatefulWidget {
//   @override
//   editProfileState createState() => editProfileState();
// }

// class editProfileState extends State<editProfile> {
//   var queryResultSet = [];
//   var tempSearchStore = [];

//   initiateSearch(value) {
//     if (value.length == 0) {
//       setState(() {
//         queryResultSet = [];
//         tempSearchStore = [];
//       });
//     }

//     var capitalizedValue =
//         value.substring(0, 1).toUpperCase() + value.substring(1);

//     if (queryResultSet.length == 0 && value.length == 1) {
//       SearchService().searchByName(value).then((QuerySnapshot docs) {
//         for (int i = 0; i < docs.documents.length; ++i) {
//           queryResultSet.add(docs.documents[i].data);
//         }
//       });
//     } else {
//       tempSearchStore = [];
//       queryResultSet.forEach((element) {
//         if (element['news'].startsWith(capitalizedValue)) {
//           setState(() {
//             tempSearchStore.add(element);
//           });
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//           title: Text('Firestore search'),
//         ),
//         body: ListView(children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: TextField(
//               onChanged: (val) {
//                 initiateSearch(val);
//               },
//               decoration: InputDecoration(
//                   prefixIcon: IconButton(
//                     color: Colors.black,
//                     icon: Icon(Icons.arrow_back),
//                     iconSize: 20.0,
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   contentPadding: EdgeInsets.only(left: 25.0),
//                   hintText: 'Search by name',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(4.0))),
//             ),
//           ),
//           SizedBox(height: 10.0),
//           GridView.count(
//               padding: EdgeInsets.only(left: 10.0, right: 10.0),
//               crossAxisCount: 2,
//               crossAxisSpacing: 4.0,
//               mainAxisSpacing: 4.0,
//               primary: false,
//               shrinkWrap: true,
//               children: tempSearchStore.map((element) {
//                 return buildResultCard(element);
//               }).toList())
//         ]));
//   }
// }

// Widget buildResultCard(data) {
//   return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       elevation: 2.0,
//       child: Container(
//           child: Center(
//               child: Text(
//         data['news'],
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 20.0,
//         ),
//       ))));
// }

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////4
/////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////

import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddNews extends StatefulWidget {
  @override
  AddNewsState createState() => AddNewsState();
}

class AddNewsState extends State<AddNews> {
  TextEditingController searchController = TextEditingController();
  final database = Firestore.instance;
  String name = "";

  @override
  Widget build(BuildContext context) {


    searchData(String name) async {
      List<String> splitList = name.split(' ');
      List<String> indexList = [];
      for (int i = 0; i < splitList.length; i++,) {
      for (int j = 0; j < splitList[i].length; j++) {
      indexList.add(splitList[i].substring(0, j+1).toLowerCase());
    }}
      database
          .collection('PostNews')
          .add({'news': name, 'searchKeywords': indexList});
    }


    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => searchController.clear(),
                  ),
                  hintText: 'add data'
                  ),
            ),
          ),
          MaterialButton(
              color: Colors.blueAccent,
              child: Text('Update Data'),
              onPressed: () async {
                searchData(searchController.text);
              })
        ],
      ),
    ));


    
  }
}

// //////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////4
// /////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
///
// /
//import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

// class editProfile extends StatefulWidget {
//   @override
//   editProfileState createState() => editProfileState();
// }

// class editProfileState extends State<editProfile> {
//   File _imageFile;
//   final Color yellow = Color(0xfffbc31b);
//   final Color orange = Color(0xfffb6900);

//   ///NOTE: Only supported on Android & iOS
//   ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
//   final picker = ImagePicker();

//   Future pickImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);

//     setState(() {
//       _imageFile = File(pickedFile.path);
//     });
//   }

//   Future uploadImageToFirebase(BuildContext context) async {
//     String fileName = basename(_imageFile.path);
//     StorageReference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('UserPhoto/$fileName');
//     StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     taskSnapshot.ref.getDownloadURL().then(
//           (value) => print("Done: $value"),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             height: 360,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(50.0),
//                     bottomRight: Radius.circular(50.0)),
//                 gradient: LinearGradient(
//                     colors: [orange, yellow],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight)),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 80),
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text(
//                       "Uploading Image to Firebase Storage",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 28,
//                           fontStyle: FontStyle.italic),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 Expanded(
//                   child: Stack(
//                     children: <Widget>[
//                       Container(
//                         height: double.infinity,
//                         margin: const EdgeInsets.only(
//                             left: 30.0, right: 30.0, top: 10.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(30.0),
//                           child: _imageFile != null
//                               ? Image.file(_imageFile)
//                               : FlatButton(
//                                   child: Icon(
//                                     Icons.add_a_photo,
//                                     size: 50,
//                                   ),
//                                   onPressed: pickImage,
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 uploadImageButton(context),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget uploadImageButton(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: <Widget>[
//           Container(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
//             margin: const EdgeInsets.only(
//                 top: 30, left: 20.0, right: 20.0, bottom: 20.0),
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [yellow, orange],
//                 ),
//                 borderRadius: BorderRadius.circular(30.0)),
//             child: FlatButton(
//               onPressed: () => uploadImageToFirebase(context),
//               child: Text(
//                 "Upload Image",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// /////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:New_Project_KMUTTNEWS/screens/login_view.dart';

// class editProfile extends StatefulWidget {
//   @override
//   editProfileState createState() => editProfileState();
// }

// class editProfileState extends State<editProfile> {
//   FirebaseAuth auth = FirebaseAuth.instance;

//   FirebaseStorage storage = FirebaseStorage.instance;

//   File imageFile, file;
//   String urlPic, name, phone, adress;
//   var imageFiles = [];

//   final formKey = GlobalKey<FormState>();
//   String nameString, emailString;
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance; //firebase

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Profile",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontFamily: 'Itim',
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.login_outlined,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               auth.signOut().then((value) {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) {
//                   return Login();
//                 }));
//               });
//             },
//           ),
//         ],
//       ),
//       // backgroundColor: Colors.deepOrange[100],
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 30.0),
//         children: <Widget>[
//           SizedBox(height: 25),
//           showImage(),
//           SizedBox(height: 5),
//           showButton(),
//           SizedBox(height: 10),
//           displayName(),
//           SizedBox(height: 50),
//           SizedBox(height: 50),
//           SizedBox(height: 50),
//           nameText(),
//           SizedBox(height: 50),
//           emailText(),
//         ],
//       ),
//     );
//   }

//   Widget showImage() {
//     return Column(
//       children: [
//         InkWell(
//           child: Image.asset(
//             'image/addImag.png',
//             width: 120,
//             height: 120,
//           ),
//           onTap: () {
//             if (imageFiles.length > 0) {
//               print(imageFiles);
//             } else {
//               //   _showChoiceDialog(context);
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget showButton() {
//     return Row(
//       //mainAxisAlignment: MainAxisAlignment.spaceAround,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         cameraButton(),
//         galleryButton(),
//       ],
//     );
//   }

//   Widget cameraButton() {
//     return IconButton(
//       icon: Icon(
//         Icons.add_a_photo,
//         color: Colors.orange,
//         size: 32,
//       ),
//       onPressed: () {},
//     );
//   }

//   Widget galleryButton() {
//     return IconButton(
//       icon: Icon(
//         Icons.add_photo_alternate,
//         color: Colors.orange,
//         size: 32,
//       ),
//       onPressed: () {},
//     );
//   }

//   Future<void> _showChoiceDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(
//               'ดำเนินการ',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Prompt',
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700),
//             ),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   GestureDetector(
//                     child: Text(
//                       'รูปภาพ',
//                       style: TextStyle(
//                           color: Colors.grey,
//                           fontFamily: 'Itim',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w300),
//                     ),
//                     onTap: () {
//                       //  _openGallary(context);
//                     },
//                   ),
//                   Padding(padding: EdgeInsets.all(8)),
//                   GestureDetector(
//                     child: Text(
//                       'กล้องถ่ายรูป',
//                       style: TextStyle(
//                           color: Colors.grey,
//                           fontFamily: 'Itim',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w300),
//                     ),
//                     onTap: () {
//                       // _openCamera(ImageSource.camera);
//                     },
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Widget displayName() {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.grey[200],
//         ),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Center(
//         child: Text(
//           auth.currentUser.displayName,
//           style: TextStyle(
//             fontSize: 12,
//             fontFamily: 'Itim',
//             color: Colors.grey,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget nameText() {
//     return TextFormField(
//       style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey[200], width: 2),
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         hintText: "XoXo",
//         labelText: 'DisplayName',
//         labelStyle: TextStyle(
//           color: Colors.grey,
//         ),
//         hintStyle: TextStyle(color: Colors.grey[200]),
//       ),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return ' Please Enter Name ';
//         } else {
//           return null;
//         }
//       },
//       onSaved: (String value) {
//         nameString = value.trim();
//       },
//     );
//   }

//   Widget emailText() {
//     return TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey[200], width: 2),
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         hintText: "something@example.com",
//         labelText: 'Email',
//         labelStyle: TextStyle(
//           color: Colors.grey,
//         ),
//         hintStyle: TextStyle(color: Colors.grey[200]),
//       ),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return ' Please Enter Email ';
//         }
//         // if (!((value.contains('@')) && (value.contains('.')))) {
//         //   return 'Please Enter Value Email';
//         // }
//         if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
//           return 'Please a valid Email';
//         } else {
//           return null;
//         }
//       },
//       onSaved: (String value) {
//         emailString = value.trim();
//         // profile.email = emailString ;
//       },
//     );
//   }
// }

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////4
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
