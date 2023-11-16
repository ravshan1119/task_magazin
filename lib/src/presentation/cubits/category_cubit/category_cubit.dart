import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/data/repositories/category_repo.dart';
import 'package:task_magazin/src/presentation/cubits/category_cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo repository;

  CategoryCubit({required this.repository}) : super(CategoryState.initial());

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
    emit(state.copyWith(status: ApiStatus.initial));
  }
}
