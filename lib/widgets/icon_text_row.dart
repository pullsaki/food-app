import 'package:flutter/material.dart';
import 'package:food_app/widgets/icon_text.dart';
import 'package:food_app/utils/colors.dart';

class IconTextRow extends StatelessWidget {
  const IconTextRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        IconTextWidget(
            icon: Icons.circle_sharp,
            text: "Normal",
            iconColor: AppColors.iconColor1),
        IconTextWidget(
            icon: Icons.location_on,
            text: "1.7 km",
            iconColor: AppColors.maincolor),
        IconTextWidget(
            icon: Icons.access_time_rounded,
            text: "32min",
            iconColor: AppColors.iconColor2),
      ],
    );
  }
}
