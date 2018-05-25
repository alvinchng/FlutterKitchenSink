import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  
  const BaseView({
    Key key,
    this.title,
    this.child,
    this.scaffoldKey,
    this.actions : const <Widget>[]
  }) : super (key: key);

  final Widget child;
  final List<Widget> actions;
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
        actions: actions,
      ),
      body: child,
    );
  }

}