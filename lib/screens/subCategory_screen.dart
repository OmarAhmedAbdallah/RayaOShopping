import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/subCategory.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';
import 'package:oshopping/widgets/subCategorylistView.dart';
import 'package:provider/provider.dart';

class SubCategoriesTabs extends StatefulWidget {
  static const routeName = '/subCategories';
  List<SubCategory> subcategories;
  SubCategoriesTabs(this.subcategories);
  @override
  _SubCategoriesTabsPageState createState() => _SubCategoriesTabsPageState();
}

class _SubCategoriesTabsPageState extends State<SubCategoriesTabs>
    with TickerProviderStateMixin {
  List<String> labels = [tr("choose_one_category")];
  AnimationController animationController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // final category = Provider.of<Categories>(context, listen: false);
    return Scaffold(
      body: AppBase(
        body: Column(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: ApplicationTopBar(pageName: "RAYA"),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.subcategories.length,
                  padding: const EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    SubCategory category = widget.subcategories.elementAt(index);

                    final int count =
                         widget.subcategories.length > 10 ? 10 :  widget.subcategories.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    animationController.forward();
                    return ChangeNotifierProvider.value(
                      value: category,
                      child: SubCategoryListView(
                        callback: () {},
                        categoryData: category,
                        animation: animation,
                        isSubCateory: true,
                        animationController: animationController,
                      ),
                    ); 
                  }),
            )
          ],
        ),
      ),
    );
  }
}
