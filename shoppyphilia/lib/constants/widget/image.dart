// ignore_for_file: missing_return
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoppyphilia/constants/appColors.dart';

class MyImage {
  static Widget drawImage(String url,
      {double height = 100,
      double width = 100,
      Color color,
      fit = BoxFit.fill,
      defaultUrl = "assets/images/shoppyphilia.jpg",
      Widget defaultDesign}) {
    try {
      if (url == null) {
        if (defaultDesign != null) {
          return defaultDesign;
        } else {
          if (defaultUrl.toLowerCase().endsWith(".svg")) {
            return SvgPicture.asset(
              defaultUrl,
              width: width,
              height: height,
              fit: BoxFit.contain,
            );
          } else {
            return Image.asset(
              defaultUrl,
              width: width,
              height: height,
              fit: fit,
            );
          }
        }
      } else {
        if (url.startsWith("http")) {
          if (url.toLowerCase().endsWith(".svg")) {
            return SvgPicture.network(
              url,
              width: width,
              height: height,
              fit: fit,
              placeholderBuilder: (context) => Image.asset(
                defaultUrl,
                height: height,
                width: width,
                fit: fit,
              ),
            );
          } else {
            return Image.network(
              url,
              width: width,
              height: height,
              fit: fit,
              loadingBuilder: (context, child, c) {
                if (c == null) return child;
                return SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: MyColors.orangeColor,
                    ),
                );
              },
              errorBuilder: (context, child, error) => Image.asset(
                defaultUrl,
                height: height,
                width: width,
                fit: fit,
              ),
            );
          }
        } else {
          if (url.toLowerCase().endsWith(".svg")) {
            return color == null
                ? SvgPicture.asset(
                    url,
                    width: width,
                    height: height,
                    fit: fit,
                    placeholderBuilder: (context) => Image.asset(
                      defaultUrl,
                      height: height,
                      width: width,
                      fit: fit,
                    ),
                  )
                : SvgPicture.asset(
                    url,
                    width: width,
                    height: height,
                    color: color,
                    fit: fit,
                    placeholderBuilder: (context) => Image.asset(
                      defaultUrl,
                      height: height,
                      width: width,
                      fit: fit,
                    ),
                  );
          } else if (url.startsWith("assets/images")) {
            return Image.asset(
              url,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (context, child, error) => Image.asset(
                defaultUrl,
                height: height,
                width: width,
                fit: fit,
              ),
            );
          } else {
            return Image.file(
              File(url),
              fit: fit,
              errorBuilder: (context, child, error) => Image.asset(
                defaultUrl,
                height: height,
                width: width,
                fit: fit,
              ),
            );
          }
        }
      }
    } catch (e) {}
  }
}
