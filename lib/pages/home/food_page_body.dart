import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/food_info_column.dart';
import 'package:food_app/widgets/icon_text_row.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: ((context, index) {
                        return _buildPageItem(
                            index, popularProducts.popularProductList[index]);
                      })))
              : const CircularProgressIndicator(color: AppColors.maincolor);
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
                activeColor: AppColors.maincolor,
                size: Size.square(Dimensions.height10),
                activeSize: Size(Dimensions.height20, Dimensions.height10),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius5))),
          );
        }),
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              ),
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return recommendedProducts.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProducts.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(children: [
                          Container(
                            width: Dimensions.listViewImageSize,
                            height: Dimensions.listViewImageSize,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "${Constants.appBaseUrl}/uploads/${recommendedProducts.recommendedProductList[index].img!}"),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xFFe8e8e8),
                                    blurRadius: 5,
                                    offset: Offset(0, 7)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20)),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xFFe8e8e8),
                                      blurRadius: 5,
                                      offset: Offset(0, 5)),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(
                                        text: recommendedProducts
                                            .recommendedProductList[index]
                                            .name!),
                                    SizedBox(height: Dimensions.height10),
                                    SmallText(
                                        text: "With Chinese authenticity"),
                                    SizedBox(height: Dimensions.height10),
                                    const IconTextRow(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]));
                  })
              : const CircularProgressIndicator(color: AppColors.maincolor);
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = _scaleFactor;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width10, vertical: Dimensions.height5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius25),
              image: DecorationImage(
                image: NetworkImage(
                    "${Constants.appBaseUrl}/uploads/${popularProduct.img!}"),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFe8e8e8),
                  blurRadius: 10,
                  offset: (_currPageValue == index)
                      ? const Offset(0, 5)
                      : const Offset(0, 2),
                ),
                BoxShadow(
                  color: const Color(0xFFe8e8e8),
                  blurRadius: 10,
                  offset: (_currPageValue == index)
                      ? const Offset(-5, 5)
                      : const Offset(-2, 5),
                ),
                BoxShadow(
                  color: const Color(0xFFe8e8e8),
                  blurRadius: 10,
                  offset: (_currPageValue == index)
                      ? const Offset(5, 5)
                      : const Offset(2, 5),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: FoodInfoColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
