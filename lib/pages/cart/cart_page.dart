import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20 * 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                        icon: Icons.arrow_back,
                        iconcolor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24),
                  ),
                  SizedBox(width: Dimensions.width20 * 10),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                        icon: Icons.home_outlined,
                        iconcolor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24),
                  ),
                  AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconcolor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24)
                ],
              )),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child:
                        GetBuilder<CartController>(builder: (cartController) {
                      var cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              width: double.maxFinite,
                              height: Dimensions.height20 * 5,
                              child: Row(
                                children: [
                                  Container(
                                      width: Dimensions.height20 * 5,
                                      height: Dimensions.height20 * 5,
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${Constants.appBaseUrl}/uploads/${cartList[index].img}"),
                                              fit: BoxFit.cover))),
                                  SizedBox(width: Dimensions.width10),
                                  Expanded(
                                      child: Container(
                                    height: Dimensions.height20 * 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: cartController
                                              .getItems[index].name!,
                                          color: Colors.black54,
                                        ),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                                text:
                                                    "₹ ${cartList[index].price!}",
                                                color: Colors.redAccent),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width10,
                                                  vertical:
                                                      Dimensions.height10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius10),
                                                  color: Colors.white),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(
                                                            cartList[index]
                                                                .product!,
                                                            -1);
                                                      },
                                                      child: const Icon(
                                                          Icons.remove,
                                                          color: AppColors
                                                              .signColor)),
                                                  SizedBox(
                                                      width: Dimensions.width5 /
                                                          2),
                                                  BigText(
                                                      text:
                                                          '${cartList[index].quantity!}'),
                                                  SizedBox(
                                                      width: Dimensions.width5 /
                                                          2),
                                                  GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(
                                                            cartList[index]
                                                                .product!,
                                                            1);
                                                      },
                                                      child: const Icon(
                                                          Icons.add,
                                                          color: AppColors
                                                              .signColor))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            );
                          }));
                    }))),
          ),
        ],
      ),
    );
  }
}
