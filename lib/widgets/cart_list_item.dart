import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../models/providers/cart_provider.dart';

class CartListItem extends StatelessWidget {
  final String productId;
  final CartItem item;

  const CartListItem({
    required this.productId,
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const itemMargin = EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 4,
    );
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: Text(
                  'Do you want to remove ${item.title} (${item.quantity}x)?'),
              actions: [
                TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('No')),
                TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Yes')),
              ],
            );
          },
        );
        return Future.value(true);
      },
      onDismissed: (_) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: itemMargin,
        child: const Icon(
          Icons.delete,
          size: 35,
          color: Colors.white,
        ),
      ),
      child: Card(
        margin: itemMargin,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(formatMoney(item.price)),
                ),
              ),
            ),
            title: Text(item.title),
            subtitle: Text(formatMoney(item.total)),
            trailing: Text('${item.quantity}x'),
          ),
        ),
      ),
    );
  }

  String formatMoney(double amount, {String currencyCode = 'CAD'}) {
    return Money.fromNum(
      amount,
      code: currencyCode,
    ).format('S0.00');
  }
}
