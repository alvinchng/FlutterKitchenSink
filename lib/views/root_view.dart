import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'detail_view.dart';
import 'login_view.dart';
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
          _actionTapped(context);
        },),
      ),
      body: new Center(
        child: new FlatButton(
          child: new Text("Details"),
          onPressed: () {
            
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
      final result = await Navigator.of(context).push(new PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) {
         return new LoginView(); 
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


class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    //if (settings.isInitialRoute)
    //  return child;
    // Fades between routes. (If you don't want any animation, 
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);

    
  }
}