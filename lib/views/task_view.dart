import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'base_view.dart';
import 'package:kitchensink/objs/obj_cell.dart';
import 'package:kitchensink/views/cells/cells.dart';
import 'package:kitchensink/models/task_model.dart';
import 'package:kitchensink/utilities/utilities.dart';
import 'package:image_picker/image_picker.dart';

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

  _showImageDialog(BuildContext context) async {

    var showImagePicker = (int type) async {

      File image;
      if (type == 0) {
        image = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 1080.0).catchError((e) => print(e));
      }
      else {
        image = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 1080.0).catchError((e) => print(e));
      }
      
      int length = await image.length();

      if (length > 0) {
        ObjCell photoCell = ObjCell.findByIdentifier(_dataSources, 'photo');
        photoCell.relativeObj;
        print('PHOTO SELECTED....');
      }
    };
    
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
            height: 150.0,
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Camera'),
                  leading: Icon(Icons.camera_alt),
                  onTap: (){
                    Navigator.of(context).pop();
                    showImagePicker(0);
                  },
                ),
                ListTile(
                  title: Text('Gallery'),
                  leading: Icon(Icons.photo),
                  onTap: (){
                    Navigator.of(context).pop();
                    showImagePicker(1);
                  },
                ),
              ]
            ),
          );
        });



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

    cell = new ObjCell();
    cell.type = ObjCellType.LabelImage;
    cell.identifier = 'photo';
    cell.isClickable = true;
    cell.title = "Add a photo.";
    _dataSources.add(cell);


  }

  _actionSave() {

    // serialization....
    Map<String,dynamic> data = new Map();
    _dataSources.forEach((cell){
      data[cell.identifier] = (cell.desc !=null) ? cell.desc : '';
    });
    
    //print(data);

    Helper.progressHUD(context);
    TaskModel.addData(data, 
                    () async {
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> r) => false);
                    },
                    () async {
                      Navigator.pop(context);
                      _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        content: new Text('Failure.'),
                      ));
                    });

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
                             //print(item.title); 
                             if (item.identifier == 'date') {
                               _showDateDialog(context);
                             }
                            },
                          );

                        }
                        else if (item.type == ObjCellType.LabelImage) {
                          
                          return new LabelImageCell(
                            obj: item,
                            onPress: () async {
                             //print(item.title); 
                             if (item.identifier == 'photo') {
                               _showImageDialog(context);
                             }
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