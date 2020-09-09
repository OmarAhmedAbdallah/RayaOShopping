import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/user.dart';
import 'package:oshopping/providers/user_provider.dart';
import 'package:oshopping/screens/change_password.dart';
import 'package:oshopping/screens/edit_product_screen.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  // TabController tabController;
  Future _getUser;
  int firstTime = 0;

  @override
  void initState() {
    super.initState();
    // tabController = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    if (firstTime == 0) {
      final userData = UserProvider();

      _getUser = userData.getUser();
      firstTime = 1;
    }
    Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: AppTheme.kSpacingUnit.w * 10,
            width: AppTheme.kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: AppTheme.kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: AppTheme.kSpacingUnit.w * 5,
                  backgroundImage: AssetImage('assets/images/userImage.png'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: AppTheme.kSpacingUnit.w * 2.5,
                    width: AppTheme.kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppTheme.kSpacingUnit.w * 2),
          Text(
            'Nicolas Adams',
            style: AppTheme.kTitleTextStyle,
          ),
          SizedBox(height: AppTheme.kSpacingUnit.w * 0.5),
          Text(
            'nicolasadams@gmail.com',
            style: AppTheme.kCaptionTextStyle,
          ),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/'),
            );
            Navigator.of(context).pushNamed(MainScreen.routeName);
          },
          child: Icon(
            LineAwesomeIcons.arrow_left,
            size: ScreenUtil().setSp(AppTheme.kSpacingUnit.w * 3),
          ),
        ),
        SizedBox(width: AppTheme.kSpacingUnit.w * 3),
      ],
    );

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: AppTheme.kSpacingUnit.w * 5),
            header,
            Expanded(
              child: FutureBuilder(
                future: _getUser,
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    User user = snapshot.data;
                    return ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  tr('PersonalInformation'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0),
                                ),
                              ),
                              GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(ctx).pushNamed(
                                            EditProductScreen.routeName);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Text(tr('EditProfile')),
                                      ),
                                    ),
                                    Icon(
                                      Icons.edit,
                                      size: 10.0,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Card(
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4.0),
                                                  child: Text(tr("email")),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text(user.email),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4.0),
                                                  child: Text(tr("firstName")),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text(user.firstName),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4.0),
                                                  child: Text(tr("lastName")),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text(user.lastName),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4.0),
                                                  child:
                                                      Text(tr("profile_phone")),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text(user.phone),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(ChangePasswordPage.routeName);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(tr('change_password')),
                                          ),
                                          GestureDetector(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.navigate_next,
                                                  size: 16.0,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
