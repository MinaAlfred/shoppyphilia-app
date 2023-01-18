// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/loading_item.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/constants/widget/toast.dart';
import 'package:shoppyphilia/modules/main_tab_pages/view/main_tab_pages.dart';
import 'package:shoppyphilia/modules/shopping_cart/controller/cart_provider.dart';

class DeleteCartDialog extends StatelessWidget {
  final CartProvider provider;
  const DeleteCartDialog({
    Key key,
    this.provider,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SizedBox(
        width: size.width,
        child: Dialog(
          backgroundColor: MyColors.whiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: <Widget>[
                MyText.drawText(
                  content: 'Delete Cart',
                  fontSize: getFont(24),
                  bold: true,
                  centered: true,
                  fontColor: MyColors.blackColor,
                ),
                SpaceItem(
                  height: getHeight(10),
                ),
                MyText.drawText(
                    content: 'Are you sure you want to Delete Cart?',
                    centered: true,
                    fontSize: getFont(22),
                    fontColor: MyColors.blackColor),

                provider.isDeleteCartFetching
                    ? const LoadingItem()
                    : SpaceItem(height: getHeight(20)),
                SpaceItem(height: getHeight(10)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    /// confirm button
                    MaterialButton(
                      minWidth: getWidth(100),
                      height: getHeight(35),
                      onPressed: () async {
                        bool status =
                            await provider.deleteCart(provider.userID);
                        if (status) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MainTabPages(pageIndex: 1)),
                              (Route<dynamic> route) => false);
                          MyToast('Cart Deleted Successfully');
                        }
                      },
                      color: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: MyText.drawText(
                        content: 'Confirm',
                        fontColor: MyColors.whiteColor,
                        fontSize: getFont(19),
                      ),
                    ),
                    /// cancel button
                    MaterialButton(
                      minWidth: getWidth(100),
                      height: getHeight(35),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: MyColors.mediumGreyColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: MyText.drawText(
                        content: 'Cancel',
                        fontColor: MyColors.whiteColor,
                        fontSize: getFont(19),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
