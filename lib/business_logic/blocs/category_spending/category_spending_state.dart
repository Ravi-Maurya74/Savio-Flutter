part of 'category_spending_bloc.dart';

sealed class CategorySpendingState extends Equatable {
  const CategorySpendingState();
  
  @override
  List<Object> get props => [];
}

final class CategorySpendingInitial extends CategorySpendingState {}

final class CategorySpendingLoading extends CategorySpendingState {}

final class CategorySpendingLoaded extends CategorySpendingState {
  const CategorySpendingLoaded(this.categorySpending);

  final List<CategorySpending> categorySpending;

  @override
  List<Object> get props => [categorySpending];
}

final class CategorySpendingError extends CategorySpendingState {
  const CategorySpendingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
