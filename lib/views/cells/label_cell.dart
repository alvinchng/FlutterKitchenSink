import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:kitchensink/objs/obj_cell.dart';


class LabelCell extends StatefulWidget {

  final ObjCell obj;
  final Function onPress;

  const LabelCell({
    Key key,
    @required this.obj,
    this.onPress
  }) : super(key: key); 


  @override
  State<StatefulWidget> createState() => LabelCellState();

}

class LabelCellState extends State<LabelCell> {

  

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

    String title = (widget.obj.title !=null) ? widget.obj.title : '';
    String desc = (widget.obj.desc !=null) ? widget.obj.desc : '';

    // TODO: implement build
      return new FlatButton(
        onPressed: () {
          if (widget.onPress != null) {
            widget.onPress();
          }
        },
        child: new Container(
          constraints: new BoxConstraints.expand(
            height: 44.0
          ),
          //padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 12.0, right: 12.0),
          child: new Stack(
              children: <Widget>[
                new Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: new Text(title.toString(),
                      style: new TextStyle(
                        fontSize: 18.0,
                      )
                  ),
                ),
                new Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: new Icon(Icons.keyboard_arrow_right),
                )
              ]
        ),
        ),
      );
      
  }



}