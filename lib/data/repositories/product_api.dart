import 'dart:convert';
import 'package:http/http.dart' as http;

var baseUrl = 'flutter-purple-default-rtdb.firebaseio.com';


class ProductAPI {
  
  Future<http.Response> toggleFavoriteStatus(bool isFavorite, String id) async {
    try {
      final url = Uri.https(baseUrl, '/products/$id.json');
      final res = await http.patch(url, body: json.encode({
        'isFavorite': isFavorite
      }));
      return res;
    } catch (e) {
      return e;
    }
  }
}