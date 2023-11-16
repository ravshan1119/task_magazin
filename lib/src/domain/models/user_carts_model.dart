// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

UserCartsModel temperaturesFromJson(String str) => UserCartsModel.fromJson(json.decode(str));

String temperaturesToJson(UserCartsModel data) => json.encode(data.toJson());

class UserCartsModel {
  int id;
  int userId;
  DateTime date;
  List<Product> products;
  int v;

  UserCartsModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  UserCartsModel copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<Product>? products,
    int? v,
  }) =>
      UserCartsModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        products: products ?? this.products,
        v: v ?? this.v,
      );

  factory UserCartsModel.fromJson(Map<String, dynamic> json) => UserCartsModel(
    id: json["id"],
    userId: json["userId"],
    date: DateTime.parse(json["date"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "date": date.toIso8601String(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "__v": v,
  };
}

class Product {
  int productId;
  int quantity;

  Product({
    required this.productId,
    required this.quantity,
  });

  Product copyWith({
    int? productId,
    int? quantity,
  }) =>
      Product(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
  };
}
