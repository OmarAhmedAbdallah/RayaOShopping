import 'package:flutter/material.dart';
import 'package:oshopping/screens/about_us.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/screens/orders_screen.dart';
import 'package:oshopping/screens/prodeuct_overview_screen.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:oshopping/widgets/Auth/loginPage.dart';

import 'custom_drawer/drawer_user_controller.dart';
import 'custom_drawer/home_drawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  static const routeName = '/navigation-home';

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = MainScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = MainScreen();
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          screenView = AboutUsScreen();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          // screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerIndex.Products) {
        // setState(() {
        //   screenView = ProductsOverviewScreen();
        // });
      } else if (drawerIndex == DrawerIndex.Orders) {
        setState(() {
          screenView = OrdersScreen();
        });
      } else if (drawerIndex == DrawerIndex.Login) {
        setState(() {
          screenView = LoginPage();
        });
      } else {
        //do in your way......
      }
    }
  }
}
