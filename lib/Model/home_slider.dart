import 'package:flutter/foundation.dart';

class HomeSlider with ChangeNotifier {
  HomeSlider({
    this.imagePath = '',
    this.titleTxt = '', 
  });
  String imagePath;
  String titleTxt;
}
