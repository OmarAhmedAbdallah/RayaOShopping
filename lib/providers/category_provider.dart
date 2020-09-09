import 'package:flutter/widgets.dart';
import 'package:oshopping/Model/category.dart';
import 'package:oshopping/Model/utilities.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriesProvider with ChangeNotifier {
  static List<Categories> _categoryItems = <Categories>[
    // Categories(
    //   imagePath: 'assets/images/p5.jpeg',
    //   titleTxt: 'PLASTIC BAGS',
    //   subTxt: 'Emirates , Dubai',
    //   dist: 2.0,
    //   reviews: 80,
    //   rating: 4.4,
    //   perNight: 180,
    // ),
    // Categories(
    //   imagePath: 'assets/images/p6.jpg',
    //   titleTxt: 'SAFETY ITEMS',
    //   subTxt: 'Emirates , Dubai',
    //   dist: 4.0,
    //   reviews: 74,
    //   rating: 4.5,
    //   perNight: 200,
    // ),
    // Categories(
    //   imagePath: 'assets/images/p7.jpg',
    //   titleTxt: 'FOAM PRODUCTS',
    //   subTxt: 'Emirates , Dubai',
    //   dist: 3.0,
    //   reviews: 62,
    //   rating: 4.0,
    //   perNight: 60,
    // ),
    // Categories(
    //   imagePath: 'assets/images/p8.jpg',
    //   titleTxt: 'ALUMINIUM PRODUCT',
    //   subTxt: 'Emirates , Dubai',
    //   dist: 7.0,
    //   reviews: 90,
    //   rating: 4.4,
    //   perNight: 170,
    // ),
    // Categories(
    //   imagePath: 'assets/images/p9.jpg',
    //   titleTxt: 'BLACK CONTAINERS',
    //   subTxt: 'Emirates , Dubai',
    //   dist: 2.0,
    //   reviews: 240,
    //   rating: 4.5,
    //   perNight: 200,
    // ),
  ];

  List<Categories> get categoriesItems {
    // return copy of the list
    return [..._categoryItems];
  }

  Categories findById(double id) {
    return _categoryItems.firstWhere((cate) => cate.idCategory == id);
  }

  void refreshProductList() {
    notifyListeners();
  }

  Future<List<Categories>> getGategories(String lang) async {
    lang = Utilities.lang;
    try {
      final url = Utilities.url + Utilities.categoryAPI;

      // final prefs = await SharedPreferences.getInstance();
      // final extractedUserData =
      //     json.decode(prefs.getString('userData')) as Map<String, Object>;

      // Map<String, String> headers = {
      //   'authorization': extractedUserData['token'],
      //   "lang": lang
      // };

      Map<String, String> headers = {"lang": lang};
      final response = await http.get(url, headers: headers);

      final responseData = json.decode(response.body);
      print(responseData);
      _categoryItems = [];
      for (var category in responseData) {
        // Categories cate = Categories(
        //   idCategory: category["code"],
        //   imagePath: category["banner"]["image"],
        //   titleTxt: category["name"],
        //   subTxt: 'subTxt',
        //   dist: 2.0,
        //   reviews: 240,
        //   rating: 4.5,
        //   price: 200,
        // );
        Categories cate = Categories.categoriesFromJson(category);
        _categoryItems.add(cate);
      }
      print(_categoryItems.length);
    } catch (error) {
      print(error);
    }
    notifyListeners();
    return _categoryItems;
  }

  void updateProduct(double id, Categories newCategory) {
    final categoryIndex =
        _categoryItems.indexWhere((cate) => cate.idCategory == id);
    if (categoryIndex >= 0) {
      _categoryItems[categoryIndex] = newCategory;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(double id) {
    _categoryItems.removeWhere((cate) => cate.idCategory == id);
    notifyListeners();
  }
}
