import 'package:flutter/material.dart';
import 'views/root_view.dart';

void main() => runApp(new Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new RootView(),
      theme: Theme.of(context).copyWith(
        primaryColor: Colors.pink,
      ),
    );
  }

}