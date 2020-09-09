import 'package:flutter/material.dart';
import 'package:oshopping/Model/customSubCategory.dart';
import 'package:oshopping/screens/CustomForm.dart';
import 'package:oshopping/themes/app_theme.dart';

class SubCategoryCustomListView extends StatelessWidget {
  const SubCategoryCustomListView(
      {Key key,
      this.categoryData,
      this.animationController,
      this.isSubCateory,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final SubCustomCategory categoryData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final bool isSubCateory;

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Categories>(context, listen: false);
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  callback();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (isSubCateory)
                                  Navigator.pushNamed(
                                    context,
                                    CustomForm.routeName,
                                    arguments: categoryData.idCategory,
                                  );
                                else
                                  Navigator.pushNamed(
                                    context,
                                    CustomForm.routeName,
                                    arguments: categoryData.idCategory,
                                  );
                              },
                              child: Image.asset(
                                  "assets/images/" + categoryData.imagePath),
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
                                            left: 16,
                                            right: 16,
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
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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