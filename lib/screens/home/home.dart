import 'package:chatapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/screens/home/brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth =AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService(uid: "").brews,
      initialData:null,
      child: Scaffold(
        backgroundColor: Colors.brown[500],
        appBar: AppBar(
          title: Text(
            'Brew Crew'
          ),
          centerTitle: true,
          backgroundColor: Colors.brown[900],
          elevation: 0.0,
          actions: [
            FloatingActionButton.extended(
              onPressed: () async{
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout'),
              backgroundColor: Colors.brown[900],
            ),
          ],

        ),

      ),
    );


  }
}
