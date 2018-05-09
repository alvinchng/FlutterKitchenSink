import 'package:flutter/material.dart';
import 'views/root_view.dart';

void main() => runApp(new Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new RootView()
    );
  }

}