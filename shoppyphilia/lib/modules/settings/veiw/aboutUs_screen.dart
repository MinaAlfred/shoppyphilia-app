import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/appbar.dart';
import 'package:shoppyphilia/constants/widget/image.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/modules/main_tab_pages/view/main_tab_pages.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _AboutUsProviderBody();
  }
}

class _AboutUsProviderBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutUsProviderBodyState();
  }
}

class _AboutUsProviderBodyState extends State<_AboutUsProviderBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// appbar
            MyAppbar(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainTabPages(pageIndex: 2)));
              },
              title: 'About Us',
              isCart: false,
              isBack: true,
            ),
            SpaceItem(height: getHeight(10)),
            /// app logo
            Center(
              child: MyImage.drawImage(
                'assets/images/shoppyphilia.jpg',
                width: getWidth(200),
                height: getHeight(200),
              ),
            ),

            /// about us content
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: getWidth(1.5), color: MyColors.mediumGreyColor)),
              child: MyText.drawText(
                maxLines: 15,
                content:
                    'Shoppyphilia is an e-commerce app that help users to buy products. Process orders, accept payments, produce receipts, and control it all from your mobile device. Shoppyphilia is beneficial both for business owners and their customers. Brands can better engage their customers in a dedicated space and customers can personalize and control their experience.',
                fontSize: getFont(21),
                fontColor: MyColors.blackColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
