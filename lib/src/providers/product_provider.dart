import 'dart:convert';

import 'package:formbloc/src/model/product_model.dart';

import 'package:http/http.dart' as http;

class ProductProvider {
  final _baseUrl = 'https://flutter-demo-3fdad.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_baseUrl/products.json';
    final response = await http.post(url, body: productModelToJson(product));
    // final data = json.decode(response.body);
    return response.statusCode == 200;
  }

  Future<bool> editProduct(ProductModel product) async {
    final url = '$_baseUrl/products/${product.id}.json';
    final response = await http.put(url, body: productModelToJson(product));
    // final data = json.decode(response.body);
    return response.statusCode == 200;
  }

  Future<List<ProductModel>> getProducts() async {
    final url = '$_baseUrl/products.json';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<ProductModel> products = new List();
      if (data == null) {
        return [];
      } else {
        data.forEach((key, value) {
          final prod = ProductModel.fromJson(value);
          prod.id = key;
          products.add(prod);
        });
        return products;
      }
    } else {
      return [];
    }
  }

  Future<bool> deleteProduct(String id) async {
    final url = '$_baseUrl/products/$id.json';
    final resp = await http.delete(url);
    return resp.statusCode == 200;
  }
}
