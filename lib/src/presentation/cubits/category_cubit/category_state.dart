import 'package:equatable/equatable.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/domain/models/product_model.dart';

class CategoryState extends Equatable {
  final ApiStatus status;
  final List<String> categories;
  final List<ProductModel> products;
  final String error;

  const CategoryState({
    required this.status,
    required this.categories,
    required this.error,
    required this.products,
  });

  factory CategoryState.initial() {
    return const CategoryState(
      status: ApiStatus.initial,
      categories: [],
      error: "",
      products: [],
    );
  }

  @override
  List<Object?> get props => [status, categories, error, products];

  @override
  bool get stringify => true;

  CategoryState copyWith({
    ApiStatus? status,
    List<String>? categories,
    String? error,
    List<ProductModel>? products,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error ?? this.error,
      products: products ?? this.products,
    );
  }
}
