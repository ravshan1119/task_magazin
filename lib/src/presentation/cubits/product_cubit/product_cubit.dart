import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/domain/models/product_model.dart';
import 'package:task_magazin/src/presentation/cubits/product_cubit/product_state.dart';

import '../../../data/repositories/product_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo productRepo;

  ProductCubit({required this.productRepo}) : super(ProductState.initial());

  Future<void> getAllProducts() async {
    // if (state.products.isNotEmpty) {
    //   emit(state.copyWith());
    //   return;
    // }
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
    emit(state.copyWith(status: ApiStatus.initial));
  }

  Future<void> getProductByCategoryName(String category) async {
    // if (state.products.isNotEmpty) {
    //   emit(state.copyWith());
    //   return;
    // }
    emit(state.copyWith(status: ApiStatus.loading));
    try {
      final List<ProductModel> products =
          await productRepo.getProductsByCategory(category);
      print("products: $products");
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
    emit(state.copyWith(status: ApiStatus.initial));
  }

  Future<void> getProductById(int id) async {
    // if (state.products.isNotEmpty) {
    //   emit(state.copyWith());
    //   return;
    // }
    emit(state.copyWith(status: ApiStatus.loading));
    try {
      print("cubitdan id: $id");
      final ProductModel product = await productRepo.getProductById(id);
      print("products: $product");
      emit(state.copyWith(
        status: ApiStatus.success,
        product: product,
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
