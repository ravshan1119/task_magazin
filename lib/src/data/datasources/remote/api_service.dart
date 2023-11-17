import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_magazin/src/data/datasources/remote/universal_response.dart';
import 'package:task_magazin/src/domain/models/product_model.dart';
import 'package:task_magazin/src/domain/models/user_carts_model.dart';
import 'package:task_magazin/src/domain/models/user_model.dart';
import 'package:task_magazin/src/utils/constants/app_constants.dart';

class ApiService {
  //------------------------------Login provider--------------------------------

  Future<UniversalResponse> loginUser({
    required String username,
    required String password,
  }) async {
    Uri url = Uri.parse('$baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        body: {"username": username, "password": password},
      );
      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)["token"];
        return UniversalResponse(data: token);
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  //------------------------------Product provider------------------------------

  Future<UniversalResponse> getAllProducts() async {
    Uri url = Uri.parse('$baseUrl/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
                  ?.map((e) => ProductModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> getProductsByLimit({required int limit}) async {
    Uri url = Uri.parse('$baseUrl/products?limit=$limit');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
                  ?.map((e) => ProductModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> getProductById({required int id}) async {
    Uri url = Uri.parse('$baseUrl/products/$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("api service: ${jsonDecode(response.body)}");
        return UniversalResponse(
            data: ProductModel.fromJson(jsonDecode(response.body)));
      } else if (response.statusCode != 200) {
        return UniversalResponse(error: 'Error: Status code not equal to 200');
      }

      return UniversalResponse(error: 'Error: Product not found');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> addProduct(ProductModel product) async {
    Uri url = Uri.parse('$baseUrl/products');
    try {
      final response = await http.post(
        url,
        body: product.toJson(),
      );
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: ProductModel.fromJson(
            jsonDecode(response.body),
          ),
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> productUpdate(ProductModel product) async {
    Uri url = Uri.parse('$baseUrl/products/${product.id}');
    try {
      final response = await http.put(
        url,
        body: product.toJson(),
      );
      if (response.statusCode == 200) {
        return UniversalResponse(
            data: ProductModel.fromJson(jsonDecode(response.body)));
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> deleteProduct(int id) async {
    Uri url = Uri.parse('$baseUrl/products/$id');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
            data: ProductModel.fromJson(jsonDecode(response.body)));
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> sortProducts(String sort) async {
    Uri url = Uri.parse('$baseUrl/products?sort=$sort');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
                  ?.map((e) => ProductModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> getProductsByCategory(
      {required String category}) async {
    Uri url = Uri.parse(
      category.isNotEmpty
          ? '$baseUrl/products/category/$category'
          : "$baseUrl/products",
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
            data: (jsonDecode(response.body) as List?)
                    ?.map((e) => ProductModel.fromJson(e))
                    .toList() ??
                []);
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      debugPrint(e.toString());
      return UniversalResponse(error: e.toString());
    }
  }

  //------------------------------User provider---------------------------------

  Future<UniversalResponse> getAllUsers() async {
    Uri url = Uri.parse('$baseUrl/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
                  ?.map((e) => UserModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  //------------------------------Cart provider---------------------------------

  Future<UniversalResponse> getUserCarts(int userId) async {
    Uri url = Uri.parse('$baseUrl/carts/user/$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
                  ?.map((e) => UserCartsModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> getSingleCart(int userId) async {
    Uri url = Uri.parse('$baseUrl/carts/$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as Map<String, dynamic>?),
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  //------------------------------Category provider-----------------------------

  Future<UniversalResponse> getAllCategories() async {
    Uri url = Uri.parse('$baseUrl/products/categories');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
              ?.map((e) => e as String)
              .toList(),
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }
}
