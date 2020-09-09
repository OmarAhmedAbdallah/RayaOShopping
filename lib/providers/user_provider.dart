import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:oshopping/Model/city.dart';
import 'package:oshopping/Model/user.dart';
import 'package:oshopping/Model/utilities.dart';
import 'package:oshopping/Model/government.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  static User _user;
  User appUser() {
    // return copy of the list
    return _user;
  }

  Future<User> getUser() async {
    String lang = Utilities.lang;
    try {
      final url = Utilities.url + Utilities.profileAPI;

      final prefs = await SharedPreferences.getInstance();
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      String token = extractedUserData['token'];
      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        "lang": lang
      };

      final response = await http.get(url, headers: headers);

      final responseData = json.decode(response.body);
      _user = User.userFromJson(responseData);
      print(responseData);
    } catch (error) {
      print(error);
    }
    notifyListeners();
    return _user;
  }

  Future<void> updateUser(User user) async {
    final url = Utilities.url + Utilities.profileAPI;
    String lang = Utilities.lang;

    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    String token = extractedUserData['token'];
    Map<String, String> headers = {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'bearer $token',
      "lang": lang
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(
          {
            'firstName': user.firstName,
            'lastName': user.lastName,
            'email': user.email,
            'mobile': user.phone,
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

  Future<String> getAbout() async {
    String lang = Utilities.lang;
    String html = "";
    try {
      final url = Utilities.url + Utilities.aboutAPI;
      Map<String, String> headers = {"lang": lang};

      final response = await http.get(url, headers: headers);

      final responseData = json.decode(response.body);
      html = responseData["about"];
      print(responseData);
    } catch (error) {
      print(error);
    }
    notifyListeners();
    return html;
  }

  Future<String> getTerms() async {
    String lang = Utilities.lang;
    String html = "";
    try {
      final url = Utilities.url + Utilities.termsAPI;
      Map<String, String> headers = {"lang": lang};

      final response = await http.get(url, headers: headers);

      final responseData = json.decode(response.body);
      html = responseData["terms"];
      print(responseData);
    } catch (error) {
      print(error);
    }
    notifyListeners();
    return html;
  }

  Future<List<Government>> getGovernments() async {
    String lang = Utilities.lang;
    List<Government> govs = [];
    try {
      final url = Utilities.url + Utilities.governmentsAPI;
      Map<String, String> headers = {"lang": lang};

      final response = await http.get(url, headers: headers);
      final responseData = json.decode(response.body);
      govs = Government.governmentsFromJson(responseData);
      print(responseData);
    } catch (error) {
      print(error);
    }
    notifyListeners();
    return govs;
  }

  Future<List<City>> getCities(int cityId) async {
    String lang = Utilities.lang;
    List<City> cities = [];
    try {
      final url = Utilities.url + Utilities.citiesAPI + "/" + cityId.toString();
      Map<String, String> headers = {"lang": lang};

      final response = await http.get(url, headers: headers);
      final responseData = json.decode(response.body);
      cities = City.citiesFromJson(responseData);
      print(responseData);
    } catch (error) {
      print(error);
    }
    notifyListeners();
    return cities;
  }

  Future<List<Government>> getStaticCounties() async {
    List<Government> countries = [
      Government(name: "UAE", code: 1),
      Government(name: "Oman", code: 2),
      Government(name: "KSA", code: 3),
      Government(name: "Kuwait", code: 4),
      Government(name: "Bahrain", code: 5),
    ];
    notifyListeners();
    return countries;
  }
}
