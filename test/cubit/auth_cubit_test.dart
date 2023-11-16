import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/data/repositories/auth_repository.dart';

import 'auth_cubit_test.mocks.dart';

final mockUser = User.fromMap(
    {"id": '1', "name": 'John Doe', "email": 'johndoe@example.com'});
const authToken = 'token';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
@GenerateNiceMocks([MockSpec<Storage>()])
void main() {
  group("Auth Cubit and User Tests", () {
    Storage storage;
    late AuthCubit authCubit;
    late AuthRepository authRepository;
    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      // PathProviderPlatform.instance = MockPathProviderPlatform();
      storage = MockStorage();

      HydratedBloc.storage = storage;
      authRepository = MockAuthRepository();
      authCubit = AuthCubit(authRepository: authRepository);
    });
    tearDown(() {
      authCubit.close();
    });

    test('initial state is AuthLoggedOutLogin', () {
      expect(authCubit.state, const AuthLoggedOutLogin());
    });

    blocTest<AuthCubit, AuthState>(
      "Login Success",
      build: () {
        when(authRepository.login('johndoe@example.com', 'password'))
            .thenAnswer((_) async => Future.value(authToken));
        return authCubit;
      },
      act: (bloc) {
        bloc.login('johndoe@example.com', 'password');
      },
      expect: () => [
        const AuthLoadingLogin(),
        const AuthLoggedIn(token: authToken),
      ],
    );

    blocTest(
      "Login Failure",
      build: () {
        when(authRepository.login('johndoe@example.com', 'password'))
            .thenThrow(Exception("Login Failed"));
        return authCubit;
      },
      act: (bloc) {
        bloc.login('johndoe@example.com', 'password');
      },
      expect: () => [
        const AuthLoadingLogin(),
        const TypeMatcher<AuthFailedLogin>(),
      ],
    );

    blocTest(
      "Logout Success",
      build: () => authCubit,
      act: (bloc) {
        bloc.logout();
      },
      expect: () => [
        const AuthLoggedOutLogin(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'Register Success',
      build: () {
        return authCubit;
      },
      act: (cubit) => cubit.register(
        email: 'johndoe@example.com',
        password: 'password',
        name: 'John Doe',
        city: 'New York',
        profilePic: null,
      ),
      expect: () => [
        const AuthLoadingRegister(),
        const AuthLoggedOutLogin(),
      ],
    );

    blocTest(
      "Register Fail",
      build: () {
        when(authRepository.register(
              email: 'johndoe@example.com',
              password: 'password',
              name: 'John Doe',
              city: 'New York',
              profilePic: null,
            )).thenThrow(Exception("Register Failed"));
        return authCubit;
      },
      act: (bloc) => bloc
        ..register(
          email: 'johndoe@example.com',
          password: 'password',
          name: 'John Doe',
          city: 'New York',
          profilePic: null,
        ),
      expect: () => [
        const AuthLoadingRegister(),
        const TypeMatcher<AuthFailedRegister>(),
      ],
    );
  });
}
