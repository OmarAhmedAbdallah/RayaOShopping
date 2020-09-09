import 'package:flutter/widgets.dart';
import 'package:oshopping/Model/home_slider.dart';
import 'package:oshopping/Model/utilities.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http;

class HomeSliderProvider with ChangeNotifier {
  static List<HomeSlider> _homeSliderItems = <HomeSlider>[];

  List<HomeSlider> get homeSliderItems {
    // return copy of the list
    return [..._homeSliderItems];
  }

  void refreshProductList() {
    notifyListeners();
  }

  Future<List<HomeSlider>> getHomeSlider() async { 
    int index = 0;
    try {
      final url = Utilities.url + Utilities.homeSliderAPI;

      // final prefs = await SharedPreferences.getInstance();

      // final extractedUserData =
      //     json.decode(prefs.getString('userData')) as Map<String, Object>;

      // Map<String, String> headers = {
      //   'authorization': extractedUserData['token'],
      // };

      // final response = await http.get(url, headers: headers);
      final response = await http.get(url);

      final responseData = json.decode(response.body);
      print("getHomeSlider");
      print(responseData);
 
      _homeSliderItems = [];
      for (var category in responseData) {
        HomeSlider homeSlider = HomeSlider(
          imagePath: category["image"],
          titleTxt: category["title"]["text"]
        );
        _homeSliderItems.add(homeSlider);
      }
      print(_homeSliderItems.length);
    } catch (error) {
      print(error);
    }
    notifyListeners();
    return _homeSliderItems;
  }
}
