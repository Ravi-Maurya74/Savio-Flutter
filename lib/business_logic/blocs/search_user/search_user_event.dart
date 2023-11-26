part of 'search_user_bloc.dart';

final class SearchUserEvent extends Equatable {
  final String query;

  const SearchUserEvent(this.query);

  @override
  List<Object> get props => [query];
}


