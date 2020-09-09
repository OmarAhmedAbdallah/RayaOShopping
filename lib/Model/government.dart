
import 'package:flutter/cupertino.dart';

class Government extends ChangeNotifier {
  Government({
    this.name = '',
    this.code = 0,
  });
  String name;
  int code;
  static List<Government> governmentsFromJson(List<dynamic> json) {
    List<Government> _governmentItems = <Government>[];
    for (var gov in json) {
      Government gover = Government(
        name: gov["name"],
        code: gov["code"],
      );
      _governmentItems.add(gover);
    }

    return _governmentItems;
  }
}
