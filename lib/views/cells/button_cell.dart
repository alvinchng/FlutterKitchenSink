import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:kitchensink/objs/obj_cell.dart';


class ButtonCell extends StatefulWidget {

  final ObjCell obj;
  final Function onPress;

  const ButtonCell({
    Key key,
    @required this.obj,
    this.onPress
  }) : super(key: key); 


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ButtonCellState();
  }

}

class ButtonCellState extends State<ButtonCell> {

  

  @override
  void initState() {
      // TODO: implement initState
      super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    

    // TODO: implement build
      return new Padding(
        padding: const EdgeInsets.all(12.0),
        child: new Center(
          child: new RaisedButton(
              color: Colors.black45,
              child: new Text(widget.obj.title, style: new TextStyle(color: Colors.white),),
              onPressed: () {
                
                if (widget.onPress != null) {
                  widget.onPress();
                }
                
              },
            )
        ),
      );
      
  }



}