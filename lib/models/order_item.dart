import 'package:flutter/foundation.dart';
import 'package:flutter_playground_shopping_app/models/cart_item.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartItem> items;
  final DateTime orderedAt;

  OrderItem({
    required this.id,
    required this.amount,
    required this.items,
    required this.orderedAt,
  });
}
