import 'package:flutter/material.dart';

import '../data/dummy_products.dart';
import '../product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts =>
      _products.where((p) => p.isFavorite).toList();

  void addProduct() {
    // _products.add(value);
    notifyListeners();
  }

  Product findById(id) {
    return _products.firstWhere((p) => p.id == id);
  }
}
