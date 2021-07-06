
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////
///////////////////////////////////////////////////////////////////////
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';


class Data extends StatefulWidget {
  @override
  DataState createState() => DataState();
}

class DataState extends State<Data> {
    int index;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text(" User Account ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Itim',
          ),
        ),
      ),
     
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('Users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return new ListView(
                    children: snapshot.data.docs
                        .map((DocumentSnapshot document) {

                          
                  return Dismissible(
                    key: ObjectKey(document.data().keys),
                    onDismissed: (direction) {
                      document.data().remove(index);
                    },

                    
                    direction: DismissDirection.startToEnd,



                    child: Card(


                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          color: Colors.deepOrange[50],
               
               
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(document.data()['UrlImage']),
                    ),
                    title:
                        Text(document.data()["displayName"] , 
                        style:  TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Itim',
                    ),),
                    subtitle: Text(document.data()["email"],
                        style:  TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Itim',
                ),),
               //     trailing: Icon(Icons.delete , color:Colors.red),
                  ),
                    ),
                  );
                }).toList());
              }
            },
          ),
        ));
  }
}

// ///////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////
// ///////////////////////
// ///////////////////////////////////////////////////////////////////////
// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
//     int index;
//     var docRef = Firebase.firestore().collection("Users");

//   // // delete the document
//   // docRef.doc("lKjNIwEkjP537Ela6fhJ").delete();

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(title: Text(" User Account ",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontFamily: 'Itim',
//           ),
//         ),
//       ),
     
//       body: Container(
//           child: StreamBuilder<QuerySnapshot>(
//             stream:
//                 FirebaseFirestore.instance.collection('Users').snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else {
//                 return new ListView(
//                     children: snapshot.data.docs
//                         .map((DocumentSnapshot document) {
//                   return Dismissible(
//                     key: ObjectKey(document.data().keys),
//                     onDismissed: (direction) {
//                       document.data().remove(index);
//                     docRef.doc("lKjNIwEkjP537Ela6fhJ").delete();
//                     },
//                     direction: DismissDirection.startToEnd,
//                     child: Card(
//                           margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
//                  color: Colors.deepOrange[50],
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 30,
//                       backgroundImage: NetworkImage(document.data()['UrlImage']),
//                     ),
//                     title:
//                         Text(document.data()["displayName"] , 
//                         style:  TextStyle(
//                         fontSize: 15.0,
//                         fontFamily: 'Itim',
//                     ),),
//                     subtitle: Text(document.data()["email"],
//                         style:  TextStyle(
//                         fontSize: 12.0,
//                         fontFamily: 'Itim',
//                 ),),
//                //     trailing: Icon(Icons.delete , color:Colors.red),
//                   ),
//                     ),
//                   );
//                 }).toList());
//               }
//             },
//           ),
//         ));
//   }
// }



///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////




// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
//       final List myProducts = List.generate(100, (index) {
//     return {"id": index, "title": "Product \#$index", "price": index + 1};
//   });

//  @override
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

  
  

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
// ///////////////////////
// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
// //       final List myProducts = List.generate(100, (index) {
// //     return {"id": index, "title": "Product \#$index", "price": index + 1};
// //   });

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
//                     trailing: Icon(Icons.arrow_back),
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









/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
// ///////////////////////


// import 'dart:ffi';

// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
//   TextEditingController addController = TextEditingController();
//   final database = Firestore.instance;
//   String name = "";

//   @override
//   Widget build(BuildContext context) {
//     updateData(String name) async {
//       List<String> splitList = name.split(' ');
//       List<String> indexList = [];

//       for (int i = 0; i < splitList.length; i++) {
//         for (int j = 0; j < splitList[i].length + i; j++) {
//           indexList.add(splitList[i].substring(0, j).toLowerCase());
//         }
//       }

//       database
//           .collection('PostNews')
//           .add({'news': name, 'searchIndex': indexList});
//     }

//     return Scaffold(
//         body: Container(
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: TextField(
//               controller: addController,
//               decoration: InputDecoration(
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.clear),
//                     onPressed: () => addController.clear(),
//                   ),
//                   hintText: 'add data'
//                   //  hintStyle:
//                   ),
//             ),
//           ),
//          Expanded(
//            child: StreamBuilder<QuerySnapshot>(
//         stream: (searchString == null || searchString.trim() == '')
//             ? Firestore.instance.collection('PostNews').snapshots()
//             : Firestore.instance.collection('PostNews').where('searchIndex' , arrayContains: searchString)
//                     ,)
//         ],
//       ),
//     ));
//   }
// }

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
// ///////////////////////

// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
//   String name = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Card(
//           child: TextField(
//             decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search), hintText: 'Search...'),
//             onChanged: (val) {
//               setState(() {
//                 name = val;
//               });
//             },
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: (name != "" && name != null)
//             ? Firestore.instance
//                 .collection('News')
//                 .where("searchKeywords", arrayContains: name)
//                 .snapshots()
//             : Firestore.instance.collection("News").snapshots(),
//         builder: (context, snapshot) {
//           return (snapshot.connectionState == ConnectionState.waiting)
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   itemCount: snapshot.data.documents.length,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot data = snapshot.data.documents[index];
//                     return Card(
//                       child: Row(
//                         children: <Widget>[
//                           Image.network(
//                             data['picture'],
//                             width: 150,
//                             height: 100,
//                             fit: BoxFit.fill,
//                           ),
//                           SizedBox(
//                             width: 25,
//                           ),
//                           Text(
//                             data['detail'],
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//         },
//       ),
//     );
//   }
// }

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
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


/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
// @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//    //   title: 'Swipe to dismiss',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
  
// class MyPage extends StatelessWidget {
//   final List<String> items =
//   new List<String>.generate(80, (i) => "Item ${i + 1}");
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Edit-Profile",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontFamily: 'Itim',
//           ),
//         ),

//       ),
//       body: new ListView.builder(
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

            
//           );
//         },
//       ),
//     );
//   }
// }

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
//import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
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





/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
// /////////////////////////////////////////////////////////////////////////
// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class Data extends StatefulWidget {
//   @override
//   DataState createState() => DataState();
// }

// class DataState extends State<Data> {
//   @override
//  Widget build(BuildContext context) {
//     return new Scaffold(
//       body: new ListView(
//         children: ListTile
//             .divideTiles(
//               context: context,
//               tiles: new List.generate(42, (index) {
//                 return new SlideMenu(
               
               
//                   child: new ListTile(
//                     title: new Container(child: new Text("Drag me")),
//                   ),




//                   menuItems: <Widget>[
//                     new Container(
//                       child: new IconButton(
//                         icon: new Icon(Icons.delete),
//                       ),
//                     ),
//                     new Container(
//                       child: new IconButton(
//                         icon: new Icon(Icons.info),
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//             )
//             .toList(),
//       ),
      
//     );
//   }
// }

// class SlideMenu extends StatefulWidget {
//   final Widget child;
//   final List<Widget> menuItems;

//   SlideMenu({this.child, this.menuItems});

//   @override
//   _SlideMenuState createState() => new _SlideMenuState();
// }

// class _SlideMenuState extends State<SlideMenu> with SingleTickerProviderStateMixin {
//   AnimationController _controller;

//   @override
//   initState() {
//     super.initState();
//     _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
//   }

//   @override
//   dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {


//     final animation = new Tween(
      
//       begin: const Offset(0.0, 0.0),
//       end: const Offset(-0.2, 0.0)
//     ).animate(new CurveTween(curve: Curves.decelerate).animate(_controller));

//     return new GestureDetector(
//       onHorizontalDragUpdate: (data) {
//         // we can access context.size here
//         setState(() {
//           _controller.value -= data.primaryDelta / context.size.width;
//         });
//       },
//       onHorizontalDragEnd: (data) {
//         if (data.primaryVelocity > 2500)
//           _controller.animateTo(.0); //close menu on fast swipe in the right direction
//         else if (_controller.value >= .5 || data.primaryVelocity < -2500) // fully open if dragged a lot to left or on fast swipe to left
//           _controller.animateTo(1.0);
//         else // close if none of above
//           _controller.animateTo(.0);
//       },
//       child: new Stack(
//         children: <Widget>[
//           new SlideTransition(position: animation, child: widget.child),
//           new Positioned.fill(
//             child: new LayoutBuilder(
//               builder: (context, constraint) {
//                 return new AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     return new Stack(
//                       children: <Widget>[
//                         new Positioned(
//                           right: .0,
//                           top: .0,
//                           bottom: .0,
//                           width: constraint.maxWidth * animation.value.dx * -1,
//                           child: new Container(
//                             color: Colors.black26,
//                             child: new Row(
//                               children: widget.menuItems.map((child) {
//                                 return new Expanded(
//                                   child: child,
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           )
//         ],

//       ),
//     );
//   }
// }
    
    
    