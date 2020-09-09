import 'package:flutter/foundation.dart';
import 'package:oshopping/Model/subCategory.dart';

class Categories with ChangeNotifier {
  Categories({
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
  List<SubCategory> subCategory;
  static Categories categoriesFromJson(Map<String, dynamic> json) {
    Categories cate = Categories(
      idCategory: json["code"],
      imagePath: json["banner"]["image"],
      titleTxt: json["name"],
      subTxt: 'subTxt',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      price: 200,
    );

    // var x =json["subCategories"]["value"];
    cate.subCategory = SubCategory.subCategoryFromJson(json["subCategories"]);
    return cate;
  }
}
