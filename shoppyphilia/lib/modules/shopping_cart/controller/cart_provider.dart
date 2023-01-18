import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/utils/round_decimal.dart';
import 'package:shoppyphilia/modules/home/api/get_products_api.dart';
import 'package:shoppyphilia/modules/shopping_cart/api/get_user_cart_api.dart';
import 'package:shoppyphilia/modules/shopping_cart/model/cart.dart';
import 'package:shoppyphilia/modules/home/model/product.dart';
import 'package:shoppyphilia/modules/shopping_cart/api/remove_cart_api.dart';
import 'package:shoppyphilia/modules/shopping_cart/api/update_product_cart_api.dart';

class CartProvider extends ChangeNotifier {
  final int userID = 2;
  int quantity = 1;
  dynamic cartTotal = 0;
  int cartProductsLength = 0;
  List<Cart> cart = [];
  List<Products> cartProductsList = [];
  List<Product> productList = [];
  bool isCartFetching = false;
  bool isProductsFetching = false;
  bool isUpdateProductCartFetching = false;
  bool isDeleteCartFetching = false;

  CartProvider() {
    getAllProducts().then((value) => getUserCart(userID));
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

      data.forEach((e) {
        cart.add(Cart.fromJson(e));
      });
      cartProductsLength = cart[0].products.length;
      for (var x = 0; x < cart[0].products.length; x++) {
        Products product = Products();
        product.productId = cart[0].products[x].productId;
        product.quantity = cart[0].products[x].quantity;
        for (var z = 0; z < productList.length; z++) {
          if (product.productId == productList[z].id) {
            product.name = productList[z].title;
            product.price = productList[z].price;
          }
        }
        cartProductsList.add(product);
      }
      calculateTotalPrice();
    }
    notifyListeners();
    return status;
  }

  /// get all products api function to get cart product names and prices
  Future<bool> getAllProducts() async {
    productList.clear();
    isProductsFetching = true;
    notifyListeners();
    var response = await GetAllProductsApi().getAllProducts();
    isProductsFetching = false;
    notifyListeners();
    var data = jsonDecode(response);
    bool status = false;
    if (data != null) {
      status = true;
      data.forEach((e) {
        productList.add(Product.fromJson(e));
      });
    }
    notifyListeners();
    return status;
  }

  /// update cart products api function
  Future<bool> updateProductCart(int cartID,int userID) async {
    Map updateProductMap = {
      'userId': userID,
      'date': '2019-12-10',
      'products': [
        {'productId': 1, 'quantity': 3}
      ]
    };
    isUpdateProductCartFetching = true;
    notifyListeners();
    var response = await UpdateProductCartApi().updateProductCart(cartID,updateProductMap.toString());
    isUpdateProductCartFetching = false;
    notifyListeners();
    var data = jsonDecode(response);
    bool status = false;
    if (data != null) {
      status = true;
    }
    notifyListeners();
    return status;
  }

  /// delete cart api function
  Future<bool> deleteCart(int cartID) async {
    isDeleteCartFetching = true;
    notifyListeners();
    var response = await DeleteCartApi().deleteCart(cartID);
    isDeleteCartFetching = false;
    notifyListeners();
    var data = jsonDecode(response);
    bool status = false;
    if (data != null) {
      status = true;
    }
    notifyListeners();
    return status;
  }

  /// function called when product quantity increased
  onIncreaseProductQuantity({
    int index,
    int cartID,
  }) async {
    // bool status = await updateProductCart(cartID,userID);
    // if (status) {
    cartProductsList[index].quantity++;
    calculateTotalPrice();
    notifyListeners();
    // }
  }

  /// function called when user want to remove product from cart
  removeProductFromCart({
    int index,
  }) {
    cartProductsList.removeAt(index);
    calculateTotalPrice();
    notifyListeners();
  }

  /// function called when product quantity decreased
  onDecreaseProductQuantity({
    int index,
    int cartID,
  }) async {
    if (cartProductsList[index].quantity >= 1) {
      cartProductsList[index].quantity--;
      calculateTotalPrice();
      // bool status = await updateProductCart(cartID,userID);
      // if (status) {
      //   await getUserCart(cartID);
      // }
    }
    notifyListeners();
  }

  /// calculate total price function
  calculateTotalPrice() {
    cartTotal = 0;
    for (var element in cartProductsList) {
      cartTotal += element.price * element.quantity;
      cartTotal = decimalRound(cartTotal, 2);
    }
    notifyListeners();
  }
}
