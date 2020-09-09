import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/widgets/Product_Grid.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';
import '../widgets/Product_Grid.dart';

class Favourite_screen extends StatefulWidget {
  static const routeName = '/favourite_screen';
  var _showOnlyFavorites = true;

  @override
  _Favourite_screenState createState() => _Favourite_screenState();
}

class _Favourite_screenState extends State<Favourite_screen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBase(
        body: Column(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: ApplicationTopBar(pageName: "RAYA"),
            ),
            Flexible(
              child: ProductGrid(widget._showOnlyFavorites, "", false),
            ),
          ],
        ),
      ),
    );
  }
}
