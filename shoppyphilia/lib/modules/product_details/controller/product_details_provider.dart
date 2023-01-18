import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoppyphilia/modules/shopping_cart/api/get_user_cart_api.dart';
import 'package:shoppyphilia/modules/shopping_cart/model/cart.dart';
import 'package:shoppyphilia/modules/home/model/product.dart';
import 'package:shoppyphilia/modules/product_details/api/delete_product_api.dart';
import 'package:shoppyphilia/modules/product_details/api/get_single_product_api.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final int productId;
  final int userID = 2;
  int cartProductsLength = 0;
  Product product = Product();
  Cart cart = Cart();
  bool isCartFetching = false;
  bool isProductsDetailsFetching = false;
  bool isDeleteProductFetching = false;

  ProductDetailsProvider(
    this.productId,
  ) {
    getUserCart(userID);
    getProductDetails(productId);
    notifyListeners();
  }

  /// get single product details api function
  Future<bool> getProductDetails(productID) async {
    isProductsDetailsFetching = true;
    notifyListeners();
    var response = await GetSingleProductApi().getSingleProduct(productID);
    isProductsDetailsFetching = false;
    notifyListeners();
    var data = jsonDecode(response);
    bool status = false;
    if (data != null) {
      status = true;
      product = Product.fromJson(data);
    }
    notifyListeners();
    return status;
  }

  /// delete product api function
  Future<bool> deleteProduct(productID) async {
    isDeleteProductFetching = true;
    notifyListeners();
    var response = await DeleteProductApi().deleteProduct(productID);
    isDeleteProductFetching = false;
    notifyListeners();
    var data = jsonDecode(response);
    bool status = false;
    if (data != null) {
      status = true;
    }
    notifyListeners();
    return status;
  }

  /// get user cart api function
  Future<bool> getUserCart(userID) async {
    isCartFetching = true;
    notifyListeners();
    var response = await GetUserCartApi().getUserCart(userID);
    isCartFetching = false;
    notifyListeners();
    var data = jsonDecode(response);
    bool status = false;
    if (data != null) {
      status = true;
      List<Cart> cart = [];
      data.forEach((e) {
        cart.add(Cart.fromJson(e));
      });
      cartProductsLength = cart[0].products.length;
    }
    notifyListeners();
    return status;
  }
}
