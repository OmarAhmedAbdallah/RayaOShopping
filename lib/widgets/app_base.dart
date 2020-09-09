import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/my_connection.dart';
import 'package:oshopping/screens/CheckOutPage.dart';
import 'package:oshopping/screens/about_us.dart';
import 'package:oshopping/screens/favourite_screen.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/screens/orders_screen.dart';
import 'package:oshopping/screens/prodeuct_overview_screen.dart';
import 'package:oshopping/screens/subCategoryCustom_screen.dart';
import 'package:oshopping/screens/term_conditions.dart';
import 'package:oshopping/widgets/Auth/loginPage.dart';
import 'LanguageView.dart';
import 'custom_drawer/drawer_user_controller.dart';
import 'custom_drawer/home_drawer.dart';

class AppBase extends StatefulWidget {
  AppBase(
      {this.title, @required this.body, this.onBackPressed, this.drawerIndex});

  final String title;
  Widget body;
  DrawerIndex drawerIndex;
  Function onBackPressed;

  AppBaseState appBaseNewState = AppBaseState();

  @override
  AppBaseState createState() => appBaseNewState;
}

class AppBaseState extends State<AppBase> {
  DrawerUserController sideMenu;
  bool showBox = false;
  MyConnectivity _connectivity = MyConnectivity.instance;
  Map _source = {ConnectivityResult.none: false};

  int firstTime = 0;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    widget.drawerIndex = drawerIndexdata;
    if (widget.drawerIndex == DrawerIndex.HOME) {
      setState(() {
        // widget.body = MainScreen();
        Navigator.of(context).pushNamed(MainScreen.routeName);
      });
    } else if (widget.drawerIndex == DrawerIndex.About) {
      setState(() {
        // widget.body = AboutUsScreen();
        Navigator.of(context).pushNamed(AboutUsScreen.routeName);
      });
    } else if (widget.drawerIndex == DrawerIndex.Products) {
      setState(() {
        // widget.body = ProductsOverviewScreen();
        Navigator.of(context).pushNamed(ProductsOverviewScreen.routeName);
      });
    } else if (widget.drawerIndex == DrawerIndex.Orders) {
      setState(() {
        // widget.body = OrdersScreen();
        Navigator.of(context).pushNamed(OrdersScreen.routeName);
      });
    } else if (widget.drawerIndex == DrawerIndex.Setting) {
      setState(() {
        // widget.body = OrdersScreen();
        Navigator.of(context).pushNamed(LanguageView.routeName);
      });
    } else if (widget.drawerIndex == DrawerIndex.Login) {
      Navigator.of(context).pushNamed(LoginPage.routeName);
    } else if (widget.drawerIndex == DrawerIndex.Favourites) {
      Navigator.of(context).pushNamed(Favourite_screen.routeName);
    } else if (widget.drawerIndex == DrawerIndex.SubCategoryCustom) {
      Navigator.of(context).pushNamed(SubCategoriesCustomTabs.routeName);
    } else if (widget.drawerIndex == DrawerIndex.Terms) {
      Navigator.of(context).pushNamed(TermsAndConditionsScreen.routeName);
    } else {
      //do in your way......
    }
    // if (widget.drawerIndex == drawerIndexdata) {
    //   Navigator.of(context).pop();
    // }

    // }
  }

  @override
  Widget build(BuildContext context) {
    bool connection;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        firstTime++;
        connection = false;
        break;
      case ConnectivityResult.mobile:
        firstTime++;
        connection = true;
        break;
      case ConnectivityResult.wifi:
        firstTime++;
        connection = true;
    }
    sideMenu = DrawerUserController(
      screenIndex: widget.drawerIndex,
      drawerWidth: MediaQuery.of(context).size.width * 0.75,
      onDrawerCall: (DrawerIndex drawerIndexdata) {
        changeIndex(drawerIndexdata);
        //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
      },
      screenView: widget.body,
      //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
    );
    return Scaffold(
      body: connection
          ? sideMenu
          : firstTime != 1
              ? new Center(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.signal_wifi_off,
                          size: 150,
                        ),
                        Text(tr("network_error"))
                      ]),
                )
              : sideMenu,
    );
  }
}
