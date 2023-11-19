import 'package:task_magazin/src/data/datasources/remote/api_service.dart';
import 'package:task_magazin/src/data/datasources/remote/universal_response.dart';
import 'package:task_magazin/src/domain/models/product_model.dart';

class CategoryRepo {
  CategoryRepo({required this.apiService});

  final ApiService apiService;

  Future<List<String>> getAllCategories() async {
    UniversalResponse universalResponse = await apiService.getAllCategories();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<String>;
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
}
