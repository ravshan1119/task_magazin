import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/data/repositories/cart_repo.dart';
import 'package:task_magazin/src/domain/models/user_carts_model.dart';
import 'package:task_magazin/src/presentation/cubits/cart_cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo repository;

  CartCubit({required this.repository}) : super(CartState.initial());

  Future<void> getUsers(int userId) async {
    if (state.carts.isNotEmpty) {
      emit(state.copyWith());
      return;
    }
    emit(state.copyWith(status: ApiStatus.loading));
    try {
      final List<UserCartsModel> users = await repository.getUserCarts(userId);
      emit(state.copyWith(
        status: ApiStatus.success,
        carts: users,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ApiStatus.failure,
        error: e.toString(),
      ));
    }
    emit(state.copyWith(status: ApiStatus.initial));
  }

  Future<void> getSingleCart(int userId) async {
    if (state.carts.isNotEmpty) {
      emit(state.copyWith());
      return;
    }
    emit(state.copyWith(status: ApiStatus.loading));
    try {
      final UserCartsModel users = await repository.getSingleCart(userId);
      emit(state.copyWith(
        status: ApiStatus.success,
        userCarts: users,
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
