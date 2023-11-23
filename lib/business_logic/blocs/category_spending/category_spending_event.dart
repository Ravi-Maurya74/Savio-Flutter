part of 'category_spending_bloc.dart';

sealed class CategorySpendingEvent extends Equatable {
  const CategorySpendingEvent();

  @override
  List<Object> get props => [];
}

final class GetCategorySpending extends CategorySpendingEvent {
  const GetCategorySpending();
}

