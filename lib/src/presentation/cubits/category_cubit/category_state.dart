import 'package:equatable/equatable.dart';
import 'package:task_magazin/src/data/api_status.dart';
class CategoryState extends Equatable {
  final ApiStatus status;
  final List<String> categories;
  final String error;

  const CategoryState(
      {required this.status,
      required this.categories,
      required this.error,
      });

  factory CategoryState.initial() {
    return const CategoryState(
      status: ApiStatus.initial,
      categories: [],
      error: "",
    );
  }

  @override
  List<Object?> get props => [status, categories, error];

  @override
  bool get stringify => true;

  CategoryState copyWith({
    ApiStatus? status,
    List<String>? categories,
    String? error,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }
}
