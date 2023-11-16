import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/data/repositories/user_repo.dart';
import 'package:task_magazin/src/domain/models/user_model.dart';
import 'package:task_magazin/src/presentation/cubits/users_cubit/users_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo repository;

  UserCubit({required this.repository}) : super(UserState.initial());

  Future<void> getUsers() async {
    if (state.users.isNotEmpty) {
      emit(state.copyWith());
      return;
    }
    emit(state.copyWith(status: ApiStatus.loading));
    try {
      final List<UserModel> users = await repository.getAllUsers();
      emit(state.copyWith(
        status: ApiStatus.success,
        users: users,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ApiStatus.failure,
        error: e.toString(),
      ));
    }
    emit(state.copyWith(status: ApiStatus.initial));
  }
}
