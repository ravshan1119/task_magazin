import 'package:task_magazin/src/data/datasources/remote/api_service.dart';
import 'package:task_magazin/src/data/datasources/remote/universal_response.dart';

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
}
