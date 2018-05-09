import 'package:flutter/material.dart';
import 'base_view.dart';

class DetailView extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new BaseView(
      title: "Details",
      child: new Center(
        child: new Text("Content Here...."),
      )
      );
  }

}