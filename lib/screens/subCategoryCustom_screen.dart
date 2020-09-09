import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/customSubCategory.dart';
import 'package:oshopping/Model/subCategory.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';
import 'package:oshopping/widgets/SubCategoryCustomListView.dart';
import 'package:provider/provider.dart';

class SubCategoriesCustomTabs extends StatefulWidget {
  static const routeName = '/subCategoriesCustom';
  List<SubCustomCategory> subcategories = [
    new SubCustomCategory(
        idCategory: "1",
        titleTxt: "Brown Kraft Boxes",
        arTitleTxt: "Brown Kraft Boxes",
        imagePath: "MealBox.jpg"),
    new SubCustomCategory(
        idCategory: "2",
        titleTxt: "Double wall cups",
        arTitleTxt: "Double wall cups",
        imagePath: "1Productandputbothpictures.jpg"),
    new SubCustomCategory(
        idCategory: "3",
        titleTxt: "E-Flute Boxes",
        arTitleTxt: "E-Flute Boxes",
        imagePath: "MealBoxCat3.jpg"),
    new SubCustomCategory(
        idCategory: "4",
        titleTxt: "Flat Paper Bags",
        arTitleTxt: "Flat Paper Bags",
        imagePath: "FlatPaperBag.jpg"),
    new SubCustomCategory(
        idCategory: "5",
        titleTxt: "Foodboard Boxes",
        arTitleTxt: "Foodboard Boxes",
        imagePath: "WAWANBURGERBOX.jpg"),
    new SubCustomCategory(
        idCategory: "6",
        titleTxt: "Kraft Bags with Handle",
        arTitleTxt: "Kraft Bags with Handle",
        imagePath: "BrownPaperBagwithHandle.jpg"),
    new SubCustomCategory(
        idCategory: "7",
        titleTxt: "Plastic Bags",
        arTitleTxt: "Plastic Bags",
        imagePath: "2.jpg"),
    new SubCustomCategory(
        idCategory: "8",
        titleTxt: "Sandwich paper",
        arTitleTxt: "Sandwich paper",
        imagePath: "SandwichPaper.jpg"),
    new SubCustomCategory(
        idCategory: "9",
        titleTxt: "SOS Bags",
        arTitleTxt: "SOS Bags",
        imagePath: "3.jpg"),
    new SubCustomCategory(
        idCategory: "10",
        titleTxt: "Wet Napkin",
        arTitleTxt: "Wet Napkin",
        imagePath: "WetNapkin.jpg")
  ];
  SubCategoriesCustomTabs();
  @override
  _SubCategoriesCustomTabsPageState createState() =>
      _SubCategoriesCustomTabsPageState();
}

class _SubCategoriesCustomTabsPageState extends State<SubCategoriesCustomTabs>
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
                    SubCustomCategory category =
                        widget.subcategories.elementAt(index);

                    final int count = widget.subcategories.length > 10
                        ? 10
                        : widget.subcategories.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    animationController.forward();
                    return ChangeNotifierProvider.value(
                      value: category,
                      child: SubCategoryCustomListView(
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
