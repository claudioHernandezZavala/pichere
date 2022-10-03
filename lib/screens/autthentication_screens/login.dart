import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pichere/utils/app_colors.dart';

import '../../backend/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey();
  bool _hidePassword = true;
  final authInstance = FirebaseAuth.instance;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  void signInUser() async {
    await AuthServices(FirebaseAuth.instance).signingWithEmail(
        email: _username.text, password: _password.text, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1Background, AppColors.color2Background],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.color1Background, AppColors.color2Background],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image.asset(
              //   "assets/images/newyorklogin.png",
              //   width: 50,
              //   height: 50,
              // ),
              Form(
                  key: _key,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(25),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _username,
                            decoration: const InputDecoration(
                              hintText: "Email",
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: _password,
                            obscureText: _hidePassword,
                            decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _hidePassword = !_hidePassword;
                                    });
                                  },
                                  icon: _hidePassword
                                      ? const Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.blue,
                                        )
                                      : const Icon(
                                          Icons.hide_source,
                                          color: Colors.red,
                                        ),
                                )),
                          ),
                          const SizedBox(height: 15),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              //function to reset password
                              onTap: () {},
                              child: RichText(
                                textAlign: TextAlign.end,
                                text: const TextSpan(
                                    text: "Forgot password?",
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: " Click here",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          ///button to login
                          ElevatedButton(
                            onPressed: () async {
                              signInUser();
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
                              child: const Text("Login"),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            "Or sign in with",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  AuthServices(FirebaseAuth.instance)
                                      .googleSignIn(context);
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.apple,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Not a member yet?",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('registerpage');
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
                              child: const Text("Register"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
