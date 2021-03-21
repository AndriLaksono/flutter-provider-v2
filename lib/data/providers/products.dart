import 'dart:convert';
import 'package:flutter/material.dart';

import 'product.dart';
import '../repositories/products_api.dart';
import '../../core/exceptions/http_exception.dart';

class Products with ChangeNotifier {
  
  List<Product> _items = [];

  final String authToken;
  final String userID;

  Products(this.authToken, this.userID, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get getFavoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchSetProducts([bool filterByUser = false]) async {
    try {
      var api = new ProductsAPI();
      var resData = await api.fetchSetProducts(authToken, userID, filterByUser) as Map<String, dynamic>;
      if (resData == null) {
        return;
      }
      final resFav = await api.userFavorites(authToken, userID);
      final resFavData = json.decode(resFav.body);

      final List<Product> loadedProducts = [];
      resData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: resFavData == null ? false : (resFavData[prodId] ?? false),
          imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      return false;
    }
  }

  Future<bool> addProduct(Product product) async {
    try {
      var api = new ProductsAPI();
      var result = await api.addProduct(product, authToken, userID);

      final newProduct = Product(
        id: json.decode(result.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<void> updateProduct(Product newProduct, String id) async {
    try {
      final prodIndex = _items.indexWhere((element) => element.id == id);
      if (prodIndex>= 0) {
        var api = new ProductsAPI();
        await api.updateProduct(newProduct, id, authToken);
        _items[prodIndex] = newProduct;
        notifyListeners();
      } else {
        print('==== EDIT ==== ga ada nilainya woy');
      }
    } catch (e) {
    }
  }

  Future<void> deleteProduct(String id) async {
    final existingProductIndex = _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeWhere((element) => element.id == id);
    notifyListeners();

    // delete
    final api = new ProductsAPI();
    var delete = await api.deleteProduct(id, authToken);

    if(delete == false) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;

  }

}