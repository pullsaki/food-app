import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = Product.fromJson(response.body).products!;
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity + _inCartItems < 0) {
      Get.snackbar("Item count", "You can't order less than 0!",
          backgroundColor: AppColors.maincolor, colorText: Colors.white);
      return -(_inCartItems);
    } else if (quantity + _inCartItems > 20) {
      Get.snackbar("Item count", "You can't order more than 20!",
          backgroundColor: AppColors.maincolor, colorText: Colors.white);
      return 20 - _inCartItems;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exists = _cart.existsInCart(product);
    if (exists) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print("the quantity in the cart is $_inCartItems");
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    // _cart.items.forEach((key, value) {
    //   print(
    //       "The id is ${value.id}, item name is ${value.name}, quantity is ${value.quantity}");
    // });
  }
}
