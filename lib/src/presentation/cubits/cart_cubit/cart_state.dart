import 'package:equatable/equatable.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/domain/models/user_carts_model.dart';

class CartState extends Equatable {
  final ApiStatus status;
  final List<UserCartsModel> carts;
  final String error;

  const CartState({
    required this.status,
    required this.carts,
    required this.error,
  });

  factory CartState.initial() {
    return const CartState(
      status: ApiStatus.initial,
      carts: [],
      error: "",
    );
  }

  @override
  List<Object?> get props => [status, carts, error];

  @override
  bool get stringify => true;

  CartState copyWith({
    ApiStatus? status,
    List<UserCartsModel>? carts,
    String? error,
  }) {
    return CartState(
      status: status ?? this.status,
      carts: carts ?? this.carts,
      error: error ?? this.error,
    );
  }
}
