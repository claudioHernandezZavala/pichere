import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../utils/app_colors.dart';
import '../postProcess/post_detail.dart';
import 'camera_screen.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({Key? key}) : super(key: key);

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  bool _loading = false;
  var file;
  List<Medium>? _media;
  bool imgTooked = true;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      MediaPage mediaPage = await albums[0].listMedia(newest: true);

      setState(() {
        _loading = false;
        _media = mediaPage.items;
      });
    }

    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                double gridWidth = (constraints.maxWidth - 20) / 3;
                double gridHeight = gridWidth + 50;
                double ratio = gridWidth / gridHeight;
                return Container(
                  padding: const EdgeInsets.all(5),
                  child: GridView.count(
                    childAspectRatio: ratio,
                    crossAxisCount: 3,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              reverseTransitionDuration:
                                  const Duration(milliseconds: 550),
                              transitionDuration:
                                  const Duration(milliseconds: 1500),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> anim2,
                                  Widget child) {
                                animation = CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.fastLinearToSlowEaseIn);
                                return ScaleTransition(
                                  scale: animation,
                                  alignment: const Alignment(-0.85, -0.50),
                                  child: child,
                                );
                              },
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secAnimation) {
                                return const CameraScreen();
                              }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.color1Button,
                                AppColors.color2Button,
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ...?_media?.map(
                        (medium) => GestureDetector(
                          onTap: () async {
                            final File file =
                                await PhotoGallery.getFile(mediumId: medium.id);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PostInfo(imagen: file)));
                          },
                          child: Container(
                            color: Colors.grey[300],
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: MemoryImage(kTransparentImage),
                              image: ThumbnailProvider(
                                mediumId: medium.id,
                                mediumType: medium.mediumType,
                                highQuality: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
