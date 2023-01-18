import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/toast.dart';
import 'package:shoppyphilia/modules/main_tab_pages/view/main_tab_pages.dart';
import 'package:shoppyphilia/modules/product_details/view/widgets/add_to_cart.dart';
import '../../controller/product_details_provider.dart';

class AddCartItem extends StatefulWidget {
  final ProductDetailsProvider myProvider;
  const AddCartItem(
      {Key key, this.myProvider})
      : super(key: key);

  @override
  State<AddCartItem> createState() => _AddCartItemState();
}

class _AddCartItemState extends State<AddCartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getHeight(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AddCartButton(
            onTap: () async {
              MyToast('Product Added Successfully');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainTabPages(
                              pageIndex: 1
                          )));
                },
            isLarge: true,
            paddingValue: 10,
          ),
        ],
      ),
    );
  }
}
