import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';

class MyToast {
  MyToast(message, {double fontSize, Color fontColor, Color background,String color}) {
    Fluttertoast.showToast(
        webBgColor: color,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 15,
        msg: message.toString(),
        fontSize: fontSize ?? getFont(20),
        textColor: MyColors.blackColor,
        backgroundColor: MyColors.textFieldBackground);
  }
}
