import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:oshopping/Model/product.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageKey;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imageKey,
  });
}

class Cart with ChangeNotifier {
  static Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  Future<void> getUserCart() async {
    String lang = Utilities.lang;
    try {
      final url = Utilities.url + Utilities.cartAPI;
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
      List<Product> prod = Product.productFromJson(responseData["items"]);
      _items = {};

      for (int i = 0; i < prod.length; i++) {
        _items.putIfAbsent(
          prod.elementAt(i).id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: prod.elementAt(i).title,
              price: prod.elementAt(i).price,
              quantity: prod.elementAt(i).quantity,
              imageKey: prod.elementAt(i).imageUrl),
        );
      }
      notifyListeners();
      // List<Product> prod = Product.productFromJson(responseData["items"]);
      // _productItems.addAll(prod);
      // print(_productItems.length);
    } catch (error) {
      print(error);
    }
  }

  Future<void> addItem(String productId, double price, String title, String imgUrl,
      {bool isAdding = true}) async {
    try {
      final url = Utilities.url + Utilities.cartAPI;
      final prefs = await SharedPreferences.getInstance();
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      String token = extractedUserData['token'];
      // print(_items[productId].quantity);
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": 'bearer $token',
        "isGuest": "1"
      };
      final quantatity = isAdding
          ? _items.containsKey(productId)
              ? (_items[productId].quantity + 1).toString()
              : 1
          : (_items[productId].quantity - 1).toString();

      if (!isAdding) {
        if (_items.containsKey(productId)) {
          if (_items[productId].quantity > 1) {
            _items.update(
              productId,
              (exsitingItem) => CartItem(
                  id: exsitingItem.id,
                  title: exsitingItem.title,
                  price: exsitingItem.price,
                  quantity: exsitingItem.quantity - 1,
                  imageKey: exsitingItem.imageKey),
            );
          } else {
            _items.remove(productId);
          }
        }
      } else {
        if (_items.containsKey(productId)) {
          // change quantity...
          _items.update(
            productId,
            (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
                imageKey: existingCartItem.imageKey),
          );
        } else {
          _items.putIfAbsent(
            productId,
            () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1,
              imageKey: imgUrl,
            ),
          );
        }
      }
      // print(_items[productId].quantity);
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(
          {"sku": productId, "quantity": quantatity},
        ),
      );
      // final responseData = json.decode(response.body);

    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  Future<void> removingSingleItem(
      String productId, double price, String title,String imgUrl) async {
    print(_items[productId].quantity);
    if (_items.containsKey(productId)) {
      await addItem(productId, price, title,imgUrl, isAdding: false);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
