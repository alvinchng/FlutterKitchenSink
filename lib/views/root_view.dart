import 'dart:async';

import 'package:flutter/material.dart';
import 'task_view.dart';
import 'package:kitchensink/utilities/data_manager.dart' as DM;
import 'package:kitchensink/objs/obj_parser.dart';
import 'package:kitchensink/utilities/login_manager.dart';
import 'package:kitchensink/objs/obj_cell.dart';
import 'package:kitchensink/views/cells/label_cell.dart';
import 'package:kitchensink/utilities/helper.dart';

class RootView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RootViewState();
  }

}

class RootViewState extends State<RootView> {

  List<ObjCell> _dataSources;
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;

  bool _onNotification(ScrollNotification notification) {

    if (notification is ScrollUpdateNotification) {
      // print('onNotification');
      // print('max:${_scrollController.mostRecentlyUpdatedPosition.maxScrollExtent}  offset:${_scrollController.offset}');
      // 当滑动到底部的时候，maxScrollExtent和offset会相等
      // when scroll to the bottom, maxScrollExtent will equal to offset
      // if (_scrollController.mostRecentlyUpdatedPosition.maxScrollExtent >
      //         _scrollController.offset &&
      //     _scrollController.mostRecentlyUpdatedPosition.maxScrollExtent -
      //             _scrollController.offset <=
      //         50) {
                
      //   // 要加载更多
      //   if (this.isMore && this.loadMoreStatus != LoadMoreStatus.loading) {
      //     // 有下一页 if have more data and not loading
      //     print('load more');
      //     this.loadMoreStatus = LoadMoreStatus.loading;
      //     _loadMoreData();
      //     setState(() {});
      //   } else {}
      // }

      //print('max: ${_scrollController.position.maxScrollExtent} offset:${_scrollController.offset}');
      
      // scroll down detection.
      if (_scrollController.offset > _scrollController.position.maxScrollExtent &&
          _scrollController.position.maxScrollExtent - _scrollController.offset <= -100) {
        //print(_scrollController.position.maxScrollExtent - _scrollController.offset);
        if (!_isLoading) {
          print("loading ....");
          _isLoading = true;
          Helper.progressHUD(context);

          new Future.delayed(new Duration(seconds: 5), () {
            _isLoading = false;
            print("stop ....");
            Navigator.pop(context);
            //_login();
          });
          
        }

      }

      

    }

    return true;

  }

  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      addDataSources();
      

  }

  @override
  void dispose() {
      // TODO: implement dispose
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await LoginManager.signOut();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> r) => false);
            },
          )
        ],
      ),
      floatingActionButton: new SafeArea(
        child: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
          _actionTapped(context);
        },),
      ),
      body: new NotificationListener(
        onNotification: _onNotification,
        child: new RefreshIndicator(
          onRefresh: _onRefresh,
          child: new ListView.builder(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: _dataSources.length,
                itemBuilder: (BuildContext context, int index) {
                  ObjCell item = _dataSources[index];
                  if (item.type == ObjCellType.Label) {
                    
                    return new LabelCell(
                      obj: item,
                    );

                  }
                  else {
                    return new Container();
                  }
                  

                },

              ), 
          ),
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

  Future<Null> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();
    Timer timer = new Timer(Duration(seconds: 3), () => completer.complete());
    return completer.future;
  }

  addDataSources() {

    ObjCell cell;
    _dataSources = new List();

    cell = new ObjCell();
    cell.type = ObjCellType.Label;
    cell.title = "Test 1";
    cell.desc = "hahahah";
    _dataSources.add(cell);

    cell = new ObjCell();
    cell.type = ObjCellType.Label;
    cell.title = "Test 1";
    cell.desc = "hahahah";
    _dataSources.add(cell);


  }


} 


