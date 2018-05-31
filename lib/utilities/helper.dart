
part of utilities;

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

/// A UUID generator. This will generate unique IDs in the format:
///
///     f47ac10b-58cc-4372-a567-0e02b2c3d479
///
/// The generated UUIDs are 128 bit numbers encoded in a specific string format.
///
/// For more information, see
/// http://en.wikipedia.org/wiki/Universally_unique_identifier.
class Uuid {
  final Random _random = new Random();

  /// Generate a version 4 (random) UUID. This is a UUID scheme that only uses
  /// random numbers as the source of the generated UUID.
  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return
      '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
          '${_bitsDigits(16, 4)}-'
          '4${_bitsDigits(12, 3)}-'
          '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
          '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
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