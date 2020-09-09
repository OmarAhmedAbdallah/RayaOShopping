import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:oshopping/providers/cart.dart';
import 'package:oshopping/Model/product.dart';
import 'package:oshopping/providers/products_provider.dart';
import 'package:oshopping/screens/product_details_screen.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:oshopping/themes/light_color.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Another way of consumer final product = Provider.of<Product>(context);

    final product = Provider.of<Product>(context, listen: false);

    final cart = Provider.of<Cart>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //     ProductDetailsScreen.routeName,
                      //     arguments: product.id);
                    },
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl.contains("http")
                          ? product.imageUrl
                          : product.imageUrl,
                      fit: BoxFit.fitHeight,
                      placeholder: (BuildContext context, String url) => Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: AppTheme.buildLightTheme().backgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  product.title,
                                  textAlign: Utilities.lang == "en"
                                      ? TextAlign.left
                                      : TextAlign.right,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // Icon(
                                    //   FontAwesomeIcons.mapMarkerAlt,
                                    //   size: 12,
                                    //   color: AppTheme.buildLightTheme()
                                    //       .primaryColor,
                                    // ),
                                    // Expanded(
                                    //   child: Text(
                                    //     '100 km to city',
                                    //     overflow: TextOverflow.ellipsis,
                                    //     style: TextStyle(
                                    //         fontSize: 14,
                                    //         color:
                                    //             Colors.grey.withOpacity(0.8)),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(4),
                                //   child: Row(
                                //     children: <Widget>[
                                //       Text(
                                //         'Reviews',
                                //         style: TextStyle(
                                //             fontSize: 14,
                                //             color:
                                //                 Colors.grey.withOpacity(0.8)),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              product.price.toString() + ' AED',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            // Text(
                            //   '/per one',
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: Colors.grey.withOpacity(0.8)),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () async {
                    await product.toggleFavouritStatus(
                        product.id, !product.isFavourit);
                    //Add This to refresh the product list
                    Provider.of<ProductsProvider>(
                      context,
                      listen: false,
                    ).refreshProductList();
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          product.isFavourit
                              ? tr("addedLike")
                              : tr("removeAdd"),
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      product.isFavourit
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: LightColor.red,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () async {
                    await cart.addItem(product.id, product.price, product.title,
                        product.imageUrl);
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          tr("AddedItemCart"),
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              cart.removingSingleItem(product.id, product.price,
                                  product.title, product.imageUrl);
                            }),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.shopping_cart,
                      color: LightColor.red,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(10.0),
    //   child: GridTile(
    //     child: GestureDetector(
    //       onTap: () {
    //         Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
    //             arguments: product.id);
    //       },
    //       child: Image.network(
    //         product.imageUrl,
    //         fit: BoxFit.fill,
    //       ),
    //     ),
    //     footer: GridTileBar(
    //       backgroundColor: Colors.black54,
    //       //Consumer helps that this part is only will rebuilt
    //       leading: Consumer<Product>(
    //         builder: (ctx, product, child) => IconButton(
    //           icon: Icon(
    //               product.isFavourit ? Icons.favorite : Icons.favorite_border),
    //           onPressed: () {
    //             product.toggleFavouritStatus();
    //             //Add This to refresh the product list
    //             Provider.of<ProductsProvider>(
    //               context,
    //               listen: false,
    //             ).refreshProductList();
    //           },
    //           color: Theme.of(context).accentColor,
    //         ),
    //       ),
    //       title: Text(
    //         product.title,
    //         textAlign: TextAlign.center,
    //       ),
    //       trailing: IconButton(
    //         icon: Icon(
    //           Icons.shopping_cart,
    //         ),
    //         onPressed: () {
    //           cart.addItem(product.id, product.price, product.title);
    //           Scaffold.of(context).hideCurrentSnackBar();
    //           Scaffold.of(context).showSnackBar(
    //             SnackBar(
    //               content: Text(
    //                 "Added item to the cart",
    //               ),
    //               duration: Duration(seconds: 2),
    //               action: SnackBarAction(
    //                   label: 'Undo',
    //                   onPressed: () {
    //                     cart.removingSingleItem(product.id);
    //                   }),
    //             ),
    //           );
    //         },
    //         color: Theme.of(context).accentColor,
    //       ),
    //     ),
    //   ),
    // );
  }
}
