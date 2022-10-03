import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../utils/app_colors.dart';
import '../postProcess/post_detail.dart';

class gallery extends StatefulWidget {
  const gallery({Key? key}) : super(key: key);

  @override
  State<gallery> createState() => _galleryState();
}

class _galleryState extends State<gallery> {
  bool _loading = false;
  var file;
  List<Medium>? _media;

  @override
  void initState() {
    // TODO: implement initState
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
    return _loading
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
                    Container(
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
          );
  }
}

// class AlbumPage extends StatefulWidget {
//   final Album album;
//
//   AlbumPage(Album album) : album = album;
//
//   @override
//   State<StatefulWidget> createState() => AlbumPageState();
// }
//
// class AlbumPageState extends State<AlbumPage> {
//   List<Medium>? _media;
//
//   @override
//   void initState() {
//     super.initState();
//     initAsync();
//   }
//
//   void initAsync() async {
//     MediaPage mediaPage = await widget.album.listMedia();
//     setState(() {
//       _media = mediaPage.items;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: Text(widget.album.name ?? "Unnamed Album"),
//         ),
//         body: GridView.count(
//           crossAxisCount: 3,
//           mainAxisSpacing: 1.0,
//           crossAxisSpacing: 1.0,
//           children: <Widget>[
//             ...?_media?.map(
//               (medium) => GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   color: Colors.grey[300],
//                   child: FadeInImage(
//                     fit: BoxFit.cover,
//                     placeholder: MemoryImage(kTransparentImage),
//                     image: ThumbnailProvider(
//                       mediumId: medium.id,
//                       mediumType: medium.mediumType,
//                       highQuality: true,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
