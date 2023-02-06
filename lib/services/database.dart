import 'package:chatapp/models/brew.dart';
import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'package:chatapp/screens/home/brew_list.dart';

class DatabaseService{
  late final String uid;
  DatabaseService({ required this.uid});
  DatabaseService.withoutUID() : uid = "";

  final CollectionReference brewCollection=FirebaseFirestore.instance.collection('brews');
  Future updateUserData(String sugars, String name, int strength) async{
    return await brewCollection.doc(uid).set({
      'sugars':sugars,
      'name':name,
      'strength':strength
    }

    );
  }
  //brew list from snapshot


// get brews stream
Stream<QuerySnapshot>get brews{
    return brewCollection.snapshots();
}

}



