import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppyphilia/constants/appColors.dart';

mixin InputValidation {
  //----------------------------------------------------(Regex)
  RegExp containNumberRegex = RegExp(r'[0-9]');

  RegExp containDoubleNumberRegex =
      RegExp("^[-+]?[0-9]+(,[0-9]{3})*(\.[0-9]+)?([eE][-+]?[0-9]+)?");

  /// email validation
  RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// phone number validation
  RegExp phoneNumberRegex = RegExp(r'^(?:[0][1][0125])[0-9]{8}$');

  //----------------------------------------------------(methods)
  String validateName(String name) {
    if (name.contains('<') ||
        name.contains('>') ||
        name.contains('(') ||
        name.contains(')')) {
      return "You cant use '< > ( )'";
    }

    if (name.isEmpty) {
      return ("Name is required");
    }
    return null;
  }

  String validateEmail(String email) {
    if (email.contains('<') ||
        email.contains('>') ||
        email.contains('(') ||
        email.contains(')')) {
      return "You cant use '< > ( )'";
    }
    if (email.isEmpty) {
      return "Email can't be empty";
    }
    if (!emailRegex.hasMatch(email)) {
      return "Email is not valid";
    }
    return null;
  }

  String validateNotEmpty(String text) {
    if (text.isEmpty) {
      return "field can't be empty";
    }
    return null;
  }

  String validateLoginInput(String value) {
    if (value.contains('<') ||
        value.contains('>') ||
        value.contains('(') ||
        value.contains(')')) {
      return "You cant use '< > ( )'";
    }
    if (value.isEmpty) {
      return "Can't be Empty";
    }

    return null;
  }

  String validateNumber(String number) {
    if (number.contains('<') ||
        number.contains('>') ||
        number.contains('(') ||
        number.contains(')')) {
      return "You cant use '< > ( )'";
    }
    if (!containDoubleNumberRegex.hasMatch(number)) {
      return "Enter Numbers only";
    }
    return null;
  }

  String validatePhoneNumber(String number) {
    if (number.contains('<') ||
        number.contains('>') ||
        number.contains('(') ||
        number.contains(')')) {
      return "You cant use '< > ( )'";
    }
    if (!containNumberRegex.hasMatch(number)) {
      return "Please enter Numbers only";
    }
    if (number.length > 11 || number.length < 11) {
      return "Please enter 11 numbers only";
    }
    if (number.isEmpty) {
      return "Please enter your number";
    }
    return null;
  }

  //----------------------------------------------------(Text Form field )
  /// customized TextFormField
  Padding getTextInputField(
      {String content = '',
      String hintText,
      String labelText,
      double fontSize = 13,
      double hintFontSize = 17,
      Color fontColor,
      Color hintFontColor,
      TextInputType keyboardType = TextInputType.text,
      bool isPasswordField = false,
      TextEditingController controller,
      Function validatorFunction,
      Function onChanged,
      Function onPressed,
      TextInputAction textInputAction,
      AutovalidateMode autoValidationMode,
      List<TextInputFormatter> inputFormatters,
      bool enabled = true,
      suffix,
      double padding,
      int maxLines,
      Color fillColor,
      prefix}) {
    return Padding(
      padding: EdgeInsets.only(left: padding ?? 16, right: padding ?? 16),
      child: Column(
        children: [
          TextFormField(
            maxLines: maxLines ?? 1,
            autovalidateMode:
                autoValidationMode ?? AutovalidateMode.onUserInteraction,
            inputFormatters: [],
            controller: controller,
            obscureText: isPasswordField,
            keyboardType: keyboardType,
            validator: validatorFunction,
            onChanged: onChanged,
            onEditingComplete: onPressed,
            textInputAction: textInputAction,
            /// text field style
            cursorColor: MyColors.orangeColor,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: labelText == null ? 19 : 11, horizontal: 12.0),

              /// Label Text
              labelText: labelText,
              labelStyle: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: hintFontColor ?? MyColors.blackColor,
                  fontSize: hintFontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              /// Hint text
              hintText: hintText,
              hintStyle: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: hintFontColor ?? MyColors.mediumGreyColor,
                  fontSize: hintFontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              fillColor: fillColor?? MyColors.textFieldBackground,
              filled: true,
              enabled: enabled,
              prefixIcon: prefix ?? null,
              suffixIcon: suffix ?? null,
            ),
          ),
        ],
      ),
    );
  }
}
