import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';


class ConnectionManager {

  /*
  // old:
  let date: Date = documentSnapshot.get("created_at") as! Date
  // new:
  let timestamp: Timestamp = documentSnapshot.get("created_at") as! Timestamp
  let date: Date = timestamp.dateValue()
  */
  static CollectionReference rootRef = Firestore.instance.collection("task");
  final void success;
  final void failure;

  const ConnectionManager({
    this.success,
    this.failure,

  }) : super();

  void addData() {

    ConnectionManager conn = new ConnectionManager();
    Map<String, String> data = <String, String> {
      "title" : "Testing",
      "desc"  : "123 testing"
    };

    
    rootRef.document().setData(data).whenComplete((){
      print("document added");
    }).catchError((e) => print(e));

    //return conn;

  }

  void updateData() {
    //print("updateData");
    //ConnectionManager conn = new ConnectionManager();


    rootRef.getDocuments().then((QuerySnapshot doc){
      doc.documents.forEach((snapshot){
        if (snapshot.exists) {
          print(snapshot.documentID+' : '+ snapshot.data["title"]);
        }
      });
    }).catchError((e) => print(e));

    //return conn;
  }


}
