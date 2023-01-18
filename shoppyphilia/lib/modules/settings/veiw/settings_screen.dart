import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/appbar.dart';
import 'package:shoppyphilia/constants/widget/divider_item.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/constants/widget/toast.dart';
import 'package:shoppyphilia/modules/settings/veiw/Logout_Dialog.dart';
import 'package:shoppyphilia/modules/settings/veiw/aboutUs_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SettingsScreenProviderBody();
  }
}

class _SettingsScreenProviderBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenProviderBodyState();
  }
}

class _SettingsScreenProviderBodyState
    extends State<_SettingsScreenProviderBody> {
  @override
  Widget build(BuildContext context) {
    DateTime _lastExitTime = DateTime.now();
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          if (DateTime.now().difference(_lastExitTime) >=
              Duration(seconds: 2)) {
            MyToast(
              'Press the back button again to exist the application',
            );
            _lastExitTime = DateTime.now();
            return false; // disable back press
          } else {
            return true; //  exit the app
          }
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// appbar
              MyAppbar(
                title: 'Settings',
                isCart: false,
              ),
              SpaceItem(height: getHeight(20)),

              ///aboutUs button
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: MyColors.whiteColor,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded,
                          color: MyColors.orangeColor),
                      SpaceItem(width: getWidth(10)),
                      MyText.drawText(
                          content: 'About Us',
                          fontSize: getFont(20),
                          fontColor: MyColors.blackColor,
                          bold: true),
                    ],
                  ),
                ),
              ),
              const DividerItem(),

              ///logout button
              InkWell(
                onTap: () {
                  showDialog(
                    builder: (context) => Container(
                      alignment: Alignment.center,
                      child: LogoutProviderDemo(),
                    ),
                    context: context,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: MyColors.whiteColor,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.logout, color: MyColors.orangeColor),
                      SpaceItem(width: getWidth(10)),
                      MyText.drawText(
                          content: 'LogOut',
                          fontSize: getFont(20),
                          fontColor: MyColors.blackColor,
                          bold: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
