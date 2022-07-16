import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/expandable_text.dart';
import 'package:get/get.dart';
import 'package:food_app/utils/dimensions.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];

    Get.find<RecommendedProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.recommendedToolBarSize,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: const AppIcon(icon: Icons.clear),
                ),
                GetBuilder<RecommendedProductController>(
                    builder: ((controller) => GestureDetector(
                        onTap: () {
                          if (controller.totalItems > 0) {
                            Get.toNamed(RouteHelper.getCart());
                          }
                        },
                        child: Stack(
                          children: [
                            const AppIcon(icon: Icons.shopping_cart_outlined),
                            controller.totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                        icon: Icons.circle,
                                        size: Dimensions.height20,
                                        iconcolor: Colors.transparent,
                                        backgroundColor: AppColors.mainColor))
                                : Container(),
                            controller.totalItems >= 1
                                ? Positioned(
                                    right: Dimensions.width5 / 2,
                                    top: Dimensions.height5 / 2,
                                    child: BigText(
                                        text: '${controller.totalItems}',
                                        size: Dimensions.font12,
                                        color: Colors.white))
                                : Container(),
                          ],
                        )))),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height25),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)),
                  color: Colors.white,
                ),
                child: Center(
                    child: BigText(
                  text: product.name!,
                  size: Dimensions.font26,
                )),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.recommendedImageSize,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
              '${Constants.appBaseUrl}/uploads/${product.img}',
              width: double.maxFinite,
              fit: BoxFit.cover,
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: ExpandableTextWidget(text: product.description!),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<RecommendedProductController>(
          builder: ((recommendedProduct) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20 * 2.5,
                  vertical: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      recommendedProduct.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconcolor: Colors.white),
                  ),
                  BigText(
                      text:
                          "₹${product.price} X ${recommendedProduct.inCartItems}",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26),
                  GestureDetector(
                    onTap: () {
                      recommendedProduct.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconcolor: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeight,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height30),
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white),
                      child: const Icon(Icons.favorite,
                          color: AppColors.mainColor)),
                  GestureDetector(
                    onTap: () {
                      recommendedProduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(
                          text: (recommendedProduct.inCartItems -
                                      recommendedProduct.quantity ==
                                  0)
                              ? "₹${(recommendedProduct.quantity * product.price!)} | Add to Cart"
                              : "₹${(recommendedProduct.inCartItems * product.price!)} | Update Cart",
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      })),
    );
  }
}
