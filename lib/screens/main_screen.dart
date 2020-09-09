import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/providers/cart.dart';
import 'package:oshopping/Model/product.dart';
import 'package:oshopping/providers/products_provider.dart';
import 'package:oshopping/screens/prodeuct_overview_screen.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';
import 'package:oshopping/widgets/categories.dart';
import 'package:oshopping/widgets/shared_widgets/carousel_slider.dart';
import 'package:oshopping/widgets/shared_widgets/search_bar.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SearchBar searchBar;
  @override
  void initState() {
    super.initState();
  }

  changeLanguage(Locale locale) {
    setState(() {});
  }

  void filterSearch(String keyword) {
    Navigator.pushNamed(
      context,
      ProductsOverviewScreen.routeName,
      arguments: "showSearchWord"+keyword,
    );
    print(keyword);
  }

  @override
  Widget build(BuildContext context) {
    searchBar = new SearchBar(filterSearch);
    // final cart = Provider.of<Cart>(context, listen: false);
    // final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      body: AppBase(
        body: Column(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: ApplicationTopBar(pageName: "RAYA"),
            ),
            // drawer: AppDrawer(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    searchBar,
                    CarouselWithIndicatorDemo(),
                    CategoriesTabs(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
