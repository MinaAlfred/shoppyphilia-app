import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: MyColors.orangeColor,
        ),
      ),
    );
  }
}
