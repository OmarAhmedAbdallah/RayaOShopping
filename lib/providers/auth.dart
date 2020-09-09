import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:oshopping/providers/cart.dart';

import '../Model/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  static String _token;
  static DateTime _expiryDate;
  static String _userId;
  static bool _isAuth = false;

  static bool get isAuth {
    bool flag = token != null;
    return flag;
  }

  static bool get isLoged {
    return _isAuth;
  }

  String get userId {
    return _userId;
  }

  static String get token {
    // if (_expiryDate != null &&
    //     _expiryDate.isAfter(DateTime.now()) &&
    //     _token != null) {
    //   return _token;
    // }
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticateRegister(String email, String name, String lastName,
      String phone, String password, String urlSegment) async {
    final url = urlSegment;
    String lang = Utilities.lang;
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      "lang": lang
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(
          {
            'firstName': name,
            'lastName': lastName,
            'email': email,
            'password': password,
            'mobile': phone,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }

      if (responseData['token'] != null) {
        await login(email, password);
      }
      print(json.decode(response.body));

      notifyListeners();
    } catch (error) {
      throw error;
    }
    // print(json.decode(response.body));
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = urlSegment;
    String lang = Utilities.lang;

    try {
      final oldPrefs = await SharedPreferences.getInstance();
      final extractedUserData =
          json.decode(oldPrefs.getString('userData')) as Map<String, Object>;
      String token = extractedUserData['token'];

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Content-type": "application/json",
        "Authorization": 'bearer $token',
        "lang": lang
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(
          {'email': email, 'password': password},
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      print(json.decode(response.body));
      _token = responseData['token'];
      _expiryDate = DateFormat("dd-MM-yyyy").parse(responseData['expiry']);

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'expiryDate': _expiryDate.toIso8601String(),
          'isAuth': true,
          'password': password
        },
      );
      prefs.setString('userData', userData);
      Cart cart = Cart();
      await cart.getUserCart();
      _isAuth = true;
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String name, String lastName, String phone,
      String password) async {
    final url = Utilities.url + Utilities.registerAPI;

    return _authenticateRegister(email, name, lastName, phone, password, url);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      await _generateToken();
    } else {
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

      if (expiryDate.isBefore(DateTime.now())) {
        await _generateToken();
      } else {
        _token = extractedUserData['token'];
        _isAuth = extractedUserData['isAuth'] != null;
        // _userId = extractedUserData['userId'];
        _expiryDate = expiryDate;
        Cart cart = Cart();
        await cart.getUserCart();
      }
    }
    notifyListeners();
    return true;
  }

  Future<void> _generateToken() async {
    final url = Utilities.url + Utilities.generateTokenAPI;
    Map<String, String> headers = {"Content-type": "application/json"};
    try {
      final response = await http.post(url, headers: headers);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      if (responseData['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        _token = responseData['token'];
        _expiryDate = DateFormat("dd-MM-yyyy").parse(responseData['expiry']);
        final userData = json.encode(
          {
            'token': _token,
            'expiryDate': _expiryDate.toIso8601String(),
          },
        );
        prefs.setString('userData', userData);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
    // print(json.decode(response.body));
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _isAuth = false;
    await _generateToken();
  }

  Future<void> login(String email, String password) async {
    final url = Utilities.url + Utilities.loginAPI;
    return _authenticate(email, password, url);
  }

  Future<void> forgetPassword(String email,
      {String password, String code, bool isReset}) async {
    String lang = Utilities.lang;
    String url = "";
    String _body = "";
    if (!isReset) {
      url = Utilities.url + Utilities.forgetPassAPI;
      _body = json.encode(
        {
          'email': email,
        },
      );
    } else {
      url = Utilities.url + Utilities.resetPasswordAPI;
      _body = json.encode(
        {
          'email': email,
          'password': password,
          'code': code,
        },
      );
    }
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      "lang": lang
    };
    try {
      final response = await http.post(url, headers: headers, body: _body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      } 

      notifyListeners();
    } catch (error) {
      throw error;
    }
    // print(json.decode(response.body));
  }

  Future<void> changePassword(String newPassword) async {
    final url = Utilities.url + Utilities.changePasswordAPI;
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    String token = extractedUserData['token'];
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      "Authorization": 'bearer $token',
    };
    try {
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode(
          {
            'password': newPassword,
          },
        ),
      );
      // final responseData = json.decode(response.body);
      // if (responseData['error'] != null) {
      //   throw HttpException(responseData['error']['message']);
      // }
      extractedUserData['password'] = newPassword;
      final userData = json.encode(
        {
          'token': extractedUserData['token'],
          'expiryDate': extractedUserData['expiryDate'],
          'isAuth': extractedUserData['isAuth'],
          'password': newPassword
        },
      );
      prefs.setString('userData', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
