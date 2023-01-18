import 'package:flutter/material.dart';

class SizeConfig {
  static  MediaQueryData _mediaQueryData;
  static  double screenWidth;
  static  double screenHeight;
  static  double defaultSize;
  static  Orientation orientation;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.shortestSide;
    screenHeight = _mediaQueryData.size.longestSide;
    orientation = _mediaQueryData.orientation;
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.02
        : screenWidth * 0.02;
  }
}

double getFont(double size) {
  double defaultSize = SizeConfig.defaultSize * size;
  return (defaultSize / 10);
}

double getHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight;
}

double getWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}
