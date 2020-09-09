import 'package:flutter/material.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:oshopping/themes/light_color.dart';
import 'package:oshopping/widgets/title_text.dart';

class ProductIcon extends StatelessWidget {

  bool isSelected;
  String name;
  ProductIcon({Key key, name, this.isSelected}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
        padding: AppTheme.hPadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: isSelected ? LightColor.background : Colors.transparent,
          border: Border.all(
            color: isSelected ? LightColor.orange : LightColor.grey,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: isSelected ? Color(0xfffbf2ef) : Colors.white,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: TitleText(
          text: name,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }
}
