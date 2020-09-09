 
import 'package:flutter/material.dart'; 
import 'package:oshopping/themes/CustomTextStyle.dart'; 
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageUrl,
  );
  createCartListItem(Cart cart) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: NetworkImage(imageUrl))),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          title,
                          maxLines: 2,
                          softWrap: true,
                          style: CustomTextStyle.textFormFieldSemiBold
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "\AED" + price.toString(),
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Colors.green),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () async {
                                      await cart.removingSingleItem(
                                          productId, price, title,imageUrl);
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      size: 24,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        bottom: 2, right: 12, left: 12),
                                    child: Text(
                                      quantity.toString(),
                                      style:
                                          CustomTextStyle.textFormFieldSemiBold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await cart.addItem(
                                          productId, price, title,imageUrl);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 24,
                                      color: Colors.grey.shade700,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ), 
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return createCartListItem(cart);
  }
}
// Dismissible(
//       key: ValueKey(id),
//       background: Container(
//         color: Theme.of(context).errorColor,
//         child: Icon(
//           Icons.delete,
//           color: Colors.white,
//           size: 40,
//         ),
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.only(right: 20),
//         margin: EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 4,
//         ),
//       ),
//       direction: DismissDirection.endToStart,
//       confirmDismiss: (direction) {
//         return showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: Text('Are you sure?'),
//             content: Text(
//               'Do you want to remove the item from the cart?',
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('No'),
//                 onPressed: () {
//                   Navigator.of(ctx).pop(false);
//                 },
//               ),
//               FlatButton(
//                 child: Text('Yes'),
//                 onPressed: () {
//                   Navigator.of(ctx).pop(true);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//       onDismissed: (direction) {
//         Provider.of<Cart>(context, listen: false).removeItem(productId);
//       },
//       child: Card(
//         elevation: 10,
//         margin: EdgeInsets.symmetric(
//           horizontal: 10,
//           vertical: 4,
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(8),
//           child: ListTile(
//             title: Text(title),
//             subtitle: Text(
//               tr('Total') + ': \AED ${(price * quantity)}',
//               style: TextStyle(color: LightColor.red),
//             ),
//             trailing: Row(mainAxisSize: MainAxisSize.min, children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: 25,
//                   height: 25,
//                   child: FloatingActionButton(
//                     heroTag:"btnAdd",
//                     child: Icon(Icons.add),
//                     onPressed: () async {
//                                         await cart.addItem(productId, price, title);
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: 25,
//                   height: 25,
//                   child: FloatingActionButton(
//                     heroTag:"btnRemove",
//                     child: Icon(Icons.remove),
//                     onPressed: () async {
//                       await cart.removingSingleItem(productId, price, title);

//                     },
//                   ),
//                 ),
//               ),
//               Text('$quantity x')
//             ]),
//           ),
//         ),
//       ),
//     );
