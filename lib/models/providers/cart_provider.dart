import 'package:flutter/foundation.dart';

import '../cart_item.dart';

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

  void removeItem(String productId) {
    _itemsByProductId.remove(productId);
    notifyListeners();
  }

  void clear() {
    _itemsByProductId.clear();
    notifyListeners();
  }

  int get itemCount => _itemsByProductId.values
      .map((cartItem) => cartItem.quantity)
      .fold(0, (a, b) => a + b);

  int get uniqueProductCount => _itemsByProductId.values.length;

  double get totalAmount => _itemsByProductId.values
      .map((cartItem) => cartItem.price * cartItem.quantity)
      .fold(0.0, (a, b) => a + b);

}

