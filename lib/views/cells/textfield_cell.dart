import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:kitchensink/utilities/focusnode_manager.dart';
import 'package:kitchensink/objs/obj_cell.dart';


class TextFieldCell extends StatefulWidget {

  final ObjCell obj;

  const TextFieldCell({
    Key key,
    @required this.obj,
  }) : super(key: key); 

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextFieldCellState();
  }

}

class TextFieldCellState extends State<TextFieldCell> {

  FocusNode _focusNode = new FocusNode();
  TextEditingController _controller = new TextEditingController();

  _controllerOnChange(){
    widget.obj.desc = _controller.text;
  }

  @override
  void initState() {
      // TODO: implement initState
      super.initState();

      _controller.addListener(_controllerOnChange);

  }

  @override
  void dispose() {

    _controller.removeListener(_controllerOnChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      _controller.text = widget.obj.desc;      
    });

    // TODO: implement build
      return new Padding(
        padding: const EdgeInsets.all(12.0),
        child: new FocusNodeManager(
          focusNode: _focusNode,
          child: new TextFormField(
            decoration: new InputDecoration(
              labelText: widget.obj.title
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'This field is compulsory.';
              }
            },
            obscureText: widget.obj.isTextProtected,
            focusNode: _focusNode,
            controller: _controller,
          )
        )
      );
  }



}