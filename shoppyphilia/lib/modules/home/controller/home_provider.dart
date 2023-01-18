import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoppyphilia/modules/home/api/get_all_categories_api.dart';
import 'package:shoppyphilia/modules/home/api/get_products_api.dart';
import 'package:shoppyphilia/modules/home/api/get_products_by_category_api.dart';
import 'package:shoppyphilia/modules/home/api/get_products_by_limit_api.dart';
import 'package:shoppyphilia/modules/home/api/get_products_by_sort_api.dart';
import 'package:shoppyphilia/modules/shopping_cart/api/get_user_cart_api.dart';
import 'package:shoppyphilia/modules/shopping_cart/model/cart.dart';
import 'package:shoppyphilia/modules/home/model/product.dart';

class HomeProvider extends ChangeNotifier {
  final int userID = 2;
  TextEditingController searchController = TextEditingController();
  ScrollController controller = ScrollController();
  List<String> categoriesList = [];
  List<Product> productList = [];
  String selectedSortType;
  List<String> sortTypesList = ['desc', 'asc'];
  int cartProductsLength = 0;
  bool isCategoriesFetching = false;
  bool isProductsFetching = false;
  bool isCartFetching = false;
  bool isProductsSortFetching = false;
  bool isProductsLimitFetching = false;
  bool isProductsByCategoryFetching = false;
  int selectedCategory;

  HomeProvider() {
    getAllProducts().then(
        (value) => getAllCategories().then((value) => getUserCart(userID)));
  }

  /// function to change selected category value
  changeSelectedCategoryValue({int index}) {
    selectedCategory = index;
    notifyListeners();
  }

  /// get all category api function
  Future<bool> getAllCategories() async {
    categoriesList.clear();
    isCategoriesFetching = true;
    notifyListeners();
    var response = await GetAllCategoriesApi().allCategories();
    isCategoriesFetching = false;
    notifyListeners();
    var data = jsonDecode(response).cast<String>().toList();
    bool status = false;
    if (data != null) {
      status = true;
      categoriesList.addAll(data);
    }
    notifyListeners();
    return status;
  }

  /// get all products api function
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

  /// get all products api by sort between [asc,desc] filter function
  Future<bool> getAllProductsSort(sortType) async {
    productList.clear();
    isProductsSortFetching = true;
    notifyListeners();
    var response =
        await GetAllProductsBySortApi().getAllProductsBySort(sortType);
    isProductsSortFetching = false;
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

  /// get all products api by determine limit of products number returns function
  Future<bool> getAllProductsLimit(limit) async {
    productList = [];
    isProductsLimitFetching = true;
    notifyListeners();
    var response =
        await GetAllProductsByLimitApi().getAllProductsByLimit(limit);
    isProductsLimitFetching = false;
    notifyListeners();
    var data = jsonDecode(response);
    bool status = false;
    if (data != null) {
      status = true;
      data.forEach((e) {
        productList.add(Product.fromJson(e));
        productList.toSet().toList();
      });
    }

    notifyListeners();
    return status;
  }

  /// get all products api by category filter function
  Future<bool> getAllProductsByCategory(categoryName) async {
    productList = [];
    isProductsByCategoryFetching = true;
    notifyListeners();
    var response = await GetAllProductsByCategoryApi()
        .getAllProductsByCategory(categoryName);
    isProductsByCategoryFetching = false;
    notifyListeners();
    var data = jsonDecode(response);
    bool status = false;
    if (data != null) {
      status = true;
      data.forEach((e) {
        productList.add(Product.fromJson(e));
        productList.toSet().toList();
      });
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
