import 'package:task_magazin/src/data/datasources/remote/api_service.dart';
import 'package:task_magazin/src/data/datasources/remote/universal_response.dart';
import 'package:task_magazin/src/domain/models/user_carts_model.dart';

class CartRepo {
  CartRepo({required this.apiService});

  final ApiService apiService;

  Future<List<UserCartsModel>> getUserCarts(int userId) async {
    UniversalResponse universalResponse = await apiService.getUserCarts(userId);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<UserCartsModel>;
    }
    return [];
  }
}
