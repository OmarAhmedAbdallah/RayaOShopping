import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:oshopping/providers/user_provider.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';

class AboutUsScreen extends StatefulWidget {
  static const routeName = '/about-us';

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  Future _getAbout;
  int firstTime = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firstTime == 0) {
      final userData = UserProvider();

      _getAbout = userData.getAbout();
      firstTime = 1;
    }
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: AppBase(
            body: Column(
              children: <Widget>[
                PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: ApplicationTopBar(pageName: tr("AboutUs")),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FutureBuilder(
                          future: _getAbout,
                          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return Text(snapshot.data);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
