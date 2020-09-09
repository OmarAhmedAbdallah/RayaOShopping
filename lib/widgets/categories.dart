import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/category.dart';
import 'package:oshopping/providers/category_provider.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:oshopping/themes/light_color.dart';
import 'package:provider/provider.dart';
import 'package:toggle_bar/toggle_bar.dart';

import 'category_list_view.dart';

class CategoriesTabs extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _CategoriesTabsState createState() => _CategoriesTabsState();
}

class _CategoriesTabsState extends State<CategoriesTabs> {
  @override
  Widget build(BuildContext context) {
    return CategoriesTabsPage();
  }
}

class CategoriesTabsPage extends StatefulWidget {
  @override
  _CategoriesTabsPageState createState() => _CategoriesTabsPageState();
}

class _CategoriesTabsPageState extends State<CategoriesTabsPage>
    with TickerProviderStateMixin {
  List<String> labels = [tr("choose_one_category")];
  AnimationController animationController;
  int currentIndex = 0;
  Future _getCategories;
  int firstTime = 0;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // List<Categories> categoryList = categoriesData.categoriesItems;
    if (firstTime == 0) {
      final categoriesData = CategoriesProvider();

      _getCategories =
          categoriesData.getGategories(context.locale.languageCode);
      firstTime = 1;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ToggleBar(
            labels: labels,
            backgroundColor: LightColor.lightWhite,
            onSelectionUpdated: (index) => setState(() => currentIndex = index),
            textColor: LightColor.black,
            selectedTabColor: LightColor.secondaryColor,
            labelTextStyle: TextStyle(height: 1),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 350 - 50,
              color: AppTheme.buildLightTheme().backgroundColor,
              child: FutureBuilder(
                future: _getCategories,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return GridView.count(
                      // crossAxisCount is the number of columns
                      crossAxisCount: 2,
                      // This creates two columns with two items in each column
                      children: List.generate(
                        snapshot.data.length,
                        (index) {
                          Categories category = snapshot.data[index];

                          final int count = snapshot.data.length > 10
                              ? 10
                              : snapshot.data.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController.forward();
                          return ChangeNotifierProvider.value(
                            value: category,
                            child: CategoryListView(
                              callback: () {},
                              categoryData: category,
                              animation: animation,
                              isSubCateory: false,
                              animationController: animationController,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
