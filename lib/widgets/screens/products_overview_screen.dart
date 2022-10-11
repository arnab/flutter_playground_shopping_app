import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/main.dart';
import 'package:flutter_playground_shopping_app/models/data/dummy_products.dart';

import '../../models/product.dart';
import '../product_overview_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;

  ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ShopApp.appTitle),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, i) => ProductOverviewItem(loadedProducts[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
