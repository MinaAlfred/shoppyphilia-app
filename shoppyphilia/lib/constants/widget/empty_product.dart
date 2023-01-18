import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/image.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';

class EmptyProducts extends StatelessWidget {
  const EmptyProducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 160),
      child: Column(
        children: [
          Center(
            child: MyImage.drawImage(
              'assets/images/notFound.png',
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
           SpaceItem(
            height: getHeight(20),
          ),
          Center(
            child: MyText.drawText(
               content: 'No Products found',
                  fontColor: MyColors.blackColor,
                  fontSize: getHeight(20)),
          ),
        ],
      ),
    );
  }
}
