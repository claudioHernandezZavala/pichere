import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final LinearGradient? gradient;
  final Color color1;
  final Color color2;
  const CustomDivider(
      {Key? key,
      required this.height,
      required this.width,
      required this.color1,
      required this.color2,
      this.gradient = const LinearGradient(colors: [Colors.green, Colors.blue]),
      required this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: gradient ?? LinearGradient(colors: [color1, color2]),
      ),
    );
  }
}
