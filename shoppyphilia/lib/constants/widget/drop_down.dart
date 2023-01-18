import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';

class DropDownMenuItem extends StatelessWidget {
  final Color itemColor;
  final Color dropMenuColor;
  final Color dropDownMenusColor;

  final Size size;
  final String value;
  final List<String> items;
  final bool isWithShadow;
  final Function(dynamic val) onChange;
  const DropDownMenuItem({
    Key key,
     this.size,
     this.value,
     this.items,
     this.onChange,
     this.itemColor,
     this.dropMenuColor,
     this.dropDownMenusColor,
    this.isWithShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 15),
      child: Container(
        height: getHeight(57),
        decoration: BoxDecoration(
            color: dropDownMenusColor,
            borderRadius: BorderRadius.circular(20)),
        child: DropdownButton(
            value: value,
            style: TextStyle(color: itemColor, fontSize: getFont(20)),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: itemColor,
              size:getHeight(30),
            ),
            elevation: 20,
            dropdownColor: dropMenuColor,
            items: items.map((String areaList) {
              return DropdownMenuItem(
                value: areaList,
                child: Text(areaList),
              );
            }).toList(),
            onChanged: onChange),
        padding: EdgeInsets.symmetric(
            vertical: size.longestSide * .009,
            horizontal: size.shortestSide * .02),
      ),
    );
  }
}
