import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/main.dart';

import '../products_overview_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ShopApp.appTitle),
      ),
      body: const ProductsOverviewGrid(),
    );
  }
}
