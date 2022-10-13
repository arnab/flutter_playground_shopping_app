import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/providers/products_provider.dart';
import 'product_overview_item.dart';

class ProductsOverviewGrid extends StatelessWidget {
  final bool _showFavoritesOnly;

  const ProductsOverviewGrid(this._showFavoritesOnly, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = _showFavoritesOnly
        ? productsProvider.favoriteProducts
        : productsProvider.products;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: const ProductOverviewItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
