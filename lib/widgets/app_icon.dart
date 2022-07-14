import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconcolor;
  final double size;
  const AppIcon(
      {Key? key,
      required this.icon,
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.iconcolor = const Color(0xFF756d54),
      this.size = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: Icon(
          icon,
          color: iconcolor,
          size: Dimensions.iconSize16,
        ),
      ),
    );
  }
}
