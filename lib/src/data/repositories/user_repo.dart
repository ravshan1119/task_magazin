import 'package:task_magazin/src/data/datasources/remote/api_service.dart';
import 'package:task_magazin/src/data/datasources/remote/universal_response.dart';
import 'package:task_magazin/src/domain/models/user_model.dart';

class UserRepo {
  UserRepo({required this.apiService});

  final ApiService apiService;

  Future<List<UserModel>> getAllUsers() async {
    UniversalResponse universalResponse = await apiService.getAllUsers();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<UserModel>;
    }
    return [];
  }
}
