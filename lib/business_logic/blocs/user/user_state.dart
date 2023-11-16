// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

enum UserStatus { initial, loading, loaded, error }

class UserState extends Equatable {
  final User? user;
  final UserStatus status;
  final String? error;
  const UserState({this.user, this.status = UserStatus.initial, this.error});

  @override
  List<Object> get props => [status];

  UserState copyWith({
    User? user,
    UserStatus? status,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

// The initial state of the UserBloc. It has no user data and it is also used to show initial loading screen.
final class InitialUserState extends UserState {
  const InitialUserState() : super(status: UserStatus.initial);
}

// Error state to show error before initialising the user.
final class ErrorUserState extends UserState {
  const ErrorUserState({required String? error})
      : super(status: UserStatus.error, error: error);
}

// InitialisedUserState is abstract class which is used to show the user data after initialising the user. All the subclasses have user data.
abstract class InitialisedUserState extends UserState {
  const InitialisedUserState({required User? user, String? error,UserStatus? status})
      : super(user: user, status: status??UserStatus.loaded,error: error);
}

// The default UserState when we go to home for first time.
final class LoadedUserState extends InitialisedUserState {
  const LoadedUserState({required User? user}) : super(user: user);
}

// Error state to show error after initialising the user, such as error in updating user data.
final class InitialisedUserErrorState extends InitialisedUserState {
  const InitialisedUserErrorState({required User? user, required String? error})
      : super(user: user, error: error,status: UserStatus.error);
}

// Loading state to show loading screen after initialising the user, such as loading screen while updating user data.
final class LoadingUserState extends InitialisedUserState {
  const LoadingUserState({required User? user}) : super(user: user,status: UserStatus.loading);
}
