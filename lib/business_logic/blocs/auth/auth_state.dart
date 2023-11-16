part of 'auth_cubit.dart';

enum AuthStatus { unkown, authenticated, unauthenticated }

@immutable
sealed class AuthState extends Equatable{
  final AuthStatus authStatus;
  final String? token;
  final String? error;

  const AuthState({required this.authStatus, this.token, this.error});

  @override
  List<Object?> get props => [authStatus, token, error];
}

// all states related to login

abstract class AuthLoginState extends AuthState {
  const AuthLoginState({String? error})
      : super(authStatus: AuthStatus.unauthenticated, error: error);
}

// all states related to register

abstract class AuthRegisterState extends AuthState {
  const AuthRegisterState({String? error})
      : super(authStatus: AuthStatus.unauthenticated, error: error);
}

// All concrete classes from here

// Authenticaticated and logged in. Token is required
final class AuthLoggedIn extends AuthState {
  const AuthLoggedIn({required String token})
      : super(authStatus: AuthStatus.authenticated, token: token);
}

// Unauthenticated and on login screen.
final class AuthLoggedOutLogin extends AuthLoginState {
  const AuthLoggedOutLogin() : super();
}

// Unauthenticated and on register screen.
final class AuthLoggedOutRegister extends AuthRegisterState {
  const AuthLoggedOutRegister() : super();
}

// Loading state for login
final class AuthLoadingLogin extends AuthLoginState {
  const AuthLoadingLogin() : super();
}

// Loading state for register
final class AuthLoadingRegister extends AuthRegisterState {
  const AuthLoadingRegister() : super();
}

// Failed state for login
final class AuthFailedLogin extends AuthLoginState {
  const AuthFailedLogin({required String error}) : super(error: error);
}

// Failed state for register
final class AuthFailedRegister extends AuthRegisterState {
  const AuthFailedRegister({required String error}) : super(error: error);
}
