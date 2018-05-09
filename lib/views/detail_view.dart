import 'package:flutter/material.dart';
import 'base_view.dart';
import 'package:kitchensink/objs/obj_parser.dart';

class DetailView extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {

    var parser = new ObjParser();
    parser.title = 'saving ....';

    // TODO: implement build
    return new WillPopScope(
      onWillPop: () async {
        parser.title = 'cancel ....';
        Navigator.pop(context, parser);
        return false;
      }, 
      child: new BaseView(
              title: "Details",
              child: new FlatButton(
                child: new Text("Go Home"),
                onPressed: () {
                  Navigator.pop(context, parser);
                },
              ),
            ),
      );
  }

}