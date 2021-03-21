import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/cart.dart';

var baseUrl = 'flutter-purple-default-rtdb.firebaseio.com';

class OrdersAPI {
  
  Future<http.Response> fetchAndSetOrders(String authToken, String userID) async {
    try {
      var uri = Uri.https(baseUrl, '/orders/$userID.json', { 'auth': authToken });
      final res = await http.get(uri);
      return res;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<http.Response> addOrder(List<CartItem> cartProducts, double total, DateTime timestamp, String authToken, String userID) async {
    try {
      var uri = Uri.https(baseUrl, '/orders/$userID.json', { 'auth': authToken });
      final res = await http.post(uri, body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts.map((cp) {
          return {
            'id': cp.id,
            'title': cp.title,
            'quantity': cp.quantity,
            'price': cp.price,
          };
        }).toList()
      }));
      return res;
    } catch (e) {
      print(e);
      return e;
    }
  }

  
}