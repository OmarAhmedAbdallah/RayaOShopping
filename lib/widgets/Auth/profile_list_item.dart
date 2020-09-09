import 'package:flutter/material.dart';
import 'package:oshopping/themes/app_theme.dart'; 
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
      height: AppTheme.kSpacingUnit.w * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: AppTheme.kSpacingUnit.w * 4,
      ).copyWith(
        bottom: AppTheme.kSpacingUnit.w * 2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.kSpacingUnit.w * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.kSpacingUnit.w * 3),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: AppTheme.kSpacingUnit.w * 2.5,
          ),
          SizedBox(width: AppTheme.kSpacingUnit.w * 1.5),
          Text(
            this.text,
            style: AppTheme.kTitleTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: AppTheme.kSpacingUnit.w * 2.5,
            ),
        ],
      ),
    );
  }
}
