import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppyphilia/Data_access_layer/sharedpref_constants.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/modules/login/veiw/login_screen.dart';
import 'package:shoppyphilia/modules/main_tab_pages/view/main_tab_pages.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var userState;
  getUserState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userState = sharedPreferences.getString(SharedPrefConstants.userState);
  }

  @override
  void initState() {
    getUserState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: MyColors.whiteColor,
      child: AnimatedSplashScreen(
          duration: 3000,
          centered: true,
          splashIconSize: 500,
          animationDuration: const Duration(seconds: 3),
          splash: Column(
            children: [
              /// app logo
              Transform.scale(
                scale: 0.7,
                child: Image.asset(
                  'assets/images/shoppyphilia.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              /// loading indicator
              Transform.scale(
                scale: 0.5,
                child: LinearProgressIndicator(
                  minHeight: getHeight(7),
                  backgroundColor: MyColors.whiteColor,
                  color: MyColors.orangeColor,
                ),
              ),
            ],
          ),
          nextScreen: userState == 'loggedIn'
              ? MainTabPages(pageIndex: 1)
              : LoginScreen(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Colors.transparent),
    );
  }
}
