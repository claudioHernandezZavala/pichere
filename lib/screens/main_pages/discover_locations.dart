import 'package:flutter/material.dart';

class DiscoverLocationScreen extends StatelessWidget {
  const DiscoverLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var places = [
      "Time square",
      "Fulton avenue",
      "Empire state",
      "The edge",
      "Rockerfeller",
      "Broadway"
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover hot locations"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: places.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                return Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFB200),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 1.5)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_pin),
                          Text(places[index]),
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index2) {
                          return Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/newyorkpic.jfif"),
                                  fit: BoxFit.fill),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
