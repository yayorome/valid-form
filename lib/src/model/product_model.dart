// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.title = '',
    this.value = 0,
    this.availability = true,
    this.photoUrl,
  });

  String id;
  String title;
  double value;
  bool availability;
  String photoUrl;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        value: json["value"].toDouble(),
        availability: json["availability"],
        photoUrl: json["photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
        "availability": availability,
        "photo_url": photoUrl,
      };
}
