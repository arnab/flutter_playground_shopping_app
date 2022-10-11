import 'package:flutter/material.dart';

import 'widgets/screens/product_detail_screen.dart';
import 'widgets/screens/products_overview_screen.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  static const appTitle = 'Or9Shop';
  static const primaryColor = Colors.purple;
  static const primaryColorAccent = Colors.purpleAccent;
  static const secondaryColor = Colors.deepOrange;


  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            states.contains(MaterialState.selected) ? primaryColorAccent : null),
          ),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
        }
    );
  }
}
