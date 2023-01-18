import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/Provider/main_provider.dart';
import 'package:shoppyphilia/modules/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual, overlays: SystemUiOverlay.values,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      ChangeNotifierProvider<MainProvider>(
        create: (context) => MainProvider(),
        child: MaterialApp(
          home: Splash(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}
