import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';

import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/expandable_text.dart';
import 'package:food_app/widgets/food_info_column.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularImageSize,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/food0.png"),
                )),
              )),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppIcon(icon: Icons.arrow_back_ios_new),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularImageSize - Dimensions.radius20,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FoodInfoColumn(),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Introduction"),
                  SizedBox(height: Dimensions.height10),
                  const Expanded(
                      child: SingleChildScrollView(
                    child: ExpandableTextWidget(
                        text:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Blandit cursus risus at ultrices mi tempus imperdiet nulla. Quam adipiscing vitae proin sagittis. Ultrices gravida dictum fusce ut placerat orci. Ac turpis egestas maecenas pharetra. At auctor urna nunc id cursus. Condimentum lacinia quis vel eros donec. In nisl nisi scelerisque eu ultrices vitae auctor. Id semper risus in hendrerit. Vitae auctor eu augue ut lectus arcu bibendum at varius. Tempus imperdiet nulla malesuada pellentesque elit eget gravida. Velit ut tortor pretium viverra. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Sit amet nulla facilisi morbi tempus iaculis. Egestas diam in arcu cursus euismod quis viverra. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Sit amet nulla facilisi morbi tempus iaculis. Egestas diam in arcu cursus euismod quis viverra. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Sit amet nulla facilisi morbi tempus iaculis. Egestas diam in arcu cursus euismod quis viverra. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Sit amet nulla facilisi morbi tempus iaculis. Egestas diam in arcu cursus euismod quis viverra."),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeight,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width20, vertical: Dimensions.height30),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2.1),
                topRight: Radius.circular(Dimensions.radius20 * 2.1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Row(
                children: [
                  const Icon(Icons.remove, color: AppColors.signColor),
                  SizedBox(width: Dimensions.width5 / 2),
                  BigText(text: "0"),
                  SizedBox(width: Dimensions.width5 / 2),
                  const Icon(Icons.add, color: AppColors.signColor)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.maincolor,
              ),
              child: BigText(text: "₹ 10 | Add to Cart", color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}