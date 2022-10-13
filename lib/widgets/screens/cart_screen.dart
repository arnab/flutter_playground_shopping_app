import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/providers/orders_provider.dart';
import 'package:flutter_playground_shopping_app/widgets/screens/orders_screen.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

import '../../models/providers/cart_provider.dart';
import '../../widgets/cart_list_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  Chip(
                    label: Text(
                      Money.fromNum(
                        cartProvider.totalAmount,
                        code: 'CAD',
                      ).format('S0.00'),
                      style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrdersProvider>(context, listen: false).addOrder(
                        cartProvider.itemsByProductId.values.toList(),
                        cartProvider.totalAmount,
                      );
                      cartProvider.clear();
                      Navigator.of(context).pushNamed(OrdersScreen.routeName);
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary),
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (_, i) => CartListItem(
                      productId: cartProvider.itemsByProductId.keys.toList()[i],
                      item: cartProvider.itemsByProductId.values.toList()[i],
                    ),
                itemCount: cartProvider.uniqueProductCount),
          ),
        ],
      ),
    );
  }
}
