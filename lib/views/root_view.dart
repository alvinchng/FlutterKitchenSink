import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'task_view.dart';
import 'package:kitchensink/objs/obj_parser.dart';
import 'package:kitchensink/utilities/login_manager.dart';
import 'package:kitchensink/objs/obj_cell.dart';
import 'package:kitchensink/views/cells/cells.dart';
import 'package:kitchensink/utilities/utilities.dart';
import 'package:kitchensink/models/task_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  

  bool _isLoading = false;

  //File _image;

  Future getImage() async {
    
    File image = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 1080.0).catchError((e) => print(e));
    int length = await image.length();

    if (length > 0) {
      String uuidFilename = Uuid().generateV4()+'.jpg';
      final StorageReference ref = FirebaseStorage.instance.ref().child('test').child(uuidFilename);
      final StorageFileUploadTask uploadTask = ref.putFile(image);
      final Uri downloadURL = (await uploadTask.future).downloadUrl;
      

      print(downloadURL.toString());
    }
    
    
    
    
  }

  bool _onNotification(ScrollNotification notification) {
    

    if (notification is ScrollUpdateNotification) {

      
      if (_scrollController.position.extentAfter <= 0) {
        
          if (_dataSources.length > 0 && !_isLoading) {
            
            _isLoading = true;
            _scaffoldKey.currentState.showSnackBar(new SnackBar(
              duration: Duration(seconds: 3),
              content: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  new Container(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                    child: new Text("Loading..."),
                  )
                ],
              ),
            ));

            ObjCell lastCell = _dataSources[_dataSources.length-1];
            TaskModel.fetchAppendData(lastCell, (result){
              
              setState(() {
                if (result is List) {
                  result.forEach((item){
                    if (item is ObjCell) {
                      
                      _dataSources.add(item);
                    }
                  });
                  
                }
              });

              new Future.delayed(new Duration(seconds: 5), () {
                _isLoading = false;
              });

              
            }, (){
              new Future.delayed(new Duration(seconds: 5), () {
                _isLoading = false;
              });
            });

          }


      }
      
      // IOS ONLY ----
      // if (_scrollController.offset > _scrollController.position.maxScrollExtent &&
      //     _scrollController.position.maxScrollExtent - _scrollController.offset <= -60) {
        
      //   if (!_isLoading) {
      //     print("loading ....");
      //     _isLoading = true;
      //     Helper.progressHUD(context);

      //     new Future.delayed(new Duration(seconds: 5), () {
      //       _isLoading = false;
      //       print("stop ....");
      //       Navigator.pop(context);
      //       //_login();
      //     });
          
      //   }

      // }

      

    }

    return true;

  }

  

  @override
  void initState() {
      // TODO: implement initState
      super.initState();

      _dataSources = new List();
      loadDataSources();

  }

  @override
  void dispose() {
      // TODO: implement dispose
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    
    List<Widget> views = new List();

    if (_isLoading) {
      views.addAll(<Widget>[
        CircularProgressIndicator()
      ]);
    }
    else {
      views.addAll(<Widget>[
        Text("No Record."),
        RaisedButton(child: Text("Refresh."), onPressed: () {
          loadDataSources();
        },)
      ]);
    }


    Widget emptyView = new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: views
      ),
    );

    Widget listView = new NotificationListener(
        onNotification: _onNotification,
        child: new RefreshIndicator(
          key: _refreshIndicatorKey,
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
      );

    
    // TODO: implement build
    return new Scaffold(
      key: _scaffoldKey,
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
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(DataManager().user.displayName),
              accountEmail: Text(DataManager().user.email),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/kitchensink-646c1.appspot.com/o/test%2Ffbec50ed-5618-4127-9343-a183d9b3722f.jpg?alt=media&token=7a23014c-97ee-4803-8362-b9600fa1fb80')
                ),
              ),
            ),   
            new ListTile(
              title: Text('First Page'),
              trailing: Icon(Icons.arrow_upward),
            ),
            new ListTile(
              title: Text('Second Page'),
              trailing: Icon(Icons.arrow_forward),
            ),
            new Divider(),
            new ListTile(
              title: Text('Close'),
              trailing: Icon(Icons.cancel),
            ),
          ],
        ),
      ),
      floatingActionButton: new SafeArea(
        child: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
          _actionTapped(context);
          //getImage();
        },),
      ),
      body: (_dataSources.length > 0) ? listView : emptyView
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
    //Timer timer = new Timer(Duration(seconds: 3), () => completer.complete());
    loadDataSources(completer);

    return completer.future;
  }

  loadDataSources([Completer completer]) {
    
    
    setState(() {
      _isLoading = true;
    });
    
    
    TaskModel.fetchData((result){
      
      if (completer != null) {
        completer.complete();
      }

      setState(() {
        _isLoading = false;
        if (result is List) {
          _dataSources = result;
        }
      });
    }, (){
      
      if (completer != null) {
        completer.complete();
      }

      setState(() {
        _isLoading = false;
            });
    });

    // new Future.delayed(new Duration(seconds: 3), () {
      
    //   setState(() {
    //     _isLoading = false;
    //         });
    // });

    


  }


} 


