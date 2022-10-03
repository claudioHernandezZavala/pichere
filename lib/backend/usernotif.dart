import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserNotifier extends ChangeNotifier {
  int numero = 0;
  bool verified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;
  final FirebaseAuth userAuth = FirebaseAuth.instance;
  void listenChanges() {
    userAuth.authStateChanges().listen((event) {
      verified = event?.emailVerified ?? false;
      notifyListeners();
    });
  }
}
