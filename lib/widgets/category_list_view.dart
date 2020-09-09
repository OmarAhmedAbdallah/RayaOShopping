import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oshopping/Model/category.dart';
import 'package:oshopping/screens/prodeuct_overview_screen.dart';
import 'package:oshopping/screens/subCategory_screen.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:provider/provider.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView(
      {Key key,
      this.categoryData,
      this.animationController,
      this.isSubCateory,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Categories categoryData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final bool isSubCateory;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Categories>(context, listen: false);
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  callback();
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                isSubCateory
                                    ? Navigator.of(context).pushNamed(
                                        ProductsOverviewScreen.routeName)
                                    : Navigator.pushNamed(
                                        context,
                                        ProductsOverviewScreen.routeName,
                                        arguments: categoryData.idCategory,
                                      );

                                //  Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             SubCategoriesTabs(
                                //                 categoryData.subCategory),
                                //       ),
                                //     );
                              },
                              child: AspectRatio(
                                aspectRatio: 2,
                                child: CachedNetworkImage(
                                  imageUrl: categoryData.imagePath,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (BuildContext context, String url) =>
                                          Center(
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
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 2,
                                            top: 8,
                                            bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              categoryData.titleTxt,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                // Text(
                                                //   categoryData.subTxt,
                                                //   style: TextStyle(
                                                //       fontSize: 14,
                                                //       color: Colors.grey
                                                //           .withOpacity(0.8)),
                                                // ),
                                                // const SizedBox(
                                                //   width: 4,
                                                // ),
                                                // Icon(
                                                //   FontAwesomeIcons.mapMarkerAlt,
                                                //   size: 12,
                                                //   color:
                                                //       AppTheme.buildLightTheme()
                                                //           .primaryColor,
                                                // ),
                                                // Expanded(
                                                //   child: Text(
                                                //     '${categoryData.dist.toStringAsFixed(1)} km to city',
                                                //     overflow:
                                                //         TextOverflow.ellipsis,
                                                //     style: TextStyle(
                                                //         fontSize: 14,
                                                //         color: Colors.grey
                                                //             .withOpacity(0.8)),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        // Text(
                                        //   '\$${categoryData.price}',
                                        //   textAlign: TextAlign.left,
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.w600,
                                        //     fontSize: 22,
                                        //   ),
                                        // ),
                                        // Text(
                                        //   '/per one',
                                        //   style: TextStyle(
                                        //       fontSize: 14,
                                        //       color:
                                        //           Colors.grey.withOpacity(0.8)),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
