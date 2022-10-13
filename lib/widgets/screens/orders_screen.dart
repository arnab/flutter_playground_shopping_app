import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/providers/orders_provider.dart';
import 'package:flutter_playground_shopping_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(ordersProvider.orders[i]),
        itemCount: ordersProvider.orders.length,
      ),
    );
  }
}
