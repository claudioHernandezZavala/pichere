import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pichere/screens/autthentication_screens/login.dart';
import 'package:pichere/utils/app_colors.dart';

import '../../models/post_models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color1Background,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFdad4ec),
                  Color(0xFFf3e7e9),
                ],
              ),
            ),
          ),
          NestedScrollView(
            headerSliverBuilder: (_, index) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  elevation: 25,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const LoginPage()));
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () async {
                    //     await FirebaseAuth.instance.signOut();
                    //   },
                    //   icon: const Icon(
                    //     Icons.search_rounded,
                    //     color: Colors.red,
                    //   ),
                    // ),
                  ],
                )
              ];
            },
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 25),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 25),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.location_pin,
                          color: Colors.black,
                        ),
                        Text(
                          "New york",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: postsTest.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        height: 350,
                        margin: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            // image: DecorationImage(
                            //     image: NetworkImage(postsTest[index].imgUrl),
                            //     fit: BoxFit.fill),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                              )
                            ]),
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(25),
                          child: Stack(
                            children: [
                              Image.network(
                                postsTest[index].imgUrls[0],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              const Positioned(
                                top: 10,
                                left: 10,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage("assets/images/face.jfif"),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                          ),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.comment,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.favorite_border,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(postsTest[index]
                                                  .likes
                                                  .toString())
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.transparent,
      //   child: Container(
      //     width: 60,
      //     height: 60,
      //     decoration: const BoxDecoration(
      //         shape: BoxShape.circle,
      //         gradient: LinearGradient(
      //             colors: [Color(0xFF4facfe), Color(0xFF00f2fe)])),
      //     child: const Icon(
      //       Icons.camera_alt,
      //       color: Colors.black,
      //     ),
      //   ),
      //   onPressed: () {
      //     Navigator.of(context).push(PageRouteBuilder(
      //         opaque: false,
      //         reverseTransitionDuration: const Duration(milliseconds: 550),
      //         transitionDuration: const Duration(milliseconds: 1500),
      //         transitionsBuilder: (BuildContext context,
      //             Animation<double> animation,
      //             Animation<double> anim2,
      //             Widget child) {
      //           animation = CurvedAnimation(
      //               parent: animation, curve: Curves.fastLinearToSlowEaseIn);
      //           return ScaleTransition(
      //             scale: animation,
      //             alignment: const Alignment(0.0, 0.87),
      //             child: child,
      //           );
      //         },
      //         pageBuilder: (BuildContext context, Animation<double> animation,
      //             Animation<double> secAnimation) {
      //           return const PickImageScreen();
      //         }));
      //     // end of function ==============================
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //   backgroundColor: Colors.white.withOpacity(0.8),
      //   activeColor: Colors.white,
      //   backgroundGradient: const LinearGradient(
      //       colors: [Color(0xFF6a11cb), Color(0xFF2575fc)]),
      //   icons: const [Icons.home, Icons.bookmark, Icons.list, Icons.person],
      //   gapLocation: GapLocation.center,
      //   inactiveColor: Colors.black,
      //   hideAnimationCurve: Curves.ease,
      //   borderWidth: 10,
      //   notchMargin: 5,
      //   notchSmoothness: NotchSmoothness.verySmoothEdge,
      //   leftCornerRadius: 25,
      //   rightCornerRadius: 25,
      //   safeAreaValues:
      //       const SafeAreaValues(right: true, left: true, top: true),
      //   blurEffect: true,
      //   onTap: (value) {
      //     setState(() {
      //       index = value;
      //     });
      //   },
      //   activeIndex: index,
      // ),
    );
  }
}
