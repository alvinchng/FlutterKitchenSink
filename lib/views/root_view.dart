import 'dart:async';

import 'package:flutter/material.dart';
import 'task_view.dart';
import 'package:kitchensink/utilities/data_manager.dart' as DM;
import 'package:kitchensink/objs/obj_parser.dart';
import 'package:kitchensink/utilities/login_manager.dart';


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
          _actionTapped(context);
        },),
      ),
      body: new Center(
        child: new FlatButton(
          child: new Text("Sign Out"),
          onPressed: () async {
            await LoginManager.signOut();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> r) => false);
          },
        )
      )
    );

  }

  // Methods
  _actionTapped(BuildContext context) {
    
    
    _naviPush(BuildContext context) async {
      final result = await Navigator.of(context).push(new PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) {
         return new TaskView(); 
        },
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero)
              .animate(new CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              )),
              child: child,
          );
        }
        
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


