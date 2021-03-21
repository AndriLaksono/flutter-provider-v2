import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

var baseUrlAuth = 'identitytoolkit.googleapis.com';
var firebaseWebKey = 'AIzaSyBy5Esoraq4O6WHCXQCR8zKbhnEghxchAA';

class AuthAPI {

  Future<http.Response> signUp(String email, String password) async {
    try {
      var url = Uri.https(baseUrlAuth, '/v1/accounts:signUp', {'key': firebaseWebKey});
      final res = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      }));
      return res;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<http.Response> signIn(String email, String password) async {
    try {
      var url = Uri.https(baseUrlAuth, '/v1/accounts:signInWithPassword', {'key': firebaseWebKey});
      final res = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      }));
      return res;
    } catch (e) {
      print(e);
      return e;
    }
  }

}