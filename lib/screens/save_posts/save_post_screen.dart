import 'package:flutter/material.dart';

class SavePostScreen extends StatefulWidget {
  const SavePostScreen({Key? key}) : super(key: key);

  @override
  State<SavePostScreen> createState() => _SavePostScreenState();
}

class _SavePostScreenState extends State<SavePostScreen> {
  int favs = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          favs == 0
              ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/bloomIcon.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Not saved post yet",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
