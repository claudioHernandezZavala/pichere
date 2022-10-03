import 'dart:io';

import "package:flutter/material.dart";

import '../../backend/location_services.dart';
import '../../models/post_models/post.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_divider.dart';

class PostInfo extends StatefulWidget {
  final File imagen;
  const PostInfo({Key? key, required this.imagen}) : super(key: key);

  @override
  State<PostInfo> createState() => _PostInfoState();
}

class _PostInfoState extends State<PostInfo> {
  String s = "";
  TextEditingController descriptionController = TextEditingController();
  double latitude = 0;
  double longitude = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                // if (latitude != 0 && longitude != 0) {
                setState(() {
                  postsTest.add(
                    Post(
                        description: descriptionController.text,
                        likes: 0,
                        comments: 0,
                        imgUrl:
                            "https://media.cntraveler.com/photos/53db21cf6dec627b14a1c453/master/pass/Times-Square-Tourist-Tips.jpg",
                        userId: "23",
                        postId: "45",
                        latitude: latitude,
                        longitude: longitude),
                  );
                });

                Navigator.of(context).popUntil((route) => route.isFirst);
                // }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.color1Background,
                  AppColors.color2Background
                ]),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Image container, I use two different containers to build a gradient background
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors: [
                              AppColors.color1Button,
                              AppColors.color2Button
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: FileImage(widget.imagen),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomDivider(
                  height: 1,
                  width: double.infinity,
                  color1: AppColors.color1Button,
                  color2: AppColors.color2Button,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                ),
                TextField(
                  maxLines: null,
                  controller: descriptionController,
                  minLines: 10,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: const InputDecoration(
                      hintText: "Write about this image!",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
                CustomDivider(
                  height: 2,
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  color1: AppColors.color1Button,
                  color2: AppColors.color2Button,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_pin,
                      size: 20,
                      color: Colors.red,
                    ),
                    Text(
                      "Add a location",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    final finalPos = await determineCurrentPosition();
                    final pos = await completePositionWithParam(finalPos);
                    latitude = finalPos.latitude;
                    longitude = finalPos.longitude;

                    s = "${pos.name!} , ${pos.street!},${pos.administrativeArea!}";

                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [
                          AppColors.color1Button,
                          AppColors.color2Button
                        ])),
                    child: Row(
                      children: [
                        const Icon(Icons.location_searching),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "${s.isNotEmpty ? "Modify" : "Add"} current location",
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                s.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(colors: [
                              Color(0xFFe0c3fc),
                              Color(0xFF8ec5fc)
                            ])),
                        child: Text(
                          s,
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                    : const SizedBox(),
                const Center(
                  child: Text(
                    "Or choose a recommendation",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (ctx, index) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Brooklyn, New York",
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
