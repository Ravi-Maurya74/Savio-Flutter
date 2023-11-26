import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/clear_pending_registry/clear_pending_registry_bloc.dart';

class ClearPendingRegistryBuilder extends StatelessWidget {
  const ClearPendingRegistryBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is ClearPendingRegistryLoaded) {
          return ListView.builder(
            itemCount: state.clearPendingRegistryList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.clearPendingRegistryList[index].description),
                subtitle: Text(state.clearPendingRegistryList[index].amount),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      bloc: ClearPendingRegistryBloc(
        authToken: context.read<AuthCubit>().state.authToken!,
        dio: Dio(),
      ),
    );
  }
}
