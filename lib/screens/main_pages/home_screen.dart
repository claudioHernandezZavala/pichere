import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pichere/screens/main_pages/categories_screen.dart';
import 'package:pichere/screens/main_pages/home_page.dart';
import 'package:pichere/screens/profile/profile_page.dart';
import 'package:pichere/screens/save_posts/save_post_screen.dart';
import 'package:pichere/widgets/floating_buttons.dart';

import '../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _index = 0;

  List<Widget> screens = [
    const HomePage(),
    const SavePostScreen(),
    const CategoriesPage(),
    const UserProfile()
  ];
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color1Background,
      body: screens[_index],
      floatingActionButton: _index == 0 ? homePageButton(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        activeColor: Colors.white,
        backgroundGradient: const LinearGradient(
            colors: [Color(0xFF6a11cb), Color(0xFF2575fc)]),
        icons: const [
          Icons.home,
          Icons.bookmark,
          Icons.search_rounded,
          Icons.person
        ],
        gapLocation: GapLocation.center,
        inactiveColor: Colors.black,
        hideAnimationCurve: Curves.ease,
        notchMargin: 5,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 25,
        rightCornerRadius: 25,
        gapWidth: _index == 0 ? null : 0,
        safeAreaValues:
            const SafeAreaValues(right: true, left: true, top: true),
        blurEffect: true,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        activeIndex: _index,
      ),
    );
  }
}
