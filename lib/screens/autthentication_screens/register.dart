import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pichere/utils/app_colors.dart';

import '../../backend/auth_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _key = GlobalKey<FormState>();
  bool _hidePassword = true;
  final authInstance = FirebaseAuth.instance;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirmation = TextEditingController();
  void signUpUser() async {
    await AuthServices(authInstance)
        .signUpWithEmail(
            email: _email.text, password: _password.text, context: context)
        .whenComplete(() {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  bool validateForm() {
    return _key.currentState!.validate() ? true : false;
  }

  void googleauthentication() {
    AuthServices(authInstance).googleSignIn(context).whenComplete(
          () => Navigator.of(context).pop(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                            controller: _email,
                            validator: (val) {
                              return val!.isEmpty
                                  ? "An email  must be provided."
                                  : null;
                            },
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
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please provide a password.";
                              }
                            },
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
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: _passwordConfirmation,
                            obscureText: _hidePassword,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please provide a password.";
                              } else if (val != _password.text) {
                                return "Your password must match.";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: " Confirm Password",
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

                          ///button to register
                          ElevatedButton(
                            onPressed: () async {
                              if (validateForm()) {
                                signUpUser();
                              }
                              // await AuthServices(authInstance).signingWithEmail(
                              //     email: _username.text,
                              //     password: _password.text,
                              //     context: context);
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
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            "Or sign up with",
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
                                onPressed: () async {
                                  googleauthentication();
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
                            "Already a member?",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (mounted) {
                                Navigator.of(context).pop();
                              }
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
