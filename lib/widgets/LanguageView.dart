import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/widgets/splash/splash.dart';

class LanguageView extends StatelessWidget {
  static const routeName = '/languageView';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 26),
              margin: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Choose language',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            buildSwitchListTileMenuItem(
                context: context,
                title: 'عربي',
                subtitle: 'عربي',
                locale: Locale('ar', 'EG') //BuildContext extension method
                ),
            buildDivider(),
            buildSwitchListTileMenuItem(
              context: context,
              title: 'English',
              subtitle: 'English',
              locale: Locale('en', 'US'),
            ),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  Container buildDivider() => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Divider(
          color: Colors.grey,
        ),
      );

  Container buildSwitchListTileMenuItem(
      {BuildContext context, String title, String subtitle, Locale locale}) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      child: ListTile(
          dense: true,
          // isThreeLine: true,
          title: Text(
            title,
          ),
          subtitle: Text(
            subtitle,
          ),
          onTap: () {
            log(locale.toString(), name: toString());
            context.locale = locale; //BuildContext extension method
            Utilities.lang = locale.languageCode;
            Navigator.popUntil(
              context,
              ModalRoute.withName('/'),
            );
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashPage()),
            );
            // Navigator.of(context).pushNamed(MainScreen.routeName);
            //EasyLocalization.of(context).locale = locale;
            // Navigator.pop(context);
          }),
    );
  }
}
