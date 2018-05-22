import 'package:flutter/material.dart';
import 'base_view.dart';
import 'package:kitchensink/objs/obj_cell.dart';
import 'package:kitchensink/views/cells/textfield_cell.dart';
import 'package:kitchensink/views/cells/button_cell.dart';
import 'package:kitchensink/views/cells/label_cell.dart';

class TaskView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TaskViewState();

}

class TaskViewState extends State<TaskView> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ObjCell> _dataSources;

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
    cell.title = "Date";
    _dataSources.add(cell);


  }

  _actionSave() {

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
      title: 'Login',
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
                            onPress: (){
                             print(item.title); 
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