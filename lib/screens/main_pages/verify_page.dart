import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pichere/backend/auth_services.dart';
import 'package:pichere/screens/main_pages/home_screen.dart';
import 'package:pichere/utils/app_colors.dart';
import 'package:pichere/widgets/alerts/alerts.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool accountVerified = false;
  bool canResendIt = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.reload();
    accountVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (accountVerified == false) {
      sendVerification();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
  }

  void checkEmailVerified() async {
    //call after email verification
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      accountVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (accountVerified) {
      ///check if the user data exist or is written in the database, if it is not it calls the function write user data
      bool userDataWritten = await FirebaseFirestore.instance
          .collection("users/")
          .doc("${FirebaseAuth.instance.currentUser?.uid}")
          .snapshots()
          .isEmpty;
      if (!userDataWritten) {
        AuthServices(FirebaseAuth.instance).writeUserData();
      }
      timer?.cancel();
    }
  }

  void sendVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        canResendIt = false;
      });
      await Future.delayed(const Duration(seconds: 10));
      setState(() {
        canResendIt = true;
      });
    } on FirebaseAuthException catch (e) {
      errorSnackBar(message: e.code, context: context);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return accountVerified
        ? const HomeScreen()
        : Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                AppColors.color1Background,
                AppColors.color2Background
              ])),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        "assets/images/fast-food.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 300,
                        height: 250,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Please verify your email to continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                sendVerification();
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Container(
                                width: 250,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.color1Button,
                                      AppColors.color2Button
                                    ],
                                  ),
                                ),
                                child: const Text("Resent verification email"),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Container(
                                width: 250,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.negativeColor1,
                                      AppColors.negativeColor2,
                                      // AppColors.negativeColor3
                                    ],
                                  ),
                                ),
                                child: const Text("Cancel"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
