import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pichere/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool imageError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1Background, AppColors.color2Background],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFdad4ec),
              Color(0xFFf3e7e9),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //contains the profile picture
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                        radius: 50 - 2,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            const AssetImage("assets/images/newyork2.jpg"),
                        onBackgroundImageError: (_, __) {
                          setState(() {
                            imageError = true;
                          });
                        },
                        child: (imageError) ? const Icon(Icons.error) : null),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Username"),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text("56"),
                      Text(
                        "Likes",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: const [
                        Icon(
                          Icons.grid_4x4_outlined,
                          color: Colors.pink,
                        ),
                        Text("56"),
                        Text(
                          "Posts",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                child: GridView.builder(
                    itemCount: 6,
                    padding: const EdgeInsets.all(15),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (ctx, index) {
                      return SizedBox(
                        width: 200.0,
                        height: 100.0,
                        child: Shimmer.fromColors(
                          baseColor: AppColors.blackcolorbackground2,
                          highlightColor: AppColors.blackcolorbackground1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.color1Background,
                              border: Border.all(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
