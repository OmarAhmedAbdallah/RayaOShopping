import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/widgets/Product_Grid.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';
import '../widgets/Product_Grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview';
  var _showOnlyFavorites = false;

  final Map<String, List<String>> categoryId;
  ProductsOverviewScreen(this.categoryId);
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    String args = ModalRoute.of(context).settings.arguments;
    bool showSearch = false;
    if (args.contains("showSearchWord")) {
      args = args.replaceAll('showSearchWord', '');
      showSearch = true;
    }
    return Scaffold(
      body: AppBase(
        body: Column(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: ApplicationTopBar(pageName: "RAYA"),
            ),
            Text(
              tr("Products"),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: ProductGrid(widget._showOnlyFavorites, args, showSearch),
            ),
          ],
        ),
      ),
    );
  }
}
