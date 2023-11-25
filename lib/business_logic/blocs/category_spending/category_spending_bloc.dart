import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/category_spending.dart';

part 'category_spending_event.dart';
part 'category_spending_state.dart';

class CategorySpendingBloc
    extends Bloc<CategorySpendingEvent, CategorySpendingState> {
  CategorySpendingBloc(
      {required this.authToken,
      required this.dio,
      required this.month,
      required this.year})
      : super(CategorySpendingInitial()) {
    on<GetCategorySpending>(_onGetCategorySpending);
    add(const GetCategorySpending());
  }
  Dio dio;
  String authToken;
  int month;
  int year;

  FutureOr<void> _onGetCategorySpending(
      GetCategorySpending event, Emitter<CategorySpendingState> emit) async {
    emit(CategorySpendingLoading());
    // await Future.delayed(const Duration(seconds: 5));
    try {
      final response = await dio.get(
        TransactionApiConstants.categorySpending(year, month),
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
      List<CategorySpending> categorySpending = (response.data as List)
          .map((e) => CategorySpending.fromMap(e))
          .toList();
      emit(CategorySpendingLoaded(categorySpending));
    } catch (e) {
      emit(CategorySpendingError(e.toString()));
    }
  }
}
