import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pichere/widgets/alerts/alerts.dart';
import '../../models/post_models/post.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Dboperations {
  static Future<void> uploadPost(
      {required Post newpost, required BuildContext context}) async {
    final postCollection = FirebaseFirestore.instance.collection("posts");
    try {
      // imgUpload();
      await postCollection.add(newpost.toMap());
    } catch (e) {
      errorSnackBar(
          message: 'Something went wrong uploading your post',
          context: context);
    }
  }

  static Future<String> imgUpload(XFile imageToUpload) async {
    String imgUrl = "";
    try {
      final storageInstance = FirebaseStorage.instance;
      //i upload the file into a reference which is the folder and the name of the file,
      final fileToUpload = File(imageToUpload.path);
      //the method returns an uploadtask which provide a task snapshot with all the info of the uploaded task, such as the reference to the image and therefore the download url
      UploadTask task = storageInstance
          .ref("imgPosts/${basename(imageToUpload.path)}")
          .putFile(File(imageToUpload.path));
      task.then((TaskSnapshot snapinfo) async =>
          imgUrl = await snapinfo.ref.getDownloadURL());
    } catch (e) {}
    return imgUrl;
  }
}
