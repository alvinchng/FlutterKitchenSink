///
/// Helper class that ensures a Widget is visible when it has the focus
/// For example, for a TextFormField when the keyboard is displayed
/// 
/// How to use it:
/// 
/// In the class that implements the Form,
///   Instantiate a FocusNode
///   FocusNode _focusNode = new FocusNode();
/// 
/// In the build(BuildContext context), wrap the TextFormField as follows:
/// 
///   new EnsureVisibleWhenFocused(
///     focusNode: _focusNode,
///     child: new TextFormField(
///       ...
///       focusNode: _focusNode,
///     ),
///   ),
/// 
/// Initial source code written by Collin Jackson.
/// Extended (see highlighting) to cover the case when the keyboard is dismissed and the
/// user clicks the TextFormField/TextField which still has the focus.
/// 
/// 
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';


class FocusNodeManager extends StatefulWidget {
  
  /// The node we will monitor to determine if the child is focused
  final FocusNode focusNode;

  /// The child widget that we are wrapping
  final Widget child;

  /// The curve we will use to scroll ourselves into view.
  ///
  /// Defaults to Curves.ease.
  final Curve curve;

  /// The duration we will use to scroll ourselves into view
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  const FocusNodeManager({
    Key key,
    @required this.child,
    @required this.focusNode,
    this.curve: Curves.ease,
    this.duration : const Duration(milliseconds: 100)
  }) : super(key: key); 
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FocusNodeState();
  }

}

class FocusNodeState extends State<FocusNodeManager> implements WidgetsBindingObserver {
  
  Future <Null> _ensureVisible() async {

    // Wait for the keyboard to come into view
    await new Future.delayed(const Duration(milliseconds: 300));

    // No need to go any further if the node has not the focus
    if (!widget.focusNode.hasFocus){
      return;
    }

    // Find the object which has the focus
    final RenderObject object = context.findRenderObject();
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);
    assert(viewport != null);

    // Get the Scrollable state (in order to retrieve its offset)
    ScrollableState scrollableState = Scrollable.of(context);
    assert(scrollableState != null);

    // Get its offset
    ScrollPosition position = scrollableState.position;
    double alignment;

    if (position.pixels > viewport.getOffsetToReveal(object, 0.0)) {
      // Move down to the top of the viewport
      alignment = 0.0;
    } else if (position.pixels < viewport.getOffsetToReveal(object, 1.0)){
      // Move up to the bottom of the viewport
      alignment = 1.0;
    } else {
      // No scrolling is necessary to reveal the child
      return;
    }

    position.ensureVisible(
      object,
      alignment: alignment,
      duration: widget.duration,
      curve: widget.curve,
    );

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.child;
  }

  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      widget.focusNode.addListener(_ensureVisible);
      WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
      // TODO: implement dispose
      widget.focusNode.removeListener(_ensureVisible);
      WidgetsBinding.instance.removeObserver(this);

      super.dispose();
    
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
  }

  @override
  void didChangeLocale(Locale locale) {
    // TODO: implement didChangeLocale
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    if (widget.focusNode.hasFocus) {
      _ensureVisible();
    }
  }

  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didHaveMemoryPressure() {
    // TODO: implement didHaveMemoryPressure
  }

  @override
  Future<bool> didPopRoute() {
    // TODO: implement didPopRoute
    
    
  }

  @override
  Future<bool> didPushRoute(String route) {
    // TODO: implement didPushRoute
  }



}