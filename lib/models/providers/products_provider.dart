import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_playground_shopping_app/models/http_exception.dart';
import 'package:http/http.dart' as http;

import '../product.dart';

class ProductsProvider with ChangeNotifier {
  static const firebaseUrl =
      'flutter-playground-7b38d-default-rtdb.firebaseio.com';

  List<Product> _products = [];

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts =>
      _products.where((p) => p.isFavorite).toList();

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(firebaseUrl, '/products.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 300) {
        throw HttpException(
            'Unexpected response code: ${response.statusCode}: ${response.body}');
      }
      if (response.body.isEmpty || response.body == 'null') {
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return;
      }
      _products = extractedData.entries
          .map(
            (e) => Product(
              id: e.key,
              title: e.value['title'],
              description: e.value['description'],
              price: e.value['price'],
              imageUrl: e.value['imageUrl'],
              isFavorite: e.value['isFavorite'],
            ),
          )
          .toList();

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(firebaseUrl, '/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      if (response.statusCode >= 300) {
        throw HttpException(
            'Unexpected response code: ${response.statusCode}: ${response.body}');
      }
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _products.add(newProduct);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final productIndex = _products.indexWhere((p) => p.id == id);
    if (productIndex >= 0) {
      final url = Uri.https(firebaseUrl, '/products/$id.json');
      final response = await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price
          }));
      if (response.statusCode >= 300) {
        throw HttpException(
            'Unexpected response code: ${response.statusCode}: ${response.body}');
      }
      _products[productIndex] = product;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Whoa! No Product with id: $id to edit!');
      }
    }
  }

  Product findById(id) {
    return _products.firstWhere((p) => p.id == id);
  }
}
