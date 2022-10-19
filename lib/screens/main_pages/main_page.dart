import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pichere/screens/autthentication_screens/login.dart';
import 'package:pichere/screens/main_pages/verify_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snaphot) {
        if (snaphot.hasData) {
          return const VerifyEmailPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
