import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';
  Future _getOrders;
  int firstTime = 0;
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    if (firstTime == 0) {
      final ordersData = Orders();
      _getOrders = ordersData.getOrders();
      firstTime = 1;
    }
    return Scaffold(
      body: AppBase(
        body: Column(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: ApplicationTopBar(pageName: tr("MyOrders")),
            ),
            Flexible(
              child: FutureBuilder(
                  future: _getOrders,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, i) => OrderItem(snapshot.data[i]),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

