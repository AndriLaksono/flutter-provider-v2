import 'dart:convert';
import 'package:http/http.dart' as http;

var baseUrl = 'flutter-purple-default-rtdb.firebaseio.com';


class ProductAPI {
  
  Future<http.Response> toggleFavoriteStatus(bool isFavorite, String id, String authToken, String userID) async {
    try {
      final url = Uri.https(baseUrl, '/userFavorites/$userID/$id.json', {'auth': authToken});
      final res = await http.put(url, body: json.encode({
        'isFavorite': isFavorite
      }));
      return res;
    } catch (e) {
      return e;
    }
  }
}