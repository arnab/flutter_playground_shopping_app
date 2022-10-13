import 'package:flutter/foundation.dart';
import 'package:flutter_playground_shopping_app/models/cart_item.dart';
import 'package:flutter_playground_shopping_app/models/order_item.dart';

class OrdersProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  void addOrder(List<CartItem> cartItems, double totalAmount) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: totalAmount,
          items: cartItems,
          orderedAt: DateTime.now(),
        ));
    notifyListeners();
  }
}
