import 'dart:async';
import 'package:flutter/material.dart';
import 'base_view.dart';
import 'package:kitchensink/objs/obj_cell.dart';
import 'package:kitchensink/views/cells/textfield_cell.dart';
import 'package:kitchensink/views/cells/button_cell.dart';
import 'package:kitchensink/views/cells/label_cell.dart';
import 'package:kitchensink/utilities/connection_manager.dart' as CONN;

class TaskView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TaskViewState();

}

class TaskViewState extends State<TaskView> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ObjCell> _dataSources;

  DateTime _date = new DateTime.now();

  Future<Null> _showDateDialog(BuildContext context) async {
    
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2020)

    );

    if (picked != null && picked != _date) {
      print('date selected: $picked');

      ObjCell cell = ObjCell.findByIdentifier(_dataSources, 'date');
      setState(() {
              cell.desc = picked.toString();
            });
    }

  }


  addDataSources() {

    ObjCell cell;
    _dataSources = new List();

    cell = new ObjCell();
    cell.type = ObjCellType.TextField;
    cell.identifier = 'title';
    cell.title = "Task name";
    _dataSources.add(cell);

    cell = new ObjCell();
    cell.type = ObjCellType.TextField;
    cell.identifier = 'desc';
    cell.title = "Description";
    _dataSources.add(cell);

    cell = new ObjCell();
    cell.type = ObjCellType.Label;
    cell.identifier = 'date';
    cell.isClickable = true;
    cell.title = "Date";
    cell.desc = new DateTime.now().toString();
    _dataSources.add(cell);


  }

  _actionSave() {

    CONN.ConnectionManager().updateData();

  }


  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      addDataSources();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new BaseView(
      scaffoldKey: _scaffoldKey,
      title: 'New Task',
      actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            _actionSave();
          },
        )
      ],
      child: new SafeArea(
                top: false,
                bottom: false,
                child: new Form(
                    key: _formKey,
                    child: new ListView.builder(
                      itemCount: _dataSources.length,
                      itemBuilder: (BuildContext context, int index) {
                        ObjCell item = _dataSources[index];
                        if (item.type == ObjCellType.Label) {
                          
                          return new LabelCell(
                            obj: item,
                            onPress: () async {
                             print(item.title); 
                             _showDateDialog(context);
                            },
                          );

                        }
                        else if (item.type == ObjCellType.TextField) {
                          
                          return new TextFieldCell(
                            obj: item,
                          );

                        }
                        else {
                          return new Container();
                        }
                        

                      },

                    )
                ),
            ),
    );

  }


  
}