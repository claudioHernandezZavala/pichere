import 'package:flutter/material.dart';

import '../screens/photo_screens/pick_image_screen.dart';

///Home page button to upload images
FloatingActionButton homePageButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: Colors.transparent,
    child: Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)])),
      child: const Icon(
        Icons.camera_alt,
        color: Colors.black,
      ),
    ),
    onPressed: () {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          reverseTransitionDuration: const Duration(milliseconds: 550),
          transitionDuration: const Duration(milliseconds: 1500),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> anim2,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation, curve: Curves.fastLinearToSlowEaseIn);
            return ScaleTransition(
              scale: animation,
              alignment: const Alignment(0.0, 0.87),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return const PickImageScreen();
          }));
      // end of function ==============================
    },
  );
}

///category floating button
FloatingActionButton CategoryButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: Colors.transparent,
    child: Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)])),
      child: const Icon(
        Icons.ac_unit,
        color: Colors.black,
      ),
    ),
    onPressed: () {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          reverseTransitionDuration: const Duration(milliseconds: 550),
          transitionDuration: const Duration(milliseconds: 1500),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> anim2,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation, curve: Curves.fastLinearToSlowEaseIn);
            return ScaleTransition(
              scale: animation,
              alignment: const Alignment(0.0, 0.87),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return const PickImageScreen();
          }));
      // end of function ==============================
    },
  );
}

///save post button screen
FloatingActionButton savePageButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: Colors.transparent,
    child: Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)])),
      child: const Icon(
        Icons.camera_alt,
        color: Colors.black,
      ),
    ),
    onPressed: () {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          reverseTransitionDuration: const Duration(milliseconds: 550),
          transitionDuration: const Duration(milliseconds: 1500),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> anim2,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation, curve: Curves.fastLinearToSlowEaseIn);
            return ScaleTransition(
              scale: animation,
              alignment: const Alignment(0.0, 0.87),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return const PickImageScreen();
          }));
      // end of function ==============================
    },
  );
}
