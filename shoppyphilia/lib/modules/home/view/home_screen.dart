import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/appbar.dart';
import 'package:shoppyphilia/constants/widget/divider_item.dart';
import 'package:shoppyphilia/constants/widget/drop_down.dart';
import 'package:shoppyphilia/constants/widget/empty_product.dart';
import 'package:shoppyphilia/constants/widget/loading_item.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/textField&validation.dart';
import 'package:shoppyphilia/constants/widget/toast.dart';
import 'package:shoppyphilia/modules/add_update_product/view/add_update_product_screen.dart';
import 'package:shoppyphilia/modules/home/controller/home_provider.dart';
import 'package:shoppyphilia/modules/product_details/view/product_Details_screen.dart';
import 'widgets/product_item.dart';
import 'widgets/category_tab_item.dart';

class HomeScreen extends StatefulWidget {
  final String categoryName;
  final int categoryID;
  const HomeScreen({
    Key key,
    this.categoryName,
    this.categoryID,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with InputValidation {
  @override
  Widget build(BuildContext context) {
    DateTime _lastExitTime = DateTime.now();
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      builder: (context, child) {
        final myProvider = Provider.of<HomeProvider>(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              heroTag: 'uniqueTag',
              backgroundColor: MyColors.textFieldBackground,
              child: Icon(Icons.add, color: MyColors.blackColor),
              tooltip: 'Add new product',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUpdateProductScreen(
                        isUpdate: false,
                      ),
                    ));
              }),
          body: WillPopScope(
            onWillPop: () async {
              if (DateTime.now().difference(_lastExitTime) >=
                  Duration(seconds: 2)) {
                MyToast(
                  'Press the back button again to exist the application',
                );
                _lastExitTime = DateTime.now();
                return false; // disable back press
              } else {
                return true; //  exit the app
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// appbar
                MyAppbar(
                  title: 'Welcome to Shoppyphilia',
                  screenName: 'homeScreen',
                  cartListLength: myProvider.cartProductsLength,
                ),
                SpaceItem(height: getHeight(5)),
                myProvider.isCategoriesFetching
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: LoadingItem(),
                      )
                    :
                    /// Category Tabs
                    CategoryTabItem(categoryID: widget.categoryID),

                 SpaceItem(height: getHeight(10)),

                /// search bar and dropdown
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: getTextInputField(
                        hintText: 'enter product limit',
                        keyboardType: TextInputType.number,
                        controller: myProvider.searchController,
                        validatorFunction: validateNumber,
                        onPressed: () async {
                          await myProvider.getAllProductsLimit(
                              myProvider.searchController.text);
                        },
                        fontSize: getFont(18),
                        hintFontSize: getFont(18),
                        textInputAction: TextInputAction.done,
                        fillColor: Colors.grey[200],
                        suffix: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor:Colors.transparent,
                          hoverColor:Colors.transparent,
                          onTap: () async {
                            await myProvider.getAllProductsLimit(
                                myProvider.searchController.text);
                          },
                          child: Image.asset(
                            "assets/images/filter.png",
                            color: MyColors.orangeColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: DropDownMenuItem(
                        dropDownMenusColor: Colors.grey[200],
                        dropMenuColor: MyColors.textFieldBackground,
                        itemColor: MyColors.blackColor,
                        items: myProvider.sortTypesList,
                        size: size,
                        value: myProvider.selectedSortType ??
                            myProvider.sortTypesList[1],
                        onChange: (val) async {
                          setState(() {
                            myProvider.selectedSortType = val;
                          });
                          await myProvider
                              .getAllProductsSort(myProvider.selectedSortType);
                        },
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: myProvider.isProductsFetching ||
                          myProvider.isProductsLimitFetching ||
                          myProvider.isProductsSortFetching ||
                          myProvider.isProductsByCategoryFetching
                      ? const LoadingItem()
                      : myProvider.productList.isEmpty
                          ?

                          /// Empty Products
                          SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: const EmptyProducts())
                          :

                          /// products listView
                          ListView.separated(
                              controller: myProvider.controller,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(10),
                                  vertical: getHeight(15)),
                              itemBuilder: (context, index) => InkWell(
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsScreen(
                                        productID:
                                            myProvider.productList[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: ProductItem(
                                  productIndex: index,
                                  myProvider: myProvider,
                                  productId: myProvider.productList[index].id,
                                  productCategory:
                                      myProvider.productList[index].category,
                                  productName:
                                      myProvider.productList[index].title,
                                  productPrice: myProvider
                                      .productList[index].price
                                      .toString(),
                                  productImage:
                                      myProvider.productList[index].image,
                                  rating: myProvider
                                      .productList[index].rating.rate
                                      .toString(),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const DividerItem(),
                              itemCount: myProvider.productList.length,
                            ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
