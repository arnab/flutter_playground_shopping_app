import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/providers/products_provider.dart';
import 'package:flutter_playground_shopping_app/widgets/app_drawer.dart';
import 'package:flutter_playground_shopping_app/widgets/manage_product_item.dart';
import 'package:flutter_playground_shopping_app/widgets/screens/product_edit_screen.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  static const routeName = '/manage-products';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [IconButton(onPressed: () {
          Navigator.of(context).pushNamed(ProductEditScreen.routeName);
        }, icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (ctx, i) =>
              Column(
                children: [
                  ManageProductItem(productsProvider.products[i]),
                  const Divider(),
                ],
              ),
          itemCount: productsProvider.products.length,
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
