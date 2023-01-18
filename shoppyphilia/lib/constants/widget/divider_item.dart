import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';

class DividerItem extends StatelessWidget {
  const DividerItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Divider(
        color: MyColors.lightGreyColor,
        thickness: 1,
      ),
    );
  }
}
