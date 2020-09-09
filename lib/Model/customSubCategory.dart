import 'package:flutter/foundation.dart';

class SubCustomCategory with ChangeNotifier {
  SubCustomCategory({
    this.idCategory = '',
    this.imagePath = '',
    this.titleTxt = '',
    this.arTitleTxt = '',
  });
  String idCategory;
  String imagePath;
  String titleTxt; 
  String arTitleTxt;  
}
