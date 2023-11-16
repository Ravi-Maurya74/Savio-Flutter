import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:savio/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(const AuthLoggedOutLogin());

  void login(String email, String password) async {
    emit(const AuthLoadingLogin());
    try {
      final token = await authRepository.login(email, password);
      emit(AuthLoggedIn(token: token));
    } on Exception catch (e) {
      String error = e.toString();
      error = error.replaceAll("Exception: ", "");
      emit(AuthFailedLogin(error: error));
    }
  }

  void logout() async {
    emit(const AuthLoggedOutLogin());
  }

  void register(
      {required String email,
      required String password,
      required String name,
      required String city,
      File? profilePic}) async {
    emit(const AuthLoadingRegister());
    try {
      await authRepository.register(
        email: email,
        password: password,
        name: name,
        city: city,
        profilePic: profilePic,
      );
      emit(const AuthLoggedOutLogin());
    } on Exception catch (e) {
      String error = e.toString();
      error = error.replaceAll("Exception: ", "");
      emit(AuthFailedRegister(error: error));
    }
  }

  void navigateToRegister() {
    emit(const AuthLoggedOutRegister());
  }

  void navigateToLogin() {
    emit(const AuthLoggedOutLogin());
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json["authStatus"] == "authenticated") {
      return AuthLoggedIn(token: json["token"]);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is AuthLoggedIn) {
      return {
        "authStatus": "authenticated",
        "token": state.token,
      };
    }
    return {
      "authStatus": "unauthenticated",
    };
  }
}
