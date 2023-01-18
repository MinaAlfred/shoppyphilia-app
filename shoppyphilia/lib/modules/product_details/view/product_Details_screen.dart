// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/appbar.dart';
import 'package:shoppyphilia/constants/widget/button.dart';
import 'package:shoppyphilia/constants/widget/loading_item.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/modules/add_update_product/view/add_update_product_screen.dart';
import 'package:shoppyphilia/modules/main_tab_pages/view/main_tab_pages.dart';
import 'package:shoppyphilia/modules/product_details/controller/product_details_provider.dart';
import 'package:shoppyphilia/modules/product_details/view/widgets/add_cart_item.dart';
import 'widgets/item_info.dart';
import 'widgets/view_item_Image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productID;
  ProductDetailsScreen({
    Key key,
    this.productID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailsProvider>(
      create: (_) => ProductDetailsProvider(
        productID,
      ),
      child: _ProductDetailsBody(),
    );
  }
}

class _ProductDetailsBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailsBodyState();
  }
}

class _ProductDetailsBodyState extends State<_ProductDetailsBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<ProductDetailsProvider>(
      builder: (_, ProductDetailsProvider myProvider, child) {
        return Scaffold(
          body: myProvider.isProductsDetailsFetching
              ? const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: LoadingItem(),
                )
              : Column(
                  children: [
                    /// appbar
                    MyAppbar(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainTabPages(pageIndex: 1)));
                      },
                      title: myProvider.product.title,
                      isBack: true,
                      cartListLength: myProvider.cartProductsLength,
                      productID: myProvider.productId,
                      screenName: 'ProductDetails',
                    ),
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            /// product image
                            ViewProductImage(
                                productImage: myProvider.product.image),

                            /// Product Info
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: ProductInfo(
                                        productId:
                                            myProvider.product.id.toString(),
                                        productName: myProvider.product.title,
                                        category: myProvider.product.category,
                                        price:
                                            myProvider.product.price.toString(),
                                        description:
                                            myProvider.product.description,
                                        rating: myProvider.product.rating.rate
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// add to cart button
                            AddCartItem(myProvider: myProvider),

                            Row(
                              children: [
                                ///update product Button
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: AppButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      AddUpdateProductScreen(
                                                        isUpdate: true,
                                                        productId: myProvider
                                                            .product.id,
                                                        product:
                                                            myProvider.product,
                                                      )));
                                        },
                                        buttonText: "Update product",
                                        textSize: getFont(20),
                                      )),
                                ),

                                ///delete product Button
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: AppButton(
                                        onPressed: () async {
                                          bool status =
                                              await myProvider.deleteProduct(
                                                  myProvider.product.id);
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
                                        },
                                        buttonText: "Delete product",
                                        color: Colors.red,
                                        textSize: getFont(20),
                                      )),
                                ),
                              ],
                            ),
                            SpaceItem(
                              height: getHeight(20),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
