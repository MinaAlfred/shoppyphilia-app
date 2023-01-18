import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/image.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/modules/home/controller/home_provider.dart';

class ProductItem extends StatelessWidget {
  final HomeProvider myProvider;
  final int productIndex;
  final int productId;
  final String productName;
  final String productPrice;
  final String productCategory;
  final String productImage;
  final String rating;
  const ProductItem(
      {Key key,
      this.productName,
      this.productPrice,
      this.productCategory,
      this.myProvider,
      this.productId,
      this.productIndex,
      this.productImage,
      this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getHeight(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    productImage.startsWith('assets/')
                        ? Container(
                            width: getWidth(70),
                            height: getHeight(70),
                            color: Colors.grey[200],
                            child: Center(
                              child: MyText.drawText(
                                content: "No Image",
                                fontSize: getFont(15),
                                fontColor: MyColors.mediumGreyColor,
                                bold: true,
                              ),
                            ),
                          )
                        : MyImage.drawImage(
                            productImage,
                            width: getWidth(60),
                            height: getHeight(60),
                          ),
                    SpaceItem(
                      width: getWidth(20),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.drawText(
                              content: productName,
                              overflow: TextOverflow.ellipsis,
                              fontSize: getFont(20),
                              fontColor: Colors.black,
                              bold: true),
                          SpaceItem(
                            height: getHeight(5),
                          ),
                          MyText.drawText(
                            content: productCategory,
                            fontColor: MyColors.orangeColor,
                            fontSize: getFont(18),
                          ),
                          SpaceItem(
                            height: getHeight(5),
                          ),
                          MyText.drawText(
                            content: 'rating: $rating',
                            fontColor: MyColors.greenColor,
                            fontSize: getFont(18),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SpaceItem(width:getWidth(10)),
              MyText.drawText(
                  content: '$productPrice LE',
                  fontColor: MyColors.petroleumColor,
                  fontSize: getFont(19),bold: true),
            ],
          ),
        ],
      ),
    );
  }
}
