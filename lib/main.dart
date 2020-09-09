import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oshopping/helpers/static_variable.dart';
import 'package:oshopping/routes/custom_route.dart';
import 'package:oshopping/widgets/splash/splash.dart';

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: supportedLanguages,
      path: 'values/strings',
      fallbackLocale: Locale('en', 'US'),
      child: MaterialApp(
        home: OnlineShopping(),
      ),
    ),
  );
}

class OnlineShopping extends StatefulWidget {
  OnlineShopping() {
    //for routing
    final router = Router();
    CustomRoute.configureRoutes(router);
    Variables.router = router;
  }

  @override
  _OnlineShoppingState createState() => _OnlineShoppingState();
}

class _OnlineShoppingState extends State<OnlineShopping> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //use .value when the provider not depend on context and builder:(insted of value:) when it use context
    // and use builder when create new enstance

    //to change localization
    // context.locale = Locale('en', 'US');

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SplashPage();
  }
}

var supportedLanguages = [
  Locale('en', 'US'),
  Locale('fr', 'FR'),
  Locale('ar', 'EG'),
  Locale('es', 'ES'),
  Locale('de', 'DE'),
  Locale('it', 'IT'),
  Locale('id', 'ID'),
  Locale('hi', 'IN'),
  Locale('fa', 'PE'),
  Locale('ur', 'PK'),
  Locale('tr', 'TR'),
  Locale('ru', 'RU'),
];
