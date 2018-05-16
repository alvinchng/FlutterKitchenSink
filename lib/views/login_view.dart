import 'package:flutter/material.dart';
import 'base_view.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginState();
  }
  
}

class LoginState extends State<LoginView> {
  
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

  }

}