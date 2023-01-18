import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';

class ProductInfo extends StatelessWidget {
  final String productName;
  final String productId;
  final String category;
  final String price;
  final String description;
  final String rating;
  const ProductInfo(
      {Key key,
       this.productName,
       this.category,
       this.price,
       this.description,
       this.productId,
       this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                productName,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: getFont(24),
                  fontWeight: FontWeight.bold,
                  color: MyColors.blackColor,
                ),
              ),
            ),
            SizedBox(
              width: getWidth(18),
            ),
            Text(
              "$price LE",
              style: TextStyle(
                  fontSize: getFont(21),
                  fontWeight: FontWeight.w500,
                  color: MyColors.petroleumColor),
            )
          ],
        ),
        SizedBox(
          height: getHeight(10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(
                  fontSize: getFont(20),
                  fontWeight: FontWeight.w500,
                  color: MyColors.orangeColor),
            )
          ],
        ),
        SizedBox(
          height: getHeight(10),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'rating: $rating',
              style: TextStyle(
                  fontSize: getFont(20),
                  fontWeight: FontWeight.w500,
                  color: MyColors.greenColor),
            )
          ],
        ),
        SizedBox(
          height: getHeight(10),
        ),
        Text(
          description,
          style: TextStyle(fontSize: getFont(20), fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
