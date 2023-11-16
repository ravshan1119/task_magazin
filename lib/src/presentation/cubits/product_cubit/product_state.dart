import 'package:equatable/equatable.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/domain/models/product_model.dart';

class ProductState extends Equatable {
  final ApiStatus status;
  final List<ProductModel> products;
  final String error;

  const ProductState(
      {required this.status,
      required this.error,
      required this.products});

  factory ProductState.initial() {
    return const ProductState(
      status: ApiStatus.initial,
      error: "",
      products: [],
    );
  }

  @override
  List<Object?> get props => [status, error, products];

  @override
  bool get stringify => true;

  ProductState copyWith({
    ApiStatus? status,
    List<String>? categories,
    String? error,
    List<ProductModel>? products,
  }) {
    return ProductState(
      status: status ?? this.status,
      error: error ?? this.error,
      products: products ?? this.products,
    );
  }
}
