import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';
import 'package:connectivity/connectivity.dart';


class ConnectionManager {

  /*
  // old:
  let date: Date = documentSnapshot.get("created_at") as! Date
  // new:
  let timestamp: Timestamp = documentSnapshot.get("created_at") as! Timestamp
  let date: Date = timestamp.dateValue()
  */
  
  final Function success;
  final Function failure;

  const ConnectionManager({
    this.success,
    this.failure,

  }) : super();

  void addData(Map data, String collection) async {

    var connectivityResult = await (new Connectivity().checkConnectivity());
    
    if (connectivityResult == ConnectivityResult.none) {
      if (failure != null) {
          failure();
        }
    }
    else if (collection != null && collection.isNotEmpty && data != null) {
      
      data['_created_date'] = new DateTime.now(); 
      await FirebaseAuth.instance.currentUser().then((user){
        data['_created_by'] = user.uid; 
      });
      data['_status'] = 'show';
      //print(data);
      Firestore.instance.collection(collection).document().setData(data).whenComplete((){
        //print("document added");
        if (success != null) {
          success();
        }
      })
      .catchError((e){
        //print("catchError");
        if (failure != null) {
          failure();
        }
      });



     
    }    


  }

  void fetchData(String collection, {String where, String orderBy, int limit, dynamic startAfter}) async {

    var connectivityResult = await (new Connectivity().checkConnectivity());
    
    if (connectivityResult == ConnectivityResult.none) {
      
      if (failure != null) {
          failure();
        }
    }
    else if (collection != null && collection.isNotEmpty) {
      
      var coll = Firestore.instance.collection(collection);
      Query query;

      var onChange = ((QuerySnapshot doc){
        
        if (success != null) {
              success(doc.documents);
        }
        // doc.documents.forEach((snapshot){
        //   if (snapshot.exists) {
        //     if (success != null) {
        //       success();
        //     }
        //     //print(snapshot.documentID+' : '+ snapshot.data["title"]);
        //   }
        // });
      });

      var catchError = ((e){
        print(e);
        if (failure != null) {
          failure();
        }
      });

      if (where != null && where.isNotEmpty) {
        if (where.contains('=')) {
          List<String> splits = where.split('=');
          if (splits.length == 2) {
            query = coll.where(splits[0], isEqualTo: splits[1]);
          }
        }
      }

      if (orderBy != null) {
        if (query != null) {
          query = query.orderBy(orderBy, descending: true);
        }
        else {
          query = coll.orderBy(orderBy, descending: true);
        }  
      }
      
      

      if (startAfter != null) {
        if (query != null) {
          query = query.startAfter([startAfter]);
        }
        else {
          query = coll.startAfter([startAfter]);
        }  
      }
      
      
      if (limit != null) {
        if (query != null) {
          query = query.limit(limit);
        }
        else {
          query = coll.limit(limit);
        }  
      }
      

      if (query != null) {
        query.getDocuments().then(onChange).catchError(catchError);
      }
      else {
        coll.getDocuments().then(onChange).catchError(catchError);
      }


      
    }

  }

  


}
