import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/modules/shopping_cart/controller/cart_provider.dart';

class CartProductItem extends StatefulWidget {
  final CartProvider provider;
  final int productID;
  final int cartItemID;
  final String productName;
  final String price;
  final int quantity;
  final int index;
  const CartProductItem(
      {Key key,
       this.provider,
       this.productID,
       this.cartItemID,
       this.productName,
       this.price,
       this.quantity,
       this.index,})
      : super(key: key);
  @override
  State<StatefulWidget> createState ()=> _CartProductItemState();
}
  class _CartProductItemState extends State<CartProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getHeight(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: widget.productName.length >= 27 ? 1 : 0,
                child: Text(
                  widget.productName,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: getHeight(17),
                      color: MyColors.blackColor,
                      fontWeight: FontWeight.bold),
                ),
              ),

              widget.productName.length >= 27
                  ? SizedBox(
                      width: getWidth(10),
                    )
                  : const Spacer(),
              Text(
                "${widget.price} LE",
                style: TextStyle(
                    fontSize: getHeight(17),
                    color: MyColors.petroleumColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: getHeight(15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.provider.quantity++;
                      widget.provider.onIncreaseProductQuantity(index: widget.index,cartID: widget.cartItemID);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(10), vertical: getHeight(10)),
                        primary: MyColors.blackColor),
                    child: Icon(
                      Icons.add,
                      color: MyColors.whiteColor,
                      size: getWidth(14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(17)),
                    child: Text(
                      widget.quantity.toString(),
                      style: TextStyle(
                          color: MyColors.orangeColor,
                          fontSize: getFont(24),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.provider.quantity > 1) {
                        widget.provider.quantity--;
                        widget.provider.onDecreaseProductQuantity(index: widget.index,cartID: widget.cartItemID);
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(10), vertical: getHeight(10)),
                        primary: MyColors.blackColor),
                    child: Icon(
                      Icons.remove,
                      color: MyColors.whiteColor,
                      size: getWidth(14),
                    ),
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    widget.provider.removeProductFromCart(index: widget.index);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: getWidth(26),
                  )),
            ],
          ),
        ],
      ),
    );
  }


}
