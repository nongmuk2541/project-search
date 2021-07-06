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
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
              Icons.search,
              color: Colors.black.withAlpha(120), ),
                hintText: 'Search...' ,
                 hintStyle: TextStyle(
                   color: Colors.grey, 
                   fontWeight: FontWeight.w400,
                   fontFamily: 'Itim',),  
                   border: InputBorder.none,),
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
                .collection('Activities')
                .where("searchKeywords", arrayContains: name)
                .snapshots()
            : Firestore.instance.collection("Activities").snapshots(),
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
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 64,
                          maxHeight: 64, ),
                      child: Image.network(data['picture'], fit: BoxFit.cover),),
                    title:
                        Text(data["title"] , 
                        style:  TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Itim' ),),
                    subtitle: Text(data["detail"].substring(0, 3),
                        style:  TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'Itim',
                ),),),);
            },
          );
        },
      ),
    );
  }
}


