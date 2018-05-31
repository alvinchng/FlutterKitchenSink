import 'package:kitchensink/utilities/connection_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchensink/objs/obj_cell.dart';


class TaskModel {

  const TaskModel({
    this.collection : 'tasks',
    this.connection : const ConnectionManager(),
    this.success,
    this.failure,

  }) : super();

  final String collection;
  final success;
  final failure;
  final ConnectionManager connection;
  

  static ConnectionManager addData(Map data, Function success, Function failure) {

    

    TaskModel model = new TaskModel(connection: ConnectionManager(success: success, failure: failure));
    model.connection.addData(data, model.collection);

    return model.connection;

  }

  static ConnectionManager fetchData(Function success, Function failure) {

    

    TaskModel model = new TaskModel(connection: ConnectionManager(success: (result){
      
      List<ObjCell> cells = new List();
      if (result is List) {
        result.forEach((item){
          if (item is DocumentSnapshot) {
            
            if (item.exists) {
              ObjCell cell = new ObjCell();
              cell.id = item.documentID;
              cell.title = item.data['title'];
              cell.desc = item.data['desc'];
              cell.type = ObjCellType.Label;
              cell.relativeObj = item;
              cells.add(cell);
            }
          }
        });
      }
      
      if (success !=null) {
        success(cells);
      }
    }, failure: failure));

    model.connection.fetchData(model.collection, where:'_status=show', orderBy:'_created_date', limit:10);

    return model.connection;

  }

  static ConnectionManager fetchAppendData(ObjCell cell, Function success, Function failure) {

    

    TaskModel model = new TaskModel(connection: ConnectionManager(success: (result){
      
      List<ObjCell> cells = new List();
      if (result is List) {
        //print(result.length);
        result.forEach((item){
          if (item is DocumentSnapshot) {
            if (item.exists) {
              ObjCell tmp = new ObjCell();
              tmp.id = item.documentID;
              tmp.title = item.data['title'];
              tmp.desc = item.data['desc'];
              tmp.type = ObjCellType.Label;
              tmp.relativeObj = item;
              cells.add(tmp);
            }
          }
        });
      }
      
      if (success !=null) {
        success(cells);
      }
    }, failure: failure));

    model.connection.fetchData(model.collection, 
                                where:'_status=show', 
                                orderBy:'_created_date', 
                                limit:10, 
                                startAfter:cell.relativeObj.data['_created_date']);

    return model.connection;

  }



}