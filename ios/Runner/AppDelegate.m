#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.

  /// --------------------------------------------
  /// Communication Interface
  /// --------------------------------------------
  FlutterViewController *controller = (FlutterViewController*)self.window.rootViewController;
  FlutterMethodChannel *nativeCall = [FlutterMethodChannel methodChannelWithName:@"kitchensink.flutter.io/nativecall" 
                                      binaryMessenger:controller];

  [nativeCall setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result)
  {
    if ([@"sayHello" isEqualToString:call.method]) {
        
        NSString *helloResult = @"Hello World From Native Callback....";
        result(helloResult);
    }
    else {
        result(FlutterMethodNotImplemented);
    }
  }];

  FlutterEventChannel* chargingChannel = [FlutterEventChannel
      eventChannelWithName:@"kitchensink.flutter.io/charging"
           binaryMessenger:controller];
  [chargingChannel setStreamHandler:self];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
