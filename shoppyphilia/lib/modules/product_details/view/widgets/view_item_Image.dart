import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/image.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/modules/product_details/controller/product_details_provider.dart';

class ViewProductImage extends StatefulWidget {
  final String productImage;
  const ViewProductImage({
    Key key,
     this.productImage,
  }) : super(key: key);

  @override
  State<ViewProductImage> createState() => _ViewProductImageState();
}

class _ViewProductImageState extends State<ViewProductImage> {
  SwiperController swipeController = SwiperController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getHeight(20), horizontal: getWidth(15)),
      child: Consumer(
        builder: (context, ProductDetailsProvider myProvider, child) =>
            widget.productImage == null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: getHeight(200),
                    color: Colors.grey[200],
                    child: Center(
                      child: MyText.drawText(
                       content: "No Image!",
                            fontSize: getFont(18),
                            fontColor: MyColors.mediumGreyColor,
                            bold: true),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: getHeight(220),
                        child: Swiper(
                          scrollDirection: Axis.horizontal,
                          controller: swipeController,
                          containerWidth:size.width,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return MyImage.drawImage(
                              widget.productImage,
                              width: size.width,
                              fit: BoxFit.fill,
                            );
                          },
                          ),
                        ),
                    ],
                  ),
      ),
    );
  }
}
