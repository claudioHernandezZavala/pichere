import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:path/path.dart';
import 'package:pichere/backend/firebase_backend/database_functions.dart';
import 'package:pichere/widgets/alerts/alerts.dart';
import 'package:uuid/uuid.dart';

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
  bool locationGiven = false;
  bool wasready = false;
  bool loading = false;

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
                //.post cannot be made if the location was not given
                postfunctionCallBack(context);
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
                  margin: const EdgeInsets.only(top: 20, bottom: 15),
                ),
                TextField(
                  maxLines: null,
                  controller: descriptionController,
                  minLines: 10,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
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

                /// location function button =============================================
                GestureDetector(
                  onTap: () async {
                    locationFunction(context);
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
                          s.isNotEmpty ? "Modify" : "Add current location",
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// functions

  void locationFunction(BuildContext context) async {
    try {
      final finalPos = await determineCurrentPosition();
      final pos = await completePositionWithParam(finalPos);
      latitude = finalPos.latitude;
      longitude = finalPos.longitude;

      setState(() {
        s = "${pos.name!} , ${pos.street!},${pos.administrativeArea!}";
      });
      setState(() {
        locationGiven = true;
      });
    } catch (e) {
      errorSnackBar(message: e.toString(), context: context);
    }
  }

  ///callback function tthat calls the upload function from the db class to set a new post, the location must not be null
  void postfunctionCallBack(BuildContext context) async {
    //post cannot be made if the location was not given

    if (latitude != 0 && longitude != 0 && locationGiven) {
      //I use the db operations class in backend folder to uppload a given post to the database

      snackBarFunction(context).whenComplete(() {
        if (wasready) {
          print('ready');
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      });
    } else {
      errorSnackBar(message: 'Update your location first', context: context);
    }
  }

  ///show a snackbar with a circular progress bar when the post is uploaded
  Future<void> snackBarFunction(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context2) {
          return StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              height: 350,
              child: AlertDialog(
                elevation: 10,
                actions: [
                  loading
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            Navigator.of(context2).pop();
                          },
                          icon: const Icon(Icons.one_x_mobiledata),
                          color: Colors.red,
                        ),
                  loading
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            Future.delayed(
                              const Duration(seconds: 3),
                              () async {
                                Dboperations.uploadPost(
                                        newpost: Post(
                                          description:
                                              descriptionController.text,
                                          likes: 0,
                                          imgUrls: [
                                            "https://media.cntraveler.com/photos/53db21cf6dec627b14a1c453/master/pass/Times-Square-Tourist-Tips.jpg",
                                          ],
                                          userUid: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          postId: await const Uuid().v4(),
                                          latitude: latitude,
                                          longitude: longitude,
                                          geoPoint:
                                              GeoPoint(latitude, longitude),
                                        ),
                                        context: context)
                                    .whenComplete(() {
                                  this.setState(() {
                                    wasready = true;
                                  });
                                  Navigator.of(context2).pop();
                                });
                              },
                            );
                          },
                          icon: const Icon(Icons.one_x_mobiledata),
                          color: Colors.red,
                        )
                ],
                content: loading
                    ? Center(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/bloomIcon.png",
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              const Text("Sharing your new pic!"),
                              const SizedBox(
                                height: 25,
                              ),
                              const CircularProgressIndicator(
                                color: Colors.pink,
                              )
                            ],
                          ),
                        ),
                      )
                    : const Text("Ready to share this place?"),
              ),
            );
          });
        });
  }
}
