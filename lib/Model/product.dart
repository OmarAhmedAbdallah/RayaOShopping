import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//this is becuase we need to add listner in a single product
class Product extends ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  int quantity;
  bool isFavourit;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.quantity = 0,
    this.isFavourit = false,
  });

  Future<String> toggleFavouritStatus(prodId, newIsFavourit) async {
    String lang = Utilities.lang;
    if (newIsFavourit != isFavourit) {
      try {
        final url = isFavourit
            ? Utilities.url + Utilities.addFavouritAPI + "/" + prodId
            : Utilities.url + Utilities.addFavouritAPI;
        final prefs = await SharedPreferences.getInstance();
        final extractedUserData =
            json.decode(prefs.getString('userData')) as Map<String, Object>;
        String token = extractedUserData['token'];

        Map<String, String> headers = {
          "Content-type": "application/json",
          "Authorization": 'bearer $token',
          "lang": lang
        };
        final response = isFavourit
            ? await http.delete(
                url,
                headers: headers,
              )
            : await http.post(
                url,
                headers: headers,
                body: json.encode(
                  {'sku': prodId},
                ),
              );
        isFavourit = newIsFavourit;

        final responseData = json.decode(response.body);
        print(responseData);
      } catch (error) {
        print(error);
      }
      notifyListeners();
    }

    return isFavourit.toString();
  }

  static Product singleProductFromJson(Map<String, dynamic> json) {
    return Product(
        id: json["sku"],
        title: json["name"] == null ? json["title"] : json["name"],
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        imageUrl: json["imageKey"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
        isFavourit: json["isFavourite"] == 0 ? false : true);
  }

  static List<Product> productFromJson(List<dynamic> json) {
    List<Product> _subCategoryItems = [];
    for (var subCategory in json) {
      Product cate = Product.singleProductFromJson(subCategory);
      _subCategoryItems.add(cate);
    }
    return _subCategoryItems;
  }
}
