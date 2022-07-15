import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/data/repository/recommended_product_repo.dart';
import 'package:food_app/utils/constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: Constants.appBaseUrl));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularProductController(
        popularProductRepo: Get.find(),
      ));

  Get.lazyPut(() => RecommendedProductController(
        recommendedProductRepo: Get.find(),
      ));
}
