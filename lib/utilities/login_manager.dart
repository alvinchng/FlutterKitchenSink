import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kitchensink/utilities/utilities.dart';
import 'package:kitchensink/objs/obj_user.dart';

import 'dart:async';

class LoginManager {

  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseUser firebaseUser;

  LoginManager(FirebaseUser user) {
    this.firebaseUser = user;
    if (DataManager().user == null) {
      DataManager().user = new ObjUser();
    }
    DataManager().user.email = user.email;
    DataManager().user.displayName = user.displayName;

  }

  // Methods
  static Future<bool> isSignIn() async {

    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) {
      return false;
    }
    else {
      LoginManager(currentUser);
    }

    return true;

  }

  static Future<LoginManager> signInWithEmailAndPassword(String email, String password) async {

    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) {

      currentUser = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      
      return LoginManager(currentUser);
    }
    else {
      
      return LoginManager(currentUser);
    }

  }

  static Future<LoginManager> signInWithGoogle() async {
  

  GoogleSignInAccount user = _googleSignIn.currentUser;
  if (user == null) {
    user = await _googleSignIn.signInSilently();
    
  }
  if (user == null) {
    user = await _googleSignIn.signIn();
    //analytics.logLogin();
    
  }

  FirebaseUser currentUser = await _auth.currentUser();
  if (currentUser == null) {
    GoogleSignInAuthentication googleAuth = await user.authentication;

    currentUser = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    
    return LoginManager(currentUser);
  }
  else {
    
    return LoginManager(currentUser);
  }
  
  
  

/*    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    

    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    
    //assert(user.email != null);
    //assert(user.displayName != null);

    //assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    //assert(user.uid == currentUser.uid);
    

    return LoginManager(currentUser);
*/
  }

  static Future<bool> signOut() async {
    return await _auth.signOut();
  }

}