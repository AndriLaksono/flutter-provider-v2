import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/product.dart';

var baseUrl = 'flutter-purple-default-rtdb.firebaseio.com';

class ProductsAPI {

  Future<void> fetchSetProducts(String authToken, String userID, bool filterByUser) async {
    try {
      final queryParam = filterByUser ? {'auth': authToken, 'orderBy': '\"creatorId\"', 'equalTo': '\"$userID\"' } 
                                      : {'auth': authToken};
      final uri = Uri.https(baseUrl, '/products.json', queryParam);
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

  Future<http.Response> addProduct(Product product, String authToken, String userID) async {
    try {  
      final uri = Uri.https(baseUrl, '/products.json', {'auth': authToken});
      final result = await http.post(uri, body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'creatorId': userID
      }));
      return result;
    } catch (error) {
      print(error);
      return error;
    }
  }

  Future<void> updateProduct(Product newProduct, String id, String authToken) async {
    try {
      var uri = Uri.https(baseUrl, '/products/$id.json', {'auth': authToken});
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

  Future<bool> deleteProduct(String id, String authToken) async {
    try {
      final uri = Uri.https(baseUrl, '/products/$id.json', {'auth': authToken});
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
  
  Future<http.Response> userFavorites(String authToken, String userID) async {
    try {
      final uriFav = Uri.https(baseUrl, '/userFavorites/$userID.json', {
        'auth': authToken, 'orderBy': 'creatorId', 'equalTo': userID
      });
      final resFav = await http.get(uriFav);
      return resFav;
    } catch (e) {
      print(e);
      return e;
    }
  }

}