import 'package:flutter/material.dart';
import 'package:slidable_actions_example/data.dart';
import 'package:slidable_actions_example/model/chat.dart';
import 'package:slidable_actions_example/utils.dart';
import 'package:slidable_actions_example/widget/slidable_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Slidable Example';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Chat> items = List.of(Data.chats);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),

        
        body: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final item = items[index];

            return SlidableWidget(
              child: buildListTile(item),
              onDismissed: (action) =>
                  dismissSlidableItem(context, index, action),
            );
          },
        ),




      );

  void dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    setState(() {
      items.removeAt(index);
    });

    switch (action) {
      case SlidableAction.archive:
        Utils.showSnackBar(context, 'Chat has been archived');
        break;
      case SlidableAction.share:
        Utils.showSnackBar(context, 'Chat has been shared');
        break;
      case SlidableAction.more:
        Utils.showSnackBar(context, 'Selected more');
        break;
      case SlidableAction.delete:
        Utils.showSnackBar(context, 'Chat has been deleted');
        break;
    }
  }

  Widget buildListTile(Chat item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(item.urlAvatar),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.username,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(item.message)
          ],
        ),
        onTap: () {},
      );
}
















import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
//import 'package:newlaundry/widgets/pickimage.dart';

class Data extends StatefulWidget {
  @override
  DataState createState() => DataState();
}

class DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text(" Information ")),
     
     
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Container(



                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(document['UrlImage']),
                    ),
                    title:
                        Text(document["displayName"]),
                    subtitle: Text(document["email"]),
                    trailing: Icon(Icons.delete , color:Colors.red),
                  ),



                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}



///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////



      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                        backgroundImage: NetworkImage(document['UrlImage']),
                    ),
                    title:
                        Text(document["displayName"]),
                    subtitle: Text(document["email"]),
                        trailing: IconButton(
                              onPressed: () => document(auth.currentUser.uid).delete(),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                           //   await collection.doc('document_id').delete();

                    //trailing: Icon(Icons.delete , color:Colors.red),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}























import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, title: 'Flutter', home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('upperGames').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return new ListView(
                    children: snapshot.data.docs
                        .map((DocumentSnapshot documentSnapshot) {
                  return Dismissible(
                    key: ObjectKey(documentSnapshot.data().keys),
                    onDismissed: (direction) {
                      documentSnapshot.data().remove(index);
                    },
                    direction: DismissDirection.startToEnd,
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.ac_unit),
                        title: Text(
                          documentSnapshot.data()['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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

























import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
//import 'package:newlaundry/widgets/pickimage.dart';

class Data extends StatefulWidget {
  @override
  DataState createState() => DataState();
}

class DataState extends State<Data> {
    int index;
    var docRef = Firebase.firestore().collection("Users");

  // // delete the document
  // docRef.doc("lKjNIwEkjP537Ela6fhJ").delete();

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
                    docRef.doc("lKjNIwEkjP537Ela6fhJ").delete();
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



























import 'package:New_Project_KMUTTNEWS/screens/news_view.dart';
import 'package:New_Project_KMUTTNEWS/screens/activities_view.dart';
import 'package:New_Project_KMUTTNEWS/screens/menu_view.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Launcher extends StatefulWidget {
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  int _selectedIndex = 0;
  List<Widget> _pageWidget = <Widget>[News(), Activities(), AddMore()];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.description),
      title: Text(
        'ข่าว',
          style: TextStyle(
           // color: Colors.white,
            fontSize: 14,
            fontFamily: 'Itim',
          ),
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.event_available),
      title: Text(
        'กิจกรรม',
          style: TextStyle(
           // color: Colors.white,
            fontSize: 14,
            fontFamily: 'Itim',
          ),
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      title: Text(
        'อื่นๆ',
          style: TextStyle(
           // color: Colors.white,
            fontSize: 14,
            fontFamily: 'Itim',
          ),
      ),
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black38,
        onTap: _onItemTapped,
      ),
    );
  }
}









       addNewsItem(
          context,{
                                "picture": imageUrl,
                                "create_at": dateTimeStamp,
                                "title": newstitle.text,
                                "detail": newsdetail.text,
                                "view_count": 0,
                                "user_id":FirebaseAuth.instance.currentUser.uid,
                              },





           database
          .collection('PostNews')
          .add({'news': name, 'searchKeywords': indexList});














        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), 
                hintText: 'Search...'
                
                ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? Firestore.instance
                .collection('News')
                .where("searchKeywords", arrayContains: name)
                .snapshots()
            : Firestore.instance.collection("News").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.documents[index];

                    return  Card(
                          margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
               
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(data['picture']),
                    ),
                    title:
                        Text(data["title"] , 
                        style:  TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Itim',
                    ),),
                    subtitle: Text(data["detail"],
                        style:  TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'Itim',
                ),),
                  ),
                    );


////////////////////////////////////

                    return Card(
                          margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                          //color: Colors.deepOrange[50],
                      child: Row(
                        children: <Widget>[
                          // Image.network(
                          //   data['imageUrl'],
                          //   width: 150,
                          //   height: 100,
                          //   fit: BoxFit.fill,
                          // ),
                          // SizedBox(width: 25,),
                          Text(
                            data['title'],
                            style:  TextStyle(
                            fontSize: 12,
                            fontFamily: 'Itim',),),
                        ],
                      ),                     
                    );



                  },
                );
        },
      ),
    );
  }
}






















// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////
// // // ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////
// // ////////////////////////////////////////////////////


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
          title: Text(
          "Search News",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Itim',
          ),
        ),
      ),

           body: Container(
               margin: EdgeInsets.all(15) ,
               padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                 decoration: BoxDecoration(
                  color: Colors.black38.withAlpha(10),
                  borderRadius: BorderRadius.all(
                  Radius.circular(20),
          ),),

        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.black.withAlpha(120),
                    fontSize: 14,
                    fontFamily: 'Itim',),
                  border: InputBorder.none,
                ),
                  onChanged: (val) {
                    setState(() {
                    name = val;
              });},),),
            Icon(
              Icons.search,
              color: Colors.black.withAlpha(120),
            )
          ],
        ),
      ),
    );
  }


      //   title: Card(
      //     child: TextField(
      //       decoration: InputDecoration(
      //           prefixIcon: Icon(Icons.search), 
      //           hintText: 'Search...'
                
      //           ),
      //       onChanged: (val) {
      //         setState(() {
      //           name = val;
      //         });
      //       },
      //     ),
      //   ),
      // ),
     StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? Firestore.instance
                .collection('News')
                .where("searchKeywords", arrayContains: name)
                .snapshots()
            : Firestore.instance.collection("News").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.documents[index];

                    return  Card(
                          margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
               
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(data['picture']),
                    ),
                    title:
                        Text(data["title"] , 
                        style:  TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Itim',
                    ),),
                    subtitle: Text(data["detail"],
                        style:  TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'Itim',
                ),),),);
              },
            );
        },
      ),
    
  }
/////////////////////////////////
/////////////////////////////////
/////////////////////////////////
/////////////////////////////////
/////////////////////////////////






