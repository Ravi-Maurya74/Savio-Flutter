import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/category/category_cubit.dart';
import 'package:savio/business_logic/blocs/transaction/transaction_bloc.dart';
import 'package:savio/business_logic/blocs/user/user_bloc.dart';
import 'package:savio/presentation/screens/home_screen.dart';
import 'package:savio/presentation/screens/login_screen.dart';
import 'package:savio/presentation/screens/register_screen.dart';
import 'package:savio/presentation/widgets/loader.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<AuthCubit>().stream,
      initialData: context.read<AuthCubit>().state,
      builder: (context, snapshot) {
        if (snapshot.data is AuthLoggedIn) {
          UserBloc userBloc =
              UserBloc(authToken: snapshot.data!.token!, dio: Dio());
          userBloc.add(GetInitialUserData());
          TransactionBloc transactionBloc =
              TransactionBloc(authToken: snapshot.data!.token!, dio: Dio());
          transactionBloc.add(FetchAllTransactionsEvent());
          CategoryCubit categoryCubit = CategoryCubit(dio: Dio());
          categoryCubit.loadCategories();
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: userBloc,
              ),
              BlocProvider.value(
                value: transactionBloc,
              ),
              BlocProvider.value(
                value: categoryCubit,
              ),
            ],
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is InitialUserState) {
                  return const Loader();
                } else {
                  return const HomeScreen();
                }
              },
            ),
          );
        } else if (snapshot.data is AuthLoginState) {
          return LoginScreen();
        } else {
          return const RegisterScreen();
        }
      },
    );
  }
}
