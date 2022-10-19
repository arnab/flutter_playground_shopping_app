import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/providers/products_provider.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    isFavorite = !isFavorite;
    notifyListeners();

    final url = Uri.https(ProductsProvider.firebaseUrl, '/products/$id.json');
    final response = await http.patch(url,
        body: json.encode({
          'isFavorite': isFavorite,
        }));
    if (response.statusCode >= 300) {
      throw HttpException(
          'Unexpected response code: ${response.statusCode}: ${response.body}');
    }
  }

  Product copyWith({
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Product(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
