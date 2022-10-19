import 'dart:io';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/app_colors.dart';
import '../postProcess/post_detail.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with TickerProviderStateMixin {
  bool backPressed = false;
  late AnimationController controllerToIncreasingCurve;
  late AnimationController controllerToDecreasingCurve;
  late Animation<double> animationToIncreasingCurve;
  late Animation<double> animationToDecreasingCurve;
  XFile? imageFile;
  bool picTook = false;

  @override
  void initState() {
    controllerToIncreasingCurve =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controllerToDecreasingCurve =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationToIncreasingCurve = Tween<double>(begin: 500, end: 0).animate(
        CurvedAnimation(
            parent: controllerToIncreasingCurve,
            curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {});
      });
    animationToDecreasingCurve = Tween<double>(begin: 0, end: 900).animate(
        CurvedAnimation(
            parent: controllerToIncreasingCurve,
            curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {});
      });
    controllerToIncreasingCurve.forward();
    openCamera();
    super.initState();
  }

  Future<void> openCamera() async {
    var permission = Permission.camera.status;
    var permission2 = Permission.storage.status;

    if (await permission.isDenied) {
      await Permission.camera.request();
    } else {}
    if (await permission2.isDenied) {
      await Permission.storage.request();
    }
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      file != null ? imageFile = file : null;
      file != null ? picTook = true : null;
    });
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          backPressed = true;
        });
        controllerToDecreasingCurve.forward();

        return true;
      },
      child: ClipRRect(
        borderRadius: backPressed == false
            ? BorderRadius.circular(animationToIncreasingCurve.value)
            : BorderRadius.only(
                bottomRight: Radius.circular(animationToDecreasingCurve.value),
                bottomLeft: Radius.circular(animationToDecreasingCurve.value)),
        // borderRadius: BorderRadius.circular(backPressed == false
        //     ? animationToIncreasingCurve.value
        //     : animationToDecreasingCurve.value),
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Text("second screen"),
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                imageFile == null
                    ? Container()
                    : Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.fitWidth,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                Column(
                  children: [
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: picTook
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          picTook
                              ? const Spacer(
                                  flex: 3,
                                )
                              : const SizedBox(),
                          Padding(
                            padding: EdgeInsets.only(left: picTook ? 50 : 0),
                            child: FloatingActionButton(
                              onPressed: () async {
                                var permission = Permission.camera.status;
                                var permission2 = Permission.storage.status;

                                if (await permission.isDenied) {
                                  await Permission.camera.request();
                                } else {}
                                if (await permission2.isDenied) {
                                  await Permission.storage.request();
                                }
                                final picker = ImagePicker();
                                XFile? file = await picker.pickImage(
                                    source: ImageSource.camera);
                                setState(() {
                                  file != null ? imageFile = file : null;
                                  file != null ? picTook = true : null;
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(colors: [
                                      AppColors.color1Button,
                                      AppColors.color2Button
                                    ])),
                                child: Icon(
                                  picTook ? Icons.repeat : Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          picTook
                              ? const Spacer(
                                  flex: 1,
                                )
                              : const SizedBox(),
                          picTook
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => PostInfo(
                                                  imagen: File(imageFile!.path),
                                                )));
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 50,
                                    margin: const EdgeInsets.only(right: 25),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: RadialGradient(colors: [
                                        AppColors.color1Button,
                                        AppColors.color2Button
                                      ]),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        CupertinoIcons.right_chevron,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child:
                    // ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
