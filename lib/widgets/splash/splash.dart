import 'package:flutter/material.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:oshopping/themes/light_color.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:easy_localization/easy_localization.dart';
import '../home.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utilities.lang = context.locale.languageCode;
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new Home(),
      image: new Image.asset("assets/images/logoSm.png"),
      gradientBackground: new LinearGradient(
          colors: [LightColor.lightWhite, LightColor.lightWhite],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }
}
