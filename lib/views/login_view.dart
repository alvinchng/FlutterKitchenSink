import 'package:flutter/material.dart';
import 'dart:async';
import 'base_view.dart';
import 'package:kitchensink/objs/obj_cell.dart';
import 'package:kitchensink/views/cells/cells.dart';
import 'package:kitchensink/utilities/login_manager.dart';
import 'package:kitchensink/utilities/utilities.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginState();
  }
  
}

class LoginState extends State<LoginView> {
  
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ObjCell> _dataSources;


  addDataSources() {

    ObjCell cell;
    _dataSources = new List();

    cell = new ObjCell();
    cell.type = ObjCellType.TextField;
    cell.identifier = 'username';
    cell.title = "Username";
    _dataSources.add(cell);

    cell = new ObjCell();
    cell.type = ObjCellType.TextField;
    cell.isTextProtected = true;
    cell.identifier = 'password';
    cell.title = "Password";
    _dataSources.add(cell);

    cell = new ObjCell();
    cell.type = ObjCellType.Button;
    cell.title = "Sign In";
    _dataSources.add(cell);


  }

  
  
  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      
      addDataSources();
    


  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    

    return new BaseView(
      scaffoldKey: _scaffoldKey,
      title: 'Login',
      child: new SafeArea(
                top: false,
                bottom: false,
                child: new Form(
                    key: _formKey,
                    child: new ListView.builder(
                      itemCount: _dataSources.length,
                      itemBuilder: (BuildContext context, int index) {
                        ObjCell item = _dataSources[index];
                        if (item.type == ObjCellType.TextField) {
                          
                          return new TextFieldCell(
                            obj: item,
                          );

                        }
                        else if (item.type == ObjCellType.Button) {
                          return new ButtonCell(
                            obj: item,
                            onPress: () async {
                              
                              if (_formKey.currentState.validate()) {
                                
                                Helper.progressHUD(context);

                                // _dataSources.forEach((cell){
                                //   print(cell.desc);
                                // });
                                final username = ObjCell.findByIdentifier(_dataSources, "username");
                                final password = ObjCell.findByIdentifier(_dataSources, 'password');

                                if (username.desc != null && password.desc != null) {
                                  LoginManager manager = await LoginManager.signInWithEmailAndPassword(username.desc, password.desc)
                                  .catchError((e) {
                                    //print(e.toString());
                                  });

                                  if (manager != null) {
                                    //print(manager.firebaseUser.providerData);
                                    Navigator.pop(context);
                                    Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> r) => false);
 
                                  }
                                  else {
                                    Navigator.pop(context);
                                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                      content: new Text('Authentication Failed.'),
                                    ));
                                  }

                                }
                                
                                // LoginManager manager = LoginManager.signInWithEmailAndPassword(email, password);
                                
                                
                                

                              }

                            },
                          );
                        }
                        else {
                          return new Text(item.title);
                        }
                        

                      },

                    )
                ),
            ),
    );

    /*
    return new Form(
      key: _formKey,
      child: new BaseView(
              title: "Login",
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Username'
                      ),
                      validator: (value){
                        if (value.isEmpty) {
                          return 'This field is compulsory.';
                        }
                      }),
                      new TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value){
                        if (value.isEmpty) {
                          return 'This field is compulsory.';
                        }
                      }),
                      new Center(
                        child: new Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: new RaisedButton(
                              color: Colors.black45,
                              child: new Text("Sign In", style: new TextStyle(color: Colors.white),),
                              onPressed: () {
                              if (_formKey.currentState.validate()) {
                                
                                _formKey.currentState.save();
                                Navigator.pop(context);

                              }
                              },
                            ),
                          ),
                      ),
                      
                      
                  ],
                ),
              )
            ),
    );
  */
  }

}





