import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/utils/constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(Constants.popularProductUri);
  }
}
