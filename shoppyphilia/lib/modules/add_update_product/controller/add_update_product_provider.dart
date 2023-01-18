// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/widget/toast.dart';
import 'package:shoppyphilia/modules/add_update_product/api/add_product_api.dart';
import 'package:shoppyphilia/modules/add_update_product/api/update_product_api.dart';
import 'package:shoppyphilia/modules/home/api/get_all_categories_api.dart';
import 'package:shoppyphilia/modules/home/model/product.dart';
import 'package:image_picker/image_picker.dart';

class AddUpdateProductProvider extends ChangeNotifier {
  Product myProduct;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool isAddProductFetching = false;
  bool isUpdateProductFetching = false;
  bool isCategoriesFetching = false;
  String selectedCategory;
  List<String> categoriesList = [];
  String base64Image;
  File files;
  int type;

  AddUpdateProductProvider(product) {
    getAllCategories();
    myProduct = product;
    if (product != null) {
      productNameController.text = myProduct.title;
      productPriceController.text = myProduct.price.toString();
      productDescriptionController.text = myProduct.description;
      selectedCategory = myProduct.category;
    }
  }

  /// Upload Image function from gallery or camera
  Future<void> onUploadImage(BuildContext context) async {
    int isGallery = await showPickerTypeDialog(context);
    PickedFile a = await ImagePicker.platform.pickImage(
      source: isGallery == 1 ? ImageSource.gallery : ImageSource.camera,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 100,
    );
    if (a != null) {
      files = File(a.path);
      Uint8List bytes = files.readAsBytesSync();
      base64Image = base64Encode(bytes);
    }
    notifyListeners();
  }

  /// image picker dialog
  Future<int> showPickerTypeDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (c) => Container(
              width: MediaQuery.of(c).size.width / 2,
              height: MediaQuery.of(c).size.height / 2,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(c).size.width / 2,
                    child: Card(
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                type = 1;
                                Navigator.of(c).pop('pop');
                              },
                              icon: Icon(
                                Icons.image,
                                color: MyColors.orangeColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                type = 0;
                                Navigator.of(c).pop('pop');
                              },
                              icon: Icon(
                                Icons.camera,
                                color: MyColors.orangeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
        barrierDismissible: true);
    return type;
  }

  /// add product api function
  Future<bool> addProduct(
      {String title,
      double price,
      String description,
      String image,
      String category}) async {
    isAddProductFetching = true;
    Map addProductMap = {
      'title': 'test product',
      'price': 13.5,
      'description': 'lorem ipsum set',
      'image': 'https://i.pravatar.cc',
      'category': 'electronic'
    };

    var response = await AddProductApi().addProduct(addProductMap.toString());
    isAddProductFetching = false;
    notifyListeners();
    var data = json.decode(response);
    bool status = false;
    if (data != null) {
      status = true;
      MyToast('Product added successfully');
    }
    notifyListeners();
    return status;
  }

  /// update product api function
  Future<bool> updateProduct(
      {int productID,
      String title,
      double price,
      String description,
      String image,
      String category}) async {
    isUpdateProductFetching = true;
    Map updateProductMap = {
      'title': 'test product',
      'price': 13.5,
      'description': 'lorem ipsum set',
      'image': 'https://i.pravatar.cc',
      'category': 'electronic'
    };
    var response = await UpdateProductApi()
        .updateProduct(updateProductMap.toString(), productID);
    isUpdateProductFetching = false;
    notifyListeners();
    var data = json.decode(response);
    bool status = false;
    if (data != null) {
      status = true;
      MyToast('Product updated successfully');
    }
    notifyListeners();
    return status;
  }

  /// get all categories api function
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
}
