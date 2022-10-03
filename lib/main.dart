import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pichere/screens/autthentication_screens/login.dart';
import 'package:pichere/screens/autthentication_screens/register.dart';
import 'package:pichere/screens/main_pages/home_page.dart';
import 'package:pichere/screens/main_pages/main_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pic here',
      debugShowCheckedModeBanner: false,
      routes: {
        "homepage": (ctx) => const HomePage(),
        "loginpage": (ctx) => const LoginPage(),
        "registerpage": (ctx) => const RegisterPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}
