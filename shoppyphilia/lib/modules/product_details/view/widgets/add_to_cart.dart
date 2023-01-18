import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';

class AddCartButton extends StatelessWidget {
  final Function() onTap;
  final double paddingValue;
  final bool isLarge;
  const AddCartButton({Key key, this.onTap, this.paddingValue = 5, this.isLarge =false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
          padding: EdgeInsets.all(paddingValue),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.orangeColor),
            color: MyColors.whiteColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: MyColors.blackColor,
                size: getWidth(isLarge?30:25),
              ),
              Text(
                "Add to cart",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.blackColor,
                    fontSize: getFont(isLarge?19  :16)),
              )
            ],
          )),
    );
  }
}
