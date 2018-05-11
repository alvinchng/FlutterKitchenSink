import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'detail_view.dart';
import 'package:kitchensink/utilities/data_manager.dart' as DM;
import 'package:kitchensink/objs/obj_parser.dart';

class RootView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RootViewState();
  }

}

class RootViewState extends State<RootView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: new SafeArea(
        child: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
          print("haha");
        },),
      ),
      body: new Center(
        child: new FlatButton(
          child: new Text("Details"),
          onPressed: () {
            _actionTapped(context);
          },
        )
      )
    );

  }

  // Methods
  _actionTapped(BuildContext context) {
    const MethodChannel nativeCall = const MethodChannel('kitchensink.flutter.io/nativecall');

    Future<Null> _sayHello() async {
      String info;
      try {
        info = await nativeCall.invokeMethod("sayHello");
      } catch (e) {
        info = "Fall to call sayHello";
      }

      var alert = AlertDialog(title: new Text(info),);
      showDialog(context: context, builder: (_) => alert);
    }

    //_sayHello();
    
    _naviPush(BuildContext context) async {
      final result = await Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => new DetailView()
      ));

      // Callback when Pop
      if (result.runtimeType == ObjParser) {
        final parser = result as ObjParser;
        print(parser.title);
      }
      
    }

    _naviPush(context);

  }



} 