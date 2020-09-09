import 'package:flutter/foundation.dart';

class SubCategory with ChangeNotifier {
  SubCategory({
    this.idCategory = '',
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.price = 180,
  });
  String idCategory;
  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  double price;
  static SubCategory singleSubCategoryFromJson(Map<String, dynamic> json) {
 
    return SubCategory(
      idCategory: json["code"],
      imagePath: json["image"],
      titleTxt: json["name"],
      subTxt: 'subTxt',
    );
  }

  static List<SubCategory> subCategoryFromJson(List<dynamic> json) {
     List<SubCategory> _subCategoryItems=[];
    for (var subCategory in json) { 
      SubCategory cate = SubCategory.singleSubCategoryFromJson(subCategory);
      _subCategoryItems.add(cate); 
    }
    return _subCategoryItems;
  }
}
