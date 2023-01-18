// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/appbar.dart';
import 'package:shoppyphilia/constants/widget/divider_item.dart';
import 'package:shoppyphilia/constants/widget/empty_product.dart';
import 'package:shoppyphilia/constants/widget/loading_item.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/modules/main_tab_pages/view/main_tab_pages.dart';
import 'package:shoppyphilia/modules/product_details/view/product_Details_screen.dart';
import 'package:shoppyphilia/modules/shopping_cart/view/widgets/cart_operation_button.dart';
import 'package:shoppyphilia/modules/shopping_cart/view/widgets/delete_cart_dialog.dart';
import '../controller/cart_provider.dart';
import 'widgets/product_item.dart';

class CartScreen extends StatelessWidget {
  String screenName;
  int productID;
  CartScreen(
      {Key key,
      this.screenName,
      this.productID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartProvider>(
      create: (_) => CartProvider(),
      child:
          Consumer<CartProvider>(builder: (_, CartProvider myProvider, child) {
        SizeConfig().init(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// appbar
              MyAppbar(
                onTap: () {
                  if (screenName == 'homeScreen') {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainTabPages(
                                  pageIndex: 1,
                                )),
                        (Route<dynamic> route) => false);
                  } else if (screenName == 'ProductDetails') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProductDetailsScreen(
                                  productID: productID,
                                )));
                  } else {
                    Navigator.pop(context);
                  }
                },
                title: 'Shopping Cart',
                isBack: true,
                isCart: false,
                screenName: 'ShoppingCart',
              ),
              Expanded(
                child: myProvider.isCartFetching ||
                        myProvider.isProductsFetching
                    ? const LoadingItem()
                    : myProvider.cartProductsList.isEmpty
                        ?
                /// Empty Products
                const EmptyProducts()
                        :
                SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                                right: getWidth(15), left: getWidth(15)),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                /// cart products listView
                                ListView.separated(
                                  padding: EdgeInsets.only(
                                      top: getHeight(13)),
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: myProvider
                                      .cartProductsList.length,
                                  separatorBuilder: (context, i) {
                                    return const DividerItem();
                                  },
                                  itemBuilder: (context, i) {
                                    return CartProductItem(
                                      provider: myProvider,
                                      index: i,
                                      productID: myProvider
                                          .cartProductsList[i]
                                          .productId,
                                      cartItemID: 3,
                                      productName: myProvider
                                          .cartProductsList[i].name,
                                      price: myProvider
                                          .cartProductsList[i].price
                                          .toString(),
                                      quantity: myProvider
                                          .cartProductsList[i].quantity,
                                    );
                                  },
                                ),
                                const DividerItem(),
                                SpaceItem(
                                  height: getHeight(10),
                                ),
                                /// total price
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    MyText.drawText(
                                        content: 'Total Price',
                                        fontSize: getHeight(17),
                                        fontColor: MyColors.blackColor,
                                        bold: true),
                                    const Spacer(),
                                    MyText.drawText(
                                        content:
                                            "${myProvider.cartTotal} LE",
                                        fontSize: getHeight(17),
                                        fontColor: MyColors.petroleumColor,
                                        bold: true),
                                  ],
                                ),
                              ],
                            ),
                          ),
              ),
              myProvider.cartProductsList.isEmpty
                  ? const SizedBox()
                  :
              /// delete cart and pay button
              CartOperationButtonItem(
                      myProvider: myProvider,
                      onTapPay: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainTabPages(
                                      pageIndex: 1,
                                    )));
                      },
                      onTapDeleteCart: (){
                        showDialog(
                          builder: (context) => Container(
                            alignment: Alignment.center,
                            child: DeleteCartDialog(
                              provider: myProvider,
                            ),
                          ),
                          context: context,
                        );
                      },
                    ),
            ],
          ),
        );
      }),
    );
  }
}
