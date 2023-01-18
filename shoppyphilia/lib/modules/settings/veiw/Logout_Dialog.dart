import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppyphilia/Data_access_layer/sharedpref_constants.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/modules/login/veiw/login_screen.dart';

class LogoutProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LogoutProviderBody();
  }
}

class LogoutProviderBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: size.width,
        child: Dialog(
          backgroundColor: MyColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.all(Radius.circular(5)),
          ),
          child: Container(
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: <Widget>[
                /// logout title
                Container(
                  alignment: Alignment.center,
                  child: MyText.drawText(
                      content: 'Logout',
                      fontSize: getFont(24),
                      fontColor: MyColors.blackColor,
                      bold: true),
                ),
                 SpaceItem(height: getHeight(10)),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  alignment: Alignment.center,
                  child: MyText.drawText(
                      content: 'Are you sure you want to logout?',
                      fontSize: getFont(22),
                      fontColor: MyColors.blackColor,
                       ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    /// confirm button
                    Container(
                      child: MaterialButton(
                        minWidth: getWidth(100),
                        height: getHeight(35),
                        onPressed: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.remove(SharedPrefConstants.userState);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()),
                                  (Route<dynamic> route) => false);

                        },
                        highlightColor: Colors.transparent,
                        color: MyColors.orangeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                           BorderRadius.all(Radius.circular(5)),
                        ),
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: MyText.drawText(
                          content: 'Confirm',
                          fontSize: getFont(19),
                          fontColor: MyColors.whiteColor,
                        ),
                      ),
                    ),
                    /// cancel button
                    Container(
                      child: MaterialButton(
                        minWidth: getWidth(100),
                        height: getHeight(35),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        highlightColor: Colors.transparent,
                        color: MyColors.mediumGreyColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                               BorderRadius.all(Radius.circular(5)),
                        ),
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child:MyText.drawText(
                          content: 'Cancel',
                          fontSize: getFont(19),
                          fontColor: MyColors.whiteColor,
                        ),
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
