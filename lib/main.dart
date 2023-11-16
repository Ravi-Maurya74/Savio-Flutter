import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/repositories/auth_repository.dart';
import 'package:savio/presentation/screens/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) =>
          AuthCubit(authRepository: AuthRepository(dio: Dio())),
      child: MaterialApp(
        title: 'Savio',
        theme: themeData,
        home: const Wrapper(),
      ),
    );
  }
}

