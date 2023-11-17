import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/transaction.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required this.dio}) : super(CategoryInitial());
  final Dio dio;
  void loadCategories() async {
    emit(CategoryLoading());
    try {
      final Response response = await dio.get(
        TransactionApiConstants.category,
      );
      final categories = (response.data as List)
          .map((e) => Category.fromMap(e))
          .toList();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
