import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/main.dart';

import '../products_overview_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ShopApp.appTitle),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (ViewMode val) {
              setState(() {
                switch(val) {
                  case ViewMode.favorites:
                    _showFavoritesOnly = true;
                    break;
                  case ViewMode.all:
                    _showFavoritesOnly = false;
                    break;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: ViewMode.favorites,
                child: Text('Favorites'),
              ),
              const PopupMenuItem(
                value: ViewMode.all,
                child: Text('All'),
              ),
            ],
          )
        ],
      ),
      body: ProductsOverviewGrid(_showFavoritesOnly),
    );
  }
}

enum ViewMode {
  favorites,
  all,
}
