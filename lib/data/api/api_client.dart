import 'package:food_app/utils/constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = Constants.token;
    _mainHeaders = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response resp = await get(uri);
      return resp;
    } catch (e) {
      return Response(
        statusCode: 1,
        body: e.toString(),
      );
    }
  }
}
