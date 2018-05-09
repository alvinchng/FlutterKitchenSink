import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  
  const BaseView({
    Key key,
    this.title,
    this.child,
  }) : super (key: key);

  final Widget child;
  final title;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var appBarTitle = this.title;
    if(appBarTitle == null) {
      appBarTitle = "";
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(appBarTitle),
        backgroundColor: Colors.pink,
      ),
      body: child,
    );
  }

}