import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/order_item.dart'
    as order_model;
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

class OrderItem extends StatefulWidget {
  final order_model.OrderItem orderItem;

  const OrderItem(this.orderItem, {Key? key}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(Money.fromNum(
              widget.orderItem.amount,
              code: 'CAD',
            ).format('S0.00')),
            subtitle: Text(
              DateFormat('yyyy-MMM-dd hh:mm')
                  .format(widget.orderItem.orderedAt),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              height: min(widget.orderItem.items.length * 20.0 + 10, 100),
              child: ListView.builder(
                itemBuilder: (ctx, i) {
                  final item = widget.orderItem.items[i];
                  final String itemPrice = Money.fromNum(
                    item.price,
                    code: 'CAD',
                  ).format('S0.00');
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${item.quantity} x $itemPrice',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: widget.orderItem.items.length,
              ),
            )
        ],
      ),
    );
  }
}
