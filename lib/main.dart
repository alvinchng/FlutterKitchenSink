import 'package:flutter/material.dart';
import 'views/root_view.dart';
import 'views/login_view.dart';
import 'utilities/login_manager.dart';
import 'dart:async';

void main() => runApp(new Application());

class Application extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        primaryColor: Colors.pink,
        canvasColor: Colors.grey[150], //drawer background.
      ),
      home: new FutureBuilder(
        future: LoginManager.isSignIn(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return new RootView();
            }
            else {
              return new LoginView();
            }
          } else {
            return new Center(
              child: new Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: new CircularProgressIndicator(),
              ),
            );
          }

        },
      ),
      routes: <String, WidgetBuilder> {
        '/home' : (BuildContext context) => new RootView(),
        '/login' : (BuildContext context) => new LoginView()
      },
    );
  }

}