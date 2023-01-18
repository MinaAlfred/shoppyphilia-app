import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/modules/home/controller/home_provider.dart';

class CategoryTabItem extends StatelessWidget {
  final int categoryID;
  const CategoryTabItem({Key key, this.categoryID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, HomeProvider myProvider,
              Widget child) =>
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 10, left: 4, bottom: 4),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
              myProvider.categoriesList.length,
              (index) => Card(
                    elevation: myProvider.selectedCategory == index ? 5 : 2,
                    color: myProvider.selectedCategory == index
                        ? MyColors.orangeColor
                        : MyColors.whiteColor,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          myProvider.changeSelectedCategoryValue(
                              index: index);
                          myProvider.getAllProductsByCategory(myProvider.categoriesList[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            myProvider.categoriesList[index]
                                .toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: myProvider.selectedCategory == index
                                  ? getFont(20)
                                  : getFont(17),
                              color: myProvider.selectedCategory == index
                                  ? MyColors.whiteColor
                                  : MyColors.blackColor,
                            ),
                          ),
                        )),
                  )),
        ),
      ),
    );
  }
}
