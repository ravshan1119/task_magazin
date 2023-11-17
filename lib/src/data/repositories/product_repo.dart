import 'package:task_magazin/src/data/datasources/remote/api_service.dart';
import 'package:task_magazin/src/data/datasources/remote/universal_response.dart';
import 'package:task_magazin/src/domain/models/product_model.dart';

class ProductRepo {
  ProductRepo({required this.apiService});

  final ApiService apiService;

  Future<List<ProductModel>> getAllProducts() async {
    UniversalResponse universalResponse = await apiService.getAllProducts();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<List<ProductModel>> getProductsByLimit(int limit) async {
    UniversalResponse universalResponse =
        await apiService.getProductsByLimit(limit: limit);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<ProductModel?> addProduct(ProductModel productModel) async {
    UniversalResponse universalResponse =
        await apiService.addProduct(productModel);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as ProductModel;
    }
    return null;
  }

  Future<ProductModel?> updateProduct(ProductModel productModel) async {
    UniversalResponse universalResponse =
        await apiService.productUpdate(productModel);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as ProductModel;
    }
    return null;
  }

  Future<ProductModel?> deleteProduct(int id) async {
    UniversalResponse universalResponse = await apiService.deleteProduct(id);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as ProductModel;
    }
    return null;
  }

  Future<List<ProductModel>> getSortedProducts(String sort) async {
    UniversalResponse universalResponse = await apiService.sortProducts(sort);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    UniversalResponse universalResponse =
        await apiService.getProductsByCategory(category: category);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<ProductModel> getProductById(int id) async {
    UniversalResponse universalResponse =
        await apiService.getProductById(id: id);
    print("product repo universalResponse: ${universalResponse.data}");
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as ProductModel;
    }
    return ProductModel(
      id: 0,
      title: "",
      price: 0,
      description: "",
      category: "",
      image: "",
      rating: Rating(rate: 0, count: 0),
    );
  }
}
