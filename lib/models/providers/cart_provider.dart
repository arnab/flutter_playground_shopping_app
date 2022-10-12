import 'package:flutter/foundation.dart';
import 'package:flutter_playground_shopping_app/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _itemsByProductId = {};

  Map<String, CartItem> get itemsByProductId => {..._itemsByProductId};

  void addItem(String productId, double price, String title) {
    if (_itemsByProductId.containsKey(productId)) {
      _itemsByProductId.update(
          productId,
          (item) => CartItem(
                id: item.id,
                title: item.title,
                quantity: item.quantity + 1,
                price: item.price,
              ));
    } else {
      _itemsByProductId.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  int itemCount() => _itemsByProductId.values
      .map((cartItem) => cartItem.quantity)
      .fold(0, (a, b) => a + b);
}
