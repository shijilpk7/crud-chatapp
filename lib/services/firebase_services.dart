import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
//call very time when sign in button clicked
  Future<bool> googleLogin() async {
    try {
      print('blah:0');
      //call account selection popup
      final googleUser = await googleSignIn.signIn();
      print('blah:0.5');
      //check account selected
      if (googleUser == null) {
        print('blah:');
        return false;
      }
      ;
      //assign the selected account
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      print('blah:1');
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('blah:2');
      notifyListeners();
      return true;
    } catch (e) {
      print('blah:-1');
      print('exception:${e.toString()}');
      return false;
    }
  }
  

  Future logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
