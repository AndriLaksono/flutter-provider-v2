import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/product.dart';

var baseUrl = 'flutter-purple-default-rtdb.firebaseio.com';

class ProductsAPI {

  Future<void> fetchSetProducts() async {
    try {
      var uri = Uri.https(baseUrl, '/products.json');
      final response = await http.get(uri);
      final resData = json.decode(response.body) as Map<String, dynamic>;
      if (resData == null) {
        return null;
      }
      return resData;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> addProduct(Product product) async {
    try {  
      var uri = Uri.https(baseUrl, '/products.json');
      var result = await http.post(uri, body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      }));
      return result;
    } catch (error) {
      print(error);
      return error;
    }
  }

  Future<void> updateProduct(Product newProduct, String id) async {
    try {
      var uri = Uri.https(baseUrl, '/products/$id.json');
      await http.patch(uri, body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl
      }));
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final uri = Uri.https(baseUrl, '/products/$id.json');
      final response = await http.delete(uri);
      if(response.statusCode >= 400) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

}