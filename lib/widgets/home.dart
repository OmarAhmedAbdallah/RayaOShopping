import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/category.dart';
import 'package:oshopping/helpers/static_variable.dart';
import 'package:oshopping/providers/auth.dart';
import 'package:oshopping/providers/cart.dart';
import 'package:oshopping/providers/category_provider.dart';
import 'package:oshopping/providers/orders.dart';
import 'package:oshopping/providers/products_provider.dart';
import 'package:oshopping/providers/user_provider.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/widgets/Auth/welcomePage.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget homeScreen(bool auth) {
    if (auth)
      return MainScreen();
    else
      return WelcomePage();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (ctx) => UserProvider(),
        ),
        ChangeNotifierProvider(
          builder: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          builder: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          builder: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          builder: (ctx) => Orders(),
        ),
        ChangeNotifierProvider(
          builder: (ctx) => CategoriesProvider(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: "Raya",
          theme: ThemeData(
              primaryColor: Theme.of(context).backgroundColor,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          home: Auth.isAuth
              ? MainScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Container(
                            child: Center(
                              child: SizedBox(
                                  child: CircularProgressIndicator(),
                                  height: 50.0,
                                  width: 50.0,
                                ),
                            ),
                          )
                          : MainScreen(),
                ),
          onGenerateRoute: Variables.router.generator,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ),
      ),
    );
  }
}
