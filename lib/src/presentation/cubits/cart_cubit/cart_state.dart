import 'package:equatable/equatable.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/domain/models/product_model.dart';
import 'package:task_magazin/src/domain/models/user_carts_model.dart';

class CartState extends Equatable {
  final ApiStatus status;
  final UserCartsModel userCart;
  final String error;

  const CartState({
    required this.status,
    required this.error,
    required this.userCart,
  });

  factory CartState.initial() {
    return CartState(
      status: ApiStatus.initial,
      error: "",
      userCart: UserCartsModel(id: 0, userId: 0, date: "", products: [], v: 0),
    );
  }

  @override
  List<Object?> get props => [status, error, userCart];

  @override
  bool get stringify => true;

  CartState copyWith({
    ApiStatus? status,
    String? error,
    UserCartsModel? userCart,
  }) {
    return CartState(
      status: status ?? this.status,
      error: error ?? this.error,
      userCart: userCart ?? this.userCart,
    );
  }
}
