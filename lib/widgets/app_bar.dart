import 'package:flutter/material.dart';
import 'package:oshopping/providers/auth.dart';
import 'package:oshopping/providers/cart.dart';
import 'package:oshopping/screens/cart_screen.dart';
import 'package:oshopping/themes/light_color.dart';
import 'package:oshopping/widgets/badge.dart';
import 'package:provider/provider.dart';

class ApplicationTopBar extends StatefulWidget {
  const ApplicationTopBar({Key key, @required this.pageName}) : super(key: key);

  final String pageName;

  @override
  _ApplicationTopBarState createState() => _ApplicationTopBarState();
}

class _ApplicationTopBarState extends State<ApplicationTopBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 

    return AppBar(
      bottomOpacity: 2,
      elevation: 2.0,
      automaticallyImplyLeading: false,
      backgroundColor: LightColor.lightWhite,
      title: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Image.asset(
          "assets/images/logo.jpg",
          fit: BoxFit.fitHeight,
          width: 80,
          height: 20,
        ),
      ),
      actions: <Widget>[
        // Icon(Icons.search),
        SizedBox(
          width: 10,
        ),
        Auth.isLoged
            ? InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/profile");
                },
                child: Icon(Icons.person_outline),
              )
            : Container(),
        SizedBox(
          width: 10,
        ),
        // it changes from product item
        Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
            child: ch,
            value: cart.itemCount.toString(),
          ),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ),
      ],
    );
  }
}
