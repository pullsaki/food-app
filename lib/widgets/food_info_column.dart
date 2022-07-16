import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_text_row.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';

class FoodInfoColumn extends StatelessWidget {
  final String text;
  const FoodInfoColumn({Key? key, this.text = "Food Item Name"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(Icons.star,
                      color: AppColors.mainColor, size: Dimensions.height15)),
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "1287"),
            SizedBox(width: Dimensions.width5),
            SmallText(text: "Reviews"),
          ],
        ),
        SizedBox(height: Dimensions.height20),
        const IconTextRow(),
      ],
    );
  }
}
