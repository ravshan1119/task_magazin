import 'package:equatable/equatable.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/domain/models/product_model.dart';

class ProductState extends Equatable {
  final ApiStatus status;
  final List<ProductModel> products;
  final ProductModel product;
  final String error;

  const ProductState({
    required this.status,
    required this.error,
    required this.products,
    required this.product,
  });

  factory ProductState.initial() {
    return ProductState(
      status: ApiStatus.initial,
      error: "",
      products: [],
      product: ProductModel(
        id: 0,
        title: "",
        price: 0,
        description: "",
        category: "",
        image: "",
        rating: Rating(rate: 0, count: 0),
      ),
    );
  }

  @override
  List<Object?> get props => [status, error, products, product];

  @override
  bool get stringify => true;

  ProductState copyWith({
    ApiStatus? status,
    List<String>? categories,
    String? error,
    List<ProductModel>? products,
    ProductModel? product,
  }) {
    return ProductState(
      status: status ?? this.status,
      error: error ?? this.error,
      products: products ?? this.products,
      product: product ?? this.product,
    );
  }
}
