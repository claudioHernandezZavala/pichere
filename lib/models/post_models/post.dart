class Post {
  final String description;
  final int likes;
  final int comments;
  final String imgUrl;
  final String userId;
  final String postId;

  final double latitude;
  final double longitude;

  Post(
      {required this.description,
      required this.likes,
      required this.comments,
      required this.imgUrl,
      required this.userId,
      required this.postId,
      required this.latitude,
      required this.longitude});
}

List<Post> postsTest = [
  Post(
      description: "A fine place in Time square",
      comments: 10,
      likes: 25,
      imgUrl:
          "https://media.cntraveler.com/photos/53db21cf6dec627b14a1c453/master/pass/Times-Square-Tourist-Tips.jpg",
      postId: "ss",
      userId: "sa",
      latitude: 15,
      longitude: 15),
  Post(
      description: "A fine place in Time square",
      comments: 10,
      likes: 25,
      imgUrl:
          "https://media.cntraveler.com/photos/53db21cf6dec627b14a1c453/master/pass/Times-Square-Tourist-Tips.jpg",
      postId: "ss",
      userId: "sa",
      latitude: 15,
      longitude: 15),
  Post(
      description: "A fine place in Time square",
      comments: 10,
      likes: 25,
      imgUrl:
          "https://media.cntraveler.com/photos/53db21cf6dec627b14a1c453/master/pass/Times-Square-Tourist-Tips.jpg",
      postId: "ss",
      userId: "sa",
      latitude: 15,
      longitude: 15),
];
