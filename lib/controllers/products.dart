/*

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/myHttpException.dart';
import './product.dart';

class Products with ChangeNotifier {
  Products(this.authToken, this._items);

  final String authToken;
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://new-shop-87099-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': product.id,
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': false,
        }),
      );
      // print(json.decode(response.body));  -> {name: -MzkV0Fcr0IN444CO49f}
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final url = Uri.parse(
        'https://new-shop-87099-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      try {
        final response = await http.patch(
          url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }),
        );
        if (response.statusCode >= 400) {
          throw MyHttpException('sorry, something went wrong.');
        }
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://new-shop-87099-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {}
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://new-shop-87099-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');

    var existingProdIndex = _items.indexWhere((element) => element.id == id);
    var existingProd = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _items.insert(existingProdIndex, existingProd);
        notifyListeners();
        // print('--------------------------------------------');
        throw MyHttpException('Sorry, couldn\'t delete product.');
      }
      existingProdIndex = null;
      existingProd = null;
    } catch (e) {
      rethrow;
    }
  }
}

/*

https://img.freepik.com/free-psd/food-menu-delicious-pizza-social-media-banner-template_106176-362.jpg?size=338&ext=jpg&uid=R65626931&ga=GA1.2.1218116275.1648890617

*/
*/