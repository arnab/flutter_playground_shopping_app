import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/providers/orders_provider.dart';
import 'package:flutter_playground_shopping_app/widgets/app_drawer.dart';
import 'package:flutter_playground_shopping_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSetOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.error != null) {
            // TODO: Better error handling with widgets
            return Center(
              child: Text('Could not load orders: ${snapshot.error.toString()}'),
            );
          }
          return Consumer<OrdersProvider>(
            builder: (context, ordersProvider, _) => ListView.builder(
              itemBuilder: (ctx, i) => OrderItem(ordersProvider.orders[i]),
              itemCount: ordersProvider.orders.length,
            ),
          );
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
