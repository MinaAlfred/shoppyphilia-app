import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/appbar.dart';
import 'package:shoppyphilia/constants/widget/button.dart';
import 'package:shoppyphilia/constants/widget/drop_down.dart';
import 'package:shoppyphilia/constants/widget/image.dart';
import 'package:shoppyphilia/constants/widget/loading_item.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/constants/widget/textField&validation.dart';
import 'package:shoppyphilia/constants/widget/toast.dart';
import 'package:shoppyphilia/modules/add_update_product/controller/add_update_product_provider.dart';
import 'package:shoppyphilia/modules/home/model/product.dart';
import 'package:shoppyphilia/modules/main_tab_pages/view/main_tab_pages.dart';
import 'package:shoppyphilia/modules/product_details/view/product_Details_screen.dart';

class AddUpdateProductScreen extends StatelessWidget {
  final bool isUpdate;
  final int productId;
  final Product product;
  AddUpdateProductScreen({this.isUpdate, this.productId, this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider<AddUpdateProductProvider>(
        create: (_) => AddUpdateProductProvider(product),
        child: _AddUpdateProductBody(this.isUpdate, this.productId),
      ),
    );
  }
}

class _AddUpdateProductBody extends StatefulWidget {
  final bool isUpdate;
  final int productId;
  _AddUpdateProductBody(this.isUpdate, this.productId);
  @override
  State<StatefulWidget> createState() {
    return _AddUpdateProductBodyState();
  }
}

class _AddUpdateProductBodyState extends State<_AddUpdateProductBody>
    with InputValidation {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Consumer<AddUpdateProductProvider>(
        builder: (_, AddUpdateProductProvider myProvider, child) {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
        },
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          body: myProvider.isCategoriesFetching
              ? const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: LoadingItem(),
                )
              : Form(
                  key: myProvider.formGlobalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// appbar
                      MyAppbar(
                        onTap: () {
                          if (widget.isUpdate) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                          productID: widget.productId,
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainTabPages(pageIndex: 1)));
                          }
                        },
                        title: widget.isUpdate
                            ? 'Update Product'
                            : 'Add New Product',
                        isBack: true,
                        isCart: false,
                        productID: widget.productId,
                        screenName: 'updateProduct',
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SpaceItem(height: 30),

                              ///product image
                              widget.isUpdate
                                  ? InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        myProvider.onUploadImage(context);
                                      },
                                      child: myProvider.base64Image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Image.file(
                                                myProvider.files,
                                                width: (size.width / 3) - 10,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: MyImage.drawImage(
                                                myProvider.myProduct.image,
                                                width: (size.width / 3) - 10,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    )
                                  : InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        myProvider.onUploadImage(context);
                                      },
                                      child: myProvider.base64Image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Image.file(
                                                myProvider.files,
                                                width: (size.width / 3) - 10,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: MyColors.orangeColor,
                                                    width: getWidth(1)),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              width: (size.width / 3) - 10,
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  const Icon(Icons.ios_share),
                                                  const SpaceItem(height: 10),
                                                  MyText.drawText(
                                                    content: 'Upload Image',
                                                    fontSize: getFont(15),
                                                    fontColor:
                                                        MyColors.blackColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),

                              const SpaceItem(height: 30),

                              ///product Name
                              getTextInputField(
                                labelText:
                                    !widget.isUpdate ? "Product Name" : null,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                hintFontColor: MyColors.blackColor,
                                autoValidationMode:
                                    AutovalidateMode.onUserInteraction,
                                validatorFunction: validateNotEmpty,
                                controller: myProvider.productNameController,
                              ),

                              const SpaceItem(height: 15),

                              ///Price
                              getTextInputField(
                                labelText: !widget.isUpdate ? "Price" : null,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                hintFontColor: MyColors.blackColor,
                                controller: myProvider.productPriceController,
                                autoValidationMode:
                                    AutovalidateMode.onUserInteraction,
                                validatorFunction: validateNotEmpty,
                              ),
                              const SpaceItem(height: 15),

                              ///Description
                              getTextInputField(
                                labelText:
                                    !widget.isUpdate ? "Description" : null,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                hintFontColor: MyColors.blackColor,
                                controller:
                                    myProvider.productDescriptionController,
                                autoValidationMode:
                                    AutovalidateMode.onUserInteraction,
                                validatorFunction: validateNotEmpty,
                                maxLines: 5,
                              ),

                              const SpaceItem(height: 15),

                              ///product category
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DropDownMenuItem(
                                  dropDownMenusColor:
                                      MyColors.textFieldBackground,
                                  dropMenuColor: MyColors.textFieldBackground,
                                  itemColor: MyColors.blackColor,
                                  items: myProvider.categoriesList,
                                  size: size,
                                  value: myProvider.selectedCategory ??
                                      myProvider.categoriesList[0],
                                  onChange: (val){
                                    setState(() {
                                      myProvider.selectedCategory = val;
                                    });
                                  },
                                ),
                              ),

                              SpaceItem(height: getHeight(30)),
                              myProvider.isUpdateProductFetching ||
                                      myProvider.isAddProductFetching
                                  ? const LoadingItem()
                                  : SpaceItem(height: getHeight(20)),
                              SpaceItem(height: getHeight(20)),

                              ///Add/Update product Button
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: AppButton(
                                    onPressed: () async {
                                      if (myProvider.formGlobalKey.currentState
                                          .validate()) {
                                        if (widget.isUpdate) {
                                          bool status =
                                              await myProvider.updateProduct(
                                            productID: widget.productId,
                                            title: myProvider
                                                .productNameController.text,
                                            price: double.parse(myProvider
                                                .productPriceController.text),
                                            description: myProvider
                                                .productDescriptionController
                                                .text,
                                            image: myProvider.base64Image,
                                            category:
                                                myProvider.selectedCategory,
                                          );
                                          if (status) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            MainTabPages(
                                                              pageIndex: 1,
                                                            )),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          }
                                        }
                                        else {
                                          bool status2 =
                                              await myProvider.addProduct(
                                            title: myProvider
                                                .productNameController.text,
                                            price: double.parse(myProvider
                                                .productPriceController.text),
                                            description: myProvider
                                                .productDescriptionController
                                                .text,
                                            image: myProvider.base64Image,
                                            category:
                                                myProvider.selectedCategory,
                                          );
                                          if (status2) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            MainTabPages(
                                                              pageIndex: 1,
                                                            )),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          }
                                        }
                                      } else {
                                        MyToast('Please fill product data');
                                      }
                                    },
                                    buttonText: widget.isUpdate
                                        ? "Update product"
                                        : "Add product",
                                    textSize: getFont(24),
                                  )),

                              const SpaceItem(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
