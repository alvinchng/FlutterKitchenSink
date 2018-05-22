import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  
  const BaseView({
    Key key,
    this.title,
    this.child,
    this.scaffoldKey
  }) : super (key: key);

  final Widget child;
  final title;
  final Key scaffoldKey;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var appBarTitle = this.title;
    if(appBarTitle == null) {
      appBarTitle = "";
    }

    var appScaffoldKey = this.scaffoldKey;
    if (appScaffoldKey == null) {
      appScaffoldKey = new GlobalKey<ScaffoldState>();
    }

    return new Scaffold(
      key: appScaffoldKey,
      appBar: new AppBar(
        title: new Text(appBarTitle),
        backgroundColor: Colors.pink,
      ),
      body: child,
    );
  }

}