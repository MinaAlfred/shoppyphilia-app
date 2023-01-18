import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/button.dart';
import 'package:shoppyphilia/modules/shopping_cart/controller/cart_provider.dart';

class CartOperationButtonItem extends StatelessWidget {
  final CartProvider myProvider;
  final Function() onTapPay;
  final Function() onTapDeleteCart;
  const CartOperationButtonItem({Key key,  this.myProvider,  this.onTapPay , this.onTapDeleteCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getWidth(15), right: getWidth(15), bottom: getHeight(30)),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              onPressed: onTapDeleteCart,
              color: Colors.red,
              buttonText: "Delete Cart",
              textSize: getFont(19),
              textColor: MyColors.whiteColor,
            ),
          ),
          SizedBox(
            width: getWidth(20),
          ),
          Expanded(
            child: AppButton(
              onPressed: onTapPay,
              color: MyColors.orangeColor,
              buttonText: "Pay",
              textSize: getFont(19),
              textColor: MyColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
