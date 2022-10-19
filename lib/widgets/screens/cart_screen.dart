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
                  OrderButton(cartProvider: cartProvider),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cartProvider,
  }) : super(key: key);

  final CartProvider cartProvider;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cartProvider.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              try {
                await Provider.of<OrdersProvider>(context, listen: false)
                    .addOrder(
                  widget.cartProvider.itemsByProductId.values.toList(),
                  widget.cartProvider.totalAmount,
                );

                setState(() {
                  _isLoading = false;
                });
                widget.cartProvider.clear();

                if (!mounted) return;
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              } catch (ex) {
                setState(() {
                  _isLoading = false;
                });

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Could not place order: ${ex.toString()}'),
                  action: SnackBarAction(
                      label: 'DISMISS',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }),
                ));
              }
            },
      style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const Text('CHECKOUT'),
    );
  }
}
