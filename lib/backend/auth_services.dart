import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/alerts/alerts.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth _auth;
  AuthServices(this._auth);

  ///EMAIL SIGN UP WITH FIREBASE, PROVIDE : EMAIL, PASSWORD
  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      confirmationSnackBar(message: "User created", context: context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
        backgroundColor: Colors.red,
      ));
    }
  }

  ///email verification
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      confirmationSnackBar(message: e.toString(), context: context);
    }
  }

  ///sign in with email and password
  Future<void> signingWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  ///login or register with google
  Future<UserCredential?> googleSignIn(BuildContext context) async {
    User? user;
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    bool isNew = false;
    UserCredential? userCredential;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication auth =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken);

      try {
        userCredential = await _auth.signInWithCredential(credential);
        user = userCredential.user;

        if (userCredential.additionalUserInfo!.isNewUser) {
          isNew = true;
        } else {
          isNew = false;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              e.code,
              style:
                  const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
            ),
          ));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              e.code,
              style:
                  const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
            ),
          ));
          // handle the error here
        } else {
          errorSnackBar(message: e.code, context: context);
        }
      }
    }
    // if (isNew) {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (ctx) => VerifyEmailPage()));
    // } else {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (ctx) => HomePage()), (route) => false);
    // }

    return userCredential;
  }

  ///facebook sign in and sign up

}
