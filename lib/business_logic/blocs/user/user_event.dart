part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class GetInitialUserData extends UserEvent {}

final class UserUpdate extends UserEvent {
  final Map<String, dynamic> jsonMap;

  const UserUpdate(this.jsonMap);
}


// bloc builder and stream builder are used to rebuild widgets based on the state of the 
//bloc while navigation and other things are done using navigator and push and pop 
//methods and are not affected by the state of the bloc.

