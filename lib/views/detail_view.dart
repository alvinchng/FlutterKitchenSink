import 'package:flutter/material.dart';
import 'base_view.dart';
import 'package:kitchensink/objs/obj_parser.dart';

class DetailView extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return new WillPopScope(
      onWillPop: () async {
        //parser.title = 'cancel ....';
        //Navigator.pop(context, parser);
        Navigator.pop(context);
        return false;
      }, 
      child: new BaseView(
              title: "Details",
              child: new Text("hahah")
            ),
      );
  }

}