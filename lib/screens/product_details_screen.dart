import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:oshopping/providers/cart.dart';
import 'package:oshopping/Model/product.dart';
import 'package:oshopping/providers/products_provider.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:oshopping/themes/light_color.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';
import 'package:oshopping/widgets/custom_drawer/drawer_user_controller.dart';
import 'package:oshopping/widgets/title_text.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "./product-details";

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  bool isLiked = true;

  Widget _productImage(Product product) {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          TitleText(
            text: "AIP",
            fontSize: 160,
            color: LightColor.lightGrey,
          ),
          
          CachedNetworkImage(
            imageUrl: Utilities.url + "/public/data/large/" + product.imageUrl,
            placeholder: (BuildContext context, String url) => Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 30.0,
                width: 30.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _detailWidget(Product product) {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    product.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  product.price.toString() + ' AED',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                // Row(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: <Widget>[
                //       Container(
                //         decoration: BoxDecoration(
                //             color: Colors.red, shape: BoxShape.circle),
                //         width: 30,
                //         height: 30,
                //         margin: EdgeInsets.all(5),
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: Colors.green, shape: BoxShape.circle),
                //         width: 30,
                //         height: 30,
                //         margin: EdgeInsets.all(5),
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: Colors.yellow, shape: BoxShape.circle),
                //         width: 30,
                //         height: 30,
                //         margin: EdgeInsets.all(5),
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: Colors.pink, shape: BoxShape.circle),
                //         width: 30,
                //         height: 30,
                //         margin: EdgeInsets.all(5),
                //       ),
                //     ]),
                _description(product),
              ],
            ),
          ),
        );
      },
    );
  }

  FloatingActionButton _flotingButton(
      BuildContext context, Cart cart, Product product) {
    return FloatingActionButton(
      onPressed: () async {
        await cart.addItem(product.id, product.price, product.title,product.imageUrl);
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Added item to the cart",
            ),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  cart.removingSingleItem(product.id, product.price, product.title,product.imageUrl);
                }),
          ),
        );
      },
      backgroundColor: LightColor.orange,
      child: Icon(Icons.shopping_cart,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  Widget _description(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Description",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Text(product.description),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final cart = Provider.of<Cart>(context, listen: false);

    final loadedProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      floatingActionButton: _flotingButton(context, cart, loadedProduct),
      body: AppBase(
        body: Column(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: ApplicationTopBar(pageName: "RAYA"),
            ),
            SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height - 70 - 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _productImage(loadedProduct),
                      ],
                    ),
                    _detailWidget(loadedProduct)
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
