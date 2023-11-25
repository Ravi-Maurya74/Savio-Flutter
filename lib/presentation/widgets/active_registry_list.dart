import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/active_registry/active_registry_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/clear_registry_request/clear_registry_request_bloc.dart';
import 'package:savio/business_logic/blocs/user/user_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/active_registry.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/presentation/widgets/user_profile_pic.dart';

class ActiveRegistryBuilder extends StatelessWidget {
  const ActiveRegistryBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is ActiveRegistryLoaded) {
          return ListView.builder(
            itemCount: state.activeRegistries.length,
            itemBuilder: (context, index) {
              return ActiveRegistryListTile(
                activeRegistry: state.activeRegistries[index],
                user: context.read<UserBloc>().state.user!,
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      bloc: ActiveRegistryBloc(
        authToken: context.read<AuthCubit>().state.authToken!,
        dio: Dio(),
      ),
    );
  }
}

class ActiveRegistryListTile extends StatefulWidget {
  const ActiveRegistryListTile(
      {super.key, required this.activeRegistry, required this.user});
  final ActiveRegistry activeRegistry;
  final User user;

  @override
  State<ActiveRegistryListTile> createState() => _ActiveRegistryListTileState();
}

class _ActiveRegistryListTileState extends State<ActiveRegistryListTile> {
  bool _cleared = false;
  User getOtherUser(ActiveRegistry activeRegistry, User user) {
    if (activeRegistry.borrower.id == user.id) {
      return activeRegistry.lender;
    } else {
      return activeRegistry.borrower;
    }
  }
  Color amountColor(ActiveRegistry activeRegistry, User user) {
  if (activeRegistry.borrower.id == user.id) {
    return Colors.red;
  } else {
    return Colors.green;
  }
}

  void clear() {
      setState(() {
        _cleared = true;
      });
    }

  @override
  Widget build(BuildContext context) {
    final otherUser = getOtherUser(widget.activeRegistry, widget.user);

    return Stack(
      children: [
        ListTile(
          enabled: !_cleared,
          enableFeedback: true,
          isThreeLine: true,
          titleAlignment: ListTileTitleAlignment.top,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) => ClearRegistryRequestBloc(
                      activeRegistry: widget.activeRegistry,
                      authToken: context.read<AuthCubit>().state.authToken!,
                      dio: Dio()),
                  child: BlocBuilder<ClearRegistryRequestBloc,
                      ClearRegistryRequestState>(
                    builder: (context, state) {
                      if (state is ClearRegistryRequestInitial) {
                        return AlertDialog(
                          title: const Text('Clear Registry'),
                          content: const Text(
                              'Are you sure you want to clear this registry?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<ClearRegistryRequestBloc>().add(
                                      ClearRegistryRequestEvent(
                                        onClearRegistryRequestEvent: clear,
                                      ),
                                    );
                                Navigator.pop(context);
                              },
                              child: const Text('Clear'),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                );
              },
            );
          },
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
                    widget.activeRegistry.create_date,
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
                widget.activeRegistry.description ?? "",
                style: bodyStyle.copyWith(
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '₹${widget.activeRegistry.amount}',
                style: bodyStyle.copyWith(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: amountColor(widget.activeRegistry, widget.user),
                ),
              )
            ],
          ),
        ),
        if (_cleared)
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
                color: const Color(0xFFd988a1).withOpacity(0.7),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Requested to clear",
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

