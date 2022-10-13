import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/order_item.dart'
    as order_model;
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

class OrderItem extends StatelessWidget {
  final order_model.OrderItem orderItem;

  const OrderItem(this.orderItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(Money.fromNum(
              orderItem.amount,
              code: 'CAD',
            ).format('S0.00')),
            subtitle: Text(
              DateFormat('yyyy-MMM-dd hh:mm').format(orderItem.orderedAt),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
