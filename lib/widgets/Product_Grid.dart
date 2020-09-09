import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/product.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import 'package:oshopping/widgets/product_item.dart';

class ProductGrid extends StatefulWidget {
  final bool showFav;
  final bool showSearch;
  String _catId = "";
  ProductGrid(this.showFav, this._catId, this.showSearch);

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Product> products = [];
  var _isInit = true;
  List<Product> productData = [];

  Future _getProducts;
  int firstTime = 0;
  Widget _emptyFav() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
              child: Container(
                color: Color(0xFFFFFFFF),
              ),
            ),
            Container(
              width: double.infinity,
              height: 250,
              color: Color(0xFFFFFFFF),
              child: Image.asset(
                "assets/images/empty_wish_list.png",
                height: 250,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 40,
              child: Container(
                color: Color(0xFFFFFFFF),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                tr("EmptyFav"),
                style: TextStyle(
                  color: Color(0xFF67778E),
                  fontFamily: 'Roboto-Light.ttf',
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //this line make widget rebuilt after like
    Provider.of<ProductsProvider>(context);
    // if (firstTime == 0) {
    final products = ProductsProvider();

    _getProducts = widget.showSearch
        ? products.searchProductsItems(widget._catId)
        : !widget.showFav
            ? products.allProductsItems(widget._catId)
            : products.favoritsProductsItems();
    firstTime = 1;
    // }
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            height: 5000,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            color: AppTheme.buildLightTheme().backgroundColor,
            child: FutureBuilder(
              future: _getProducts,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (snapshot.data.length == 0) {
                    return _emptyFav();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.only(top: 8),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = snapshot.data[index];
                      animationController.forward();
                      return ChangeNotifierProvider.value(
                        value: product,
                        child: ProductItem(),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
