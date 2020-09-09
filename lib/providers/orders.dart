import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:oshopping/Model/product.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final int amount;
  final List<Product> products;
  final String dateTime;
  final String status;
  final String paymentMethod;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
    @required this.status,
    @required this.paymentMethod,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  // void addOrder(List<CartItem> cartProducts, double total) {
  //   _orders.insert(
  //     0,
  //     OrderItem(
  //       id: DateTime.now().toString(),
  //       amount: total,
  //       dateTime: DateTime.now(),
  //       products: cartProducts,
  //     ),
  //   );
  //   notifyListeners();
  // }

  Future<void> checkOut(int government, int city, String mobile, String address,
      String paymentMethod) async {
    if (paymentMethod == "تحويل بنكى") {
      paymentMethod = "Bank Transfer";
    } else if (paymentMethod == "دفع عند الاستلام") {
      paymentMethod = "Cash on delivery";
    }
    final url = Utilities.url + Utilities.checkoutAPI;
    final prefs = await SharedPreferences.getInstance();

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    String token = extractedUserData['token'];
    Map<String, String> headers = {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'bearer $token',
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(
          {
            'government': government,
            'city': city,
            'mobile': mobile,
            'address': address,
            'paymentMethod': paymentMethod,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      print(json.decode(response.body));

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<List<OrderItem>> getOrders() async {
    String lang = Utilities.lang;
    try {
      final url = Utilities.url + Utilities.getOrdersAPI;
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
      var data = responseData["orders"];
      _orders = [];
      for (var order in data) {
        List<Product> prod = Product.productFromJson(order["items"]);

        _orders.insert(
          0,
          OrderItem(
            id: order["id"].toString(),
            amount: order["total"],
            dateTime: order['createdAt'].substring(0, 10),
            products: prod,
            status: order["status"],
            paymentMethod: order["paymentMethod"],
          ),
        );
      }
      notifyListeners();
      // List<Product> prod = Product.productFromJson(responseData["items"]);
      // _productItems.addAll(prod);
      // print(_productItems.length);
    } catch (error) {
      print(error);
    }
    return _orders;
  }

  uploadImage(File imageFile) async {
    var stream = new http.ByteStream(DelegatingStream(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("uploadURL");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<void> checkOutCustom(
      String catID,
      String name,
      String mobile,
      String email,
      String company,
      int government,
      int city,
      String address,
      double len,
      double width,
      double height,
      String artwork,
      double quantity,
      int sizeInOz,
      String materialType,
      double guesst,
      int itemType,
      int pizzaSize,
      int sizeGSM,
      String color) async {
    if (artwork == "لدى عمل فنى" || artwork == "I have artwork") {
      artwork = "yes";
    } else if (artwork == "ليس لدى عمل فنى" ||
        artwork == "I don’t have artwork") {
      artwork = "no";
    }
    final url = Utilities.url + Utilities.checkoutCustomAPI;
    var body;
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    body = {
      'category': catID,
      'full_name': name,
      'mobile': mobile,
      'brand': company,
      'email': email,
      'country': government,
      'city': city,
      'address': address,
      'length': len,
      'width': width,
      'height': height,
      'art': artwork,
      'quantity': quantity,
      'size': sizeInOz,
      'material_type': materialType,
      'gusset': guesst,
      'item_type': itemType,
      'pizza_size': pizzaSize,
      'kraft': sizeGSM,
      'color': color
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(
          body,
        ),
      );
      final responseData = json.decode(response.body);
      // if (responseData['error'] != null) {
      //   throw HttpException(responseData['error']['message']);
      // }
      // print(json.decode(response.body));

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
