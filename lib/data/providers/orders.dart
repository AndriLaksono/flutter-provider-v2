import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../providers/cart.dart';
import '../repositories/orders_api.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  final authToken;
  final userID;

  Orders(this.authToken, this.userID, this._orders);

  Future<void> fetchAndSetOrders() async {
    
    var api = new OrdersAPI();
    var res = await api.fetchAndSetOrders(authToken, userID);

    final List<OrderItem> loadedOrders = [];
    final resData = json.decode(res.body) as Map<String, dynamic>;
    if (resData == null) {
      return;
    }
    resData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>).map((el) {
          return CartItem(id: el['id'], title: el['title'], price: el['price'], quantity: el['quantity']);
        }).toList()
      ));
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var api = new OrdersAPI();
    final timestamp = DateTime.now();
    final res = await api.addOrder(cartProducts, total, timestamp, authToken, userID);

    _orders.insert(0, OrderItem(
      id: json.decode(res.body)['name'],
      amount: total,
      dateTime: timestamp,
      products: cartProducts
    ));
    notifyListeners();
  }

}