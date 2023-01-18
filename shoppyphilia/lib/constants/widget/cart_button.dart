// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:badges/badges.dart';
import 'package:shoppyphilia/modules/shopping_cart/view/cart_screen.dart';

class CartButtonItem extends StatelessWidget {
  final bool isWhite;
  int cartListLength;
  String screenName;
  int productID;
  int categoryMin;
  CartButtonItem(
      {Key key,
      this.isWhite = false,
      this.cartListLength,
      this.categoryMin,
      this.screenName,
      this.productID
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CartScreen(
                      screenName: screenName,
                  productID: productID,
                    )));
      },
      icon: cartListLength != 0
          ? Badge(
              animationDuration: const Duration(milliseconds: 150),
              badgeColor: Colors.red,
              shape: BadgeShape.circle,
              position: BadgePosition.topStart(top: -5, start: 15),
              toAnimate: true,
              showBadge: true,
              animationType: BadgeAnimationType.fade,
              borderSide:  BorderSide(color: MyColors.whiteColor, width: 1.5),
              badgeContent: Text(
                cartListLength.toString(),
                style:  TextStyle(
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: getWidth(27),
                color: isWhite ? MyColors.whiteColor : MyColors.blackColor,
              ),
            )
          : Icon(
              Icons.shopping_cart_outlined,
              size: getWidth(27),
              color: isWhite ? MyColors.whiteColor : MyColors.blackColor,
            ),
    );
  }
}
