import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/data/repositories/category_repo.dart';
import 'package:task_magazin/src/domain/models/product_model.dart';
import 'package:task_magazin/src/presentation/cubits/category_cubit/category_state.dart';

import '../../../data/repositories/product_repo.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo repository;
  final ProductRepo productRepo;

  CategoryCubit({required this.repository, required this.productRepo})
      : super(CategoryState.initial());

  Future<void> getCategories() async {
    if (state.categories.isNotEmpty) {
      emit(state.copyWith());
      return;
    }
    emit(state.copyWith(status: ApiStatus.loading));
    try {
      final List<String> banners = await repository.getAllCategories();
      emit(state.copyWith(
        status: ApiStatus.success,
        categories: banners,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ApiStatus.failure,
        error: e.toString(),
      ));
    }
  }

  Future<void> getAllProducts() async {
    if (state.categories.isNotEmpty) {
      emit(state.copyWith());
      return;
    }
    emit(state.copyWith(status: ApiStatus.loading));
    try {
      final List<ProductModel> products = await productRepo.getAllProducts();
      emit(state.copyWith(
        status: ApiStatus.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ApiStatus.failure,
        error: e.toString(),
      ));
    }
  }

  Future<void> getCategoryName(String category) async {
    if (state.categories.isNotEmpty) {
      emit(state.copyWith());
      return;
    }
    emit(state.copyWith(status: ApiStatus.loading));
    try {
      final List<ProductModel> products = await productRepo.getProductsByCategory(category);
      emit(state.copyWith(
        status: ApiStatus.success,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ApiStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
