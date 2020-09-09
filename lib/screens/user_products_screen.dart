import 'package:flutter/material.dart';
import 'package:oshopping/providers/products_provider.dart';
import 'package:oshopping/widgets/user_product_item.dart';
import 'package:provider/provider.dart';


import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.productsItems.length,
          itemBuilder: (_, i) => Column(
                children: [
                  UserProductItem(
                    productsData.productsItems[i].id,
                    productsData.productsItems[i].title,
                    productsData.productsItems[i].imageUrl,
                  ),
                  Divider(),
                ],
              ),
        ),
      ),
    );
  }
}
