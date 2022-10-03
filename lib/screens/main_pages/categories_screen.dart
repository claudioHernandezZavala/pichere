import 'package:flutter/material.dart';
import 'package:pichere/models/category_models/category.dart';

import '../../utils/app_colors.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool imageError = false;
  List<PlaceCategory> availableCategories = [
    PlaceCategory(
        "Food", "assets/images/fast-food.png", "Food category around you"),
    PlaceCategory(
        "Shows", "assets/images/show.png", "Food category around you"),
    PlaceCategory("Park", "assets/images/park.png", "Food category around you"),
    PlaceCategory(
        "Monuments", "assets/images/monument.png", "Food category around you")
  ];

  List<String> imagesHighLights = [
    "assets/images/pizzaimgpost.jpg",
    "assets/images/showpic.jpg",
    "assets/images/parkimg.jpg",
    "assets/images/statue_liberty.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            AppColors.color1Background,
            AppColors.color2Background
          ])),
        ),
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search_rounded),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "All categories",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: availableCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 15 / 12,
                ),
                itemBuilder: (ctx, index) {
                  return Container(
                    // margin: EdgeInsets.all(15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    // margin: EdgeInsets.all(15),
                    child: Center(
                        child: Image.asset(
                      availableCategories[index].imgUrl,
                      width: 100,
                      height: 100,
                    )),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Most viewed places",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: availableCategories.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(bottom: 50, left: 0, right: 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                availableCategories[index].name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            margin: const EdgeInsets.all(15),
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                imagesHighLights[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
