import 'package:flutter/material.dart';



class Helper {

  static void progressHUD(BuildContext context) {
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => new Dialog(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Container(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                child: new Text("Loading..."),
              )
              
            ],
        )
        ),
      ),
    );
    // new Future.delayed(new Duration(seconds: 3), () {
    //   Navigator.pop(context); //pop dialog
    //   //_login();
    // });
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


/*
*   Native TargetPlatform
    import 'package:flutter/services.dart';

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
*/