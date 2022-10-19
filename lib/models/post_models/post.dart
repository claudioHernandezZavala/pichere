import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final List<String> imgUrls;
  final int likes;
  final String userUid;

  final String description;
  final String postId;
  final double latitude;
  final double longitude;
  final GeoPoint geoPoint;

  Post(
      {required this.description,
      required this.likes,
      required this.imgUrls,
      required this.userUid,
      required this.postId,
      required this.latitude,
      required this.longitude,
      required this.geoPoint});
  Map<String, dynamic> toMap() => {
        "imgUrls": imgUrls,
        'likes': likes,
        'userUid': userUid,
        'description': description,
        'postId': postId,
        'latitude': latitude,
        'longitude': longitude,
        'geopoint': geoPoint
      };
}

List<Post> postsTest = [
  Post(
    description: "A fine place in Time square",
    likes: 25,
    imgUrls: [
      "https://media.cntraveler.com/photos/53db21cf6dec627b14a1c453/master/pass/Times-Square-Tourist-Tips.jpg",
    ],
    postId: "ss",
    userUid: "sa",
    latitude: 15,
    longitude: 15,
    geoPoint: GeoPoint(10, 10),
  ),
  Post(
    description: "A fine place in Time square",
    likes: 25,
    imgUrls: [
      "https://media.cntraveler.com/photos/53db21cf6dec627b14a1c453/master/pass/Times-Square-Tourist-Tips.jpg",
    ],
    postId: "ss",
    userUid: "sa",
    latitude: 15,
    longitude: 15,
    geoPoint: GeoPoint(10, 10),
  ),
  Post(
    description: "A fine place in Time square",
    likes: 25,
    imgUrls: [
      "https://media.cntraveler.com/photos/53db21cf6dec627b14a1c453/master/pass/Times-Square-Tourist-Tips.jpg",
    ],
    postId: "ss",
    userUid: "sa",
    latitude: 15,
    longitude: 15,
    geoPoint: GeoPoint(10, 10),
  ),
];
