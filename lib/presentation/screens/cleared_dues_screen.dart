import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/cleared_registry/cleared_registry_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/cleared_registry.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/presentation/widgets/user_profile_pic.dart';

class ClearedDuesScreen extends StatelessWidget {
  const ClearedDuesScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cleared Dues',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder(
          builder: (context, state) {
            if (state is ClearedRegistryLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ClearedRegistryTile(
                    clearedRegistry: state.clearedRegistryList[index],
                    user: user,
                  );
                },
                itemCount: state.clearedRegistryList.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          bloc: ClearedRegistryBloc(
            authToken: context.read<AuthCubit>().state.authToken!,
            dio: Dio(),
          ),
        ),
      ),
    );
  }
}

class ClearedRegistryTile extends StatelessWidget {
  const ClearedRegistryTile(
      {super.key, required this.clearedRegistry, required this.user});
  final ClearedRegistry clearedRegistry;
  final User user;

  User getOtherUser() {
    if (clearedRegistry.lender == user) {
      return clearedRegistry.borrower;
    } else {
      return clearedRegistry.lender;
    }
  }

  Color getAmountColor() {
    if (clearedRegistry.lender == user) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final otherUser = getOtherUser();
    return Stack(
      children: [
        ListTile(
          enabled: true,
          enableFeedback: false,
          isThreeLine: true,
          titleAlignment: ListTileTitleAlignment.top,
          leading: UserProfilePic(
            url: otherUser.profilePic,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    otherUser.name,
                    style: bodyStyle,
                  ),
                  const Spacer(),
                  Text(
                    clearedRegistry.create_date,
                    style: bodyStyle.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize),
                  ),
                ],
              ),
              Text(
                otherUser.email,
                style: bodyStyle.copyWith(
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                clearedRegistry.description,
                style: bodyStyle.copyWith(
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '₹${clearedRegistry.amount}',
                style: bodyStyle.copyWith(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: getAmountColor(),
                ),
              )
            ],
          ),
        ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  // bottomLeft: Radius.circular(10),
                  // topRight: Radius.circular(10),
                  // topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: savioLinearGradient,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Cleared",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
