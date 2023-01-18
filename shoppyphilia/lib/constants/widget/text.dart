import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText {
  static Text drawText({
    String content = "",
    double fontSize = 12,
    Color fontColor = Colors.black26,
    bool bold = false,
    bool centered = false,
    TextOverflow overflow = TextOverflow.clip,
    int maxLines = 20,
  }) {
    return Text(
      content,
      maxLines: maxLines,
      style: GoogleFonts.roboto(
          textStyle: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: bold ? FontWeight.bold : FontWeight.w400,
      )),
      textAlign: centered ? TextAlign.center : TextAlign.start,
    );
  }
}
