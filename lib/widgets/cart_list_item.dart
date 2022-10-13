import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/cart_item.dart';
import 'package:money2/money2.dart';

class CartListItem extends StatelessWidget {
  final CartItem item;

  const CartListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
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
    );
  }

  String formatMoney(double amount, {String currencyCode = 'CAD'}) {
    return Money.fromNum(
      amount,
      code: currencyCode,
    ).format('S0.00');
  }
}
