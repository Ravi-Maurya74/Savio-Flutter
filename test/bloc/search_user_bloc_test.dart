import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:savio/business_logic/blocs/search_user/search_user_bloc.dart';
// import 'package:savio/logic/bloc/search_user_bloc.dart';

void main() {
  group('SearchUserBloc', () {
    late SearchUserBloc searchUserBloc;

    setUp(() {
      searchUserBloc = SearchUserBloc(
          authToken: 'd7a02e7150a779a9b6512745d9fc58f24594c762', dio: Dio());
    });

    blocTest<SearchUserBloc, SearchUserState>(
      'emits [SearchUserLoading, SearchUserLoaded] when successful',
      build: () => searchUserBloc,
      act: (bloc) => bloc.add(const SearchUserEvent('l')),
      wait: const Duration(seconds: 2), // wait for the API response
      verify: (bloc) {
        final currentState = bloc.state;
        if (currentState is SearchUserLoaded) {
          expect(currentState.users, isNotEmpty); // check that users are loaded
          for (var user in currentState.users) {
            print('User: ${user.email}'); // replace with actual property name
          }
        } else {
          fail('Expected SearchUserLoaded state');
        }
      },
    );
  });
}
