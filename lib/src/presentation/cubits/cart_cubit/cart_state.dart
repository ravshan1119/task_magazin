import 'package:equatable/equatable.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/domain/models/user_carts_model.dart';

class CartState extends Equatable {
  final ApiStatus status;
  final List<UserCartsModel> carts;
  final UserCartsModel userCarts;
  final String error;

  const CartState({
    required this.status,
    required this.carts,
    required this.error,
    required this.userCarts,
  });

  factory CartState.initial() {
    return CartState(
        status: ApiStatus.initial,
        carts: [],
        error: "",
        userCarts: UserCartsModel(
            id: 0, userId: 0, date: DateTime(2023), products: [], v: 0));
  }

  @override
  List<Object?> get props => [status, carts, error, userCarts];

  @override
  bool get stringify => true;

  CartState copyWith({
    ApiStatus? status,
    List<UserCartsModel>? carts,
    String? error,
    UserCartsModel? userCarts,
  }) {
    return CartState(
      status: status ?? this.status,
      carts: carts ?? this.carts,
      error: error ?? this.error,
      userCarts: userCarts ?? this.userCarts,
    );
  }
}
