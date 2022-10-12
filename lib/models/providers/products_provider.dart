import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/data/dummy_products.dart';

import '../product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products => [..._products];

  void addProduct() {
    // _products.add(value);
    notifyListeners();
  }

  Product findById(id) {
    return _products.firstWhere((p) => p.id == id);
  }

}
