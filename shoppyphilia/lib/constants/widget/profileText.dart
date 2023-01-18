import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';

class MyProfileText {
  static Padding drawProfileText({
    String title = "",
    String profileData = "",
    double fontSize = 12,
    Color fontColor = Colors.black26,
    bool bold = false,
    bool centered = false,
    TextOverflow overflow = TextOverflow.clip,
    int maxLines = 20,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: MyColors.textFieldBackground,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(width: getWidth(2), color: MyColors.textFieldBackground)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.drawText(
                content: title,
                maxLines: maxLines,
                fontColor: MyColors.blackColor,
                fontSize: getFont(19),
                bold: true,
                centered: centered ? true : false,
              ),
              SpaceItem(height: getHeight(5)),
              MyText.drawText(
                content: profileData,
                maxLines: maxLines,
                fontColor: MyColors.petroleumColor,
                fontSize: getFont(19),
                bold: false,
                centered: centered ? true : false,
              ),
            ],
          )),
    );
  }
}
