import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/providers/auth.dart';
import 'package:oshopping/providers/orders.dart';
import 'package:oshopping/themes/light_color.dart';
import 'package:oshopping/widgets/Auth/loginPage.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import 'CheckOutPage.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  Widget _emptyCart() {
    return SafeArea(
      child: AppBase(
        body: Column(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: ApplicationTopBar(pageName: tr("MyCart")),
            ),
            Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: LightColor.darkgrey,
                    blurRadius: 20.0,
                  ),
                ],
              ),
              height: 5,
            ),
            SizedBox(
              height: 70,
              child: Container(
                color: Color(0xFFFFFFFF),
              ),
            ),
            Container(
              width: double.infinity,
              height: 250,
              child: Image.asset(
                "assets/images/empty_shopping_cart.png",
                height: 250,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 40,
              child: Container(
                color: Color(0xFFFFFFFF),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                tr("EmptyCart"),
                style: TextStyle(
                  color: Color(0xFF67778E),
                  fontFamily: 'Roboto-Light.ttf',
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    Widget widget;
    if (cart.items.length != 0) {
      widget = Scaffold(
        body: AppBase(
          body: Column(
            children: <Widget>[
              PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: ApplicationTopBar(pageName: tr("MyCart")),
              ),
              Card(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        tr('Total'),
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          '\AED ${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color,
                          ),
                        ),
                        backgroundColor: LightColor.secondaryColor,
                      ),
                      Auth.isLoged
                          ? FlatButton(
                              child: Text(tr("ORDERNOW")),
                              onPressed: () {
                                // Provider.of<Orders>(context, listen: false).addOrder(
                                //   cart.items.values.toList(),
                                //   cart.totalAmount,
                                // );
                                // cart.clear();
                                Navigator.pushNamed(
                                  context,
                                  CheckOutPage.routeName,
                                  arguments: "-1",
                                );
                              },
                              textColor: LightColor.secondaryColor,
                            )
                          : FlatButton(
                              child: Text(tr("ORDERNOW")),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(LoginPage.routeName);
                              },
                              textColor: LightColor.secondaryColor,
                            )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) => CartItem(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].title,
                    cart.items.values.toList()[i].imageKey,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      widget = _emptyCart();
    }
    return widget;
  }
}
