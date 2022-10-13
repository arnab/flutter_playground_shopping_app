import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/providers/orders_provider.dart';
import 'package:flutter_playground_shopping_app/widgets/screens/orders_screen.dart';
import 'package:provider/provider.dart';

import 'models/providers/cart_provider.dart';
import 'models/providers/products_provider.dart';
import 'widgets/screens/cart_screen.dart';
import 'widgets/screens/product_detail_screen.dart';
import 'widgets/screens/products_overview_screen.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  static const appTitle = 'FlutterProShop';
  static const primaryColor = Colors.purple;
  static const primaryColorAccent = Colors.purpleAccent;
  static const secondaryColor = Colors.deepOrange;


  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => OrdersProvider()),
      ],
      child: MaterialApp(
          title: appTitle,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: primaryColor,
            ).copyWith(
              secondary: secondaryColor,
            ),
            fontFamily: 'Lato',
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all(secondaryColor),
              trackColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? primaryColorAccent
                  : null),
            ),
          ),
          home: const ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            OrdersScreen.routeName: (ctx) => const OrdersScreen(),
          }
      ),
    );
  }
}
