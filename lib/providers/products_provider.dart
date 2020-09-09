import 'package:flutter/widgets.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Model/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  static List<Product> _productItems = [];
  List<Product> get productsItems {
    // return copy of the list
    return [..._productItems];
  }

  Future<List<Product>> allProductsItems(String catId) async {
    String lang = Utilities.lang;
    try {
      final url = Utilities.url + Utilities.singleCategoryAPI + catId;
      final prefs = await SharedPreferences.getInstance();
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      String token = extractedUserData['token'];

      Map<String, String> headers = {
        "lang": lang,
        "Authorization": 'bearer $token',
      };
      final response = await http.get(url, headers: headers);

      final responseData = json.decode(response.body);
      print(responseData);
      _productItems = [];

      List<Product> prod = Product.productFromJson(responseData["products"]);
      _productItems.addAll(prod);
      print(_productItems.length);
    } catch (error) {
      print(error);
    }
    notifyListeners();
    print(_productItems);

    return _productItems;
  }

  Future<List<Product>> searchProductsItems(String searchWord) async {
    final url = Utilities.url + Utilities.searchAPI;
    String lang = Utilities.lang;
    List<Product> searchedProductItems = [];
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    String token = extractedUserData['token'];
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": 'bearer $token',
        "lang": lang
      };

      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(
          {"searchText": searchWord},
        ),
      );

      final responseData = json.decode(response.body);
      print(responseData);

      List<Product> prod = Product.productFromJson(responseData["products"]);
      searchedProductItems.addAll(prod);
      print(searchedProductItems.length);
    } catch (error) {
      print(error);
    }

    notifyListeners();
    return searchedProductItems;
  }

  Future<List<Product>> favoritsProductsItems() async {
    String lang = Utilities.lang;
    try {
      final url = Utilities.url + Utilities.addFavouritAPI;
      final prefs = await SharedPreferences.getInstance();
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      String token = extractedUserData['token'];

      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": 'bearer $token',
        "lang": lang
      };
      final response = await http.get(url, headers: headers);

      final responseData = json.decode(response.body);
      print(responseData);
      _productItems = [];

      List<Product> prod = Product.productFromJson(responseData["items"]);
      _productItems.addAll(prod);
      print(_productItems.length);
    } catch (error) {
      print(error);
    }
    notifyListeners();
    print(_productItems);

    return _productItems;
  }

  List<Product> favProductsItems() {
    // return copy of the list
    return _productItems.where((prod) => prod.isFavourit).toList();
  }

  Product findById(String id) {
    print(_productItems);
    return _productItems.firstWhere((prod) => prod.id == id);
  }

  void refreshProductList() {
    notifyListeners();
  }

  void addProduct(Product product) {
    const url = 'https://oshopping-791c9.firebaseio.com/products.json';
    http.post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavourit,
        },
      ),
    );
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _productItems.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _productItems.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _productItems[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _productItems.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
