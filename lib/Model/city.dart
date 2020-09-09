
import 'package:flutter/cupertino.dart';

class City extends ChangeNotifier {
  City({
    this.name = '',
    this.code = 0,
  });
  String name;
  int code;
  static List<City> citiesFromJson(List<dynamic> json) {
    List<City> _cityItems = <City>[];
    for (var cit in json) {
      City city = City(
        name: cit["name"],
        code: cit["code"],
      );
      _cityItems.add(city);
    }

    return _cityItems;
  }
}
