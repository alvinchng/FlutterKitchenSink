import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:kitchensink/objs/obj_cell.dart';


class LabelCell extends StatefulWidget {

  final ObjCell obj;
  final VoidCallback onPress;

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
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(title.toString(), 
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        ),
                                    ),
                    ),
                    new Text(desc.toString(), style: TextStyle(
                      color: Colors.grey[500]
                    ),)
                  ],
                )
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ),
        
      );
      
  }



}