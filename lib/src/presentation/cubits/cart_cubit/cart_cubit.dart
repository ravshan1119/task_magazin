import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/data/repositories/cart_repo.dart';
import 'package:task_magazin/src/domain/models/user_carts_model.dart';
import 'package:task_magazin/src/presentation/cubits/cart_cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit({required this.cartRepo}) : super(CartState.initial());

  Future<void> getUserCarts(int id) async {
    // if (state.userCart.isNotEmpty) {
    //   emit(state.copyWith());
    //   return;
    // }
    emit(state.copyWith(status: ApiStatus.loading));
    try {
      print("cubitdan id: $id");
      final List<UserCartsModel> userCart = await cartRepo.getUserCarts(id);
      print("products: $userCart");
      emit(state.copyWith(
        status: ApiStatus.success,
        userCart: userCart,
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
