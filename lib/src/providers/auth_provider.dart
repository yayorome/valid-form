import 'dart:convert';

import 'package:formbloc/src/utils/user_prefs.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  final _firebaseToken = 'AIzaSyBMSU9oUaou6LBhPS3abNAQvPAsaOfNAFI';
  final _prefs = UserPrefs();

  Future<Map<String, dynamic>> createUser(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken';
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(url, body: json.encode(authData));
    Map<String, dynamic> decodedResponse = json.decode(response.body);

    print(decodedResponse);

    if (decodedResponse.containsKey('idToken')) {
      _prefs.token = decodedResponse['idToken'];
      return {'ok': true};
    } else {
      return {'ok': false, 'message': decodedResponse['error']['message']};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken';
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(url, body: json.encode(authData));
    Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      _prefs.token = decodedResponse['idToken'];
      return {'ok': true};
    } else {
      return {'ok': false, 'message': decodedResponse['error']['message']};
    }
  }
}
