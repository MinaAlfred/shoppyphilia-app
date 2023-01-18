// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/cart_button.dart';
import 'package:shoppyphilia/constants/widget/text.dart';

class MyAppbar extends StatelessWidget {
  final Function onTap;
  final String title;
  final bool isBack;
  final bool isCart;
  int cartListLength;
  String screenName;
  int productID;
  MyAppbar(
      {this.title,
      this.onTap,
      this.isBack = false,
      this.isCart = true,
      this.cartListLength,
      this.screenName,
      this.productID,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
      decoration: BoxDecoration(
        color: MyColors.textFieldBackground,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.16),
              blurRadius: 5.0,
              offset: const Offset(0, 0.75)),
        ],
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        isBack
            ? Expanded(
                child: InkWell(
                onTap: onTap,
                child: Image.asset(
                  'assets/images/back icon.gif',
                  height: 25,
                  width: 25,
                  color: MyColors.blackColor,
                ),
              ))
            : Expanded(child: const SizedBox()),

        ///title
        if (title != null)
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.only(top: getHeight(5)),
              child: MyText.drawText(
                content: title,
                maxLines: 3,
                centered: true,
                overflow: TextOverflow.ellipsis,
                fontColor: MyColors.blackColor,
                fontSize: getHeight(22),
                bold: true,
              ),
            ),
          ),
       isCart?
       CartButtonItem(
          cartListLength: cartListLength,
          screenName: screenName,
          productID: productID,
        ): Expanded(child: const SizedBox()),
      ]),
    );
  }
}
