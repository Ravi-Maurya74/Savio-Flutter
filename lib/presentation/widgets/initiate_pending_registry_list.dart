import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/initiate_accept_reject/initiate_accept_reject_bloc.dart';
import 'package:savio/business_logic/blocs/initiate_pending_registry/initiate_pending_registry_bloc.dart';
import 'package:savio/business_logic/blocs/user/user_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/initiate_peding_registry.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/presentation/widgets/user_profile_pic.dart';

class InitiatePendingRegistryBuilder extends StatelessWidget {
  const InitiatePendingRegistryBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        builder: (context, state) {
          if (state is InitiatePendingRegistryLoaded) {
            return ListView.builder(
              itemCount: state.initiatePendingRegistries.length,
              itemBuilder: (context, index) {
                return InitiatePendingRegistryListTile(
                  initiatePendingRegistry:
                      state.initiatePendingRegistries[index],
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
        bloc: InitiatePendingRegistryBloc(
          authToken: context.read<AuthCubit>().state.authToken!,
          dio: Dio(),
        ));
  }
}

class InitiatePendingRegistryListTile extends StatefulWidget {
  const InitiatePendingRegistryListTile({
    super.key,
    required this.initiatePendingRegistry,
    required this.user,
  });
  final InitiatePendingRegistry initiatePendingRegistry;
  final User user;

  @override
  State<InitiatePendingRegistryListTile> createState() =>
      _InitiatePendingRegistryListTileState();
}

class _InitiatePendingRegistryListTileState
    extends State<InitiatePendingRegistryListTile> {
  bool _accepted = false;
  bool _rejected = false;
  void _accept() {
    setState(() {
      _accepted = true;
    });
  }

  void _reject() {
    setState(() {
      _rejected = true;
    });
  }

  User getOtherUser(
      InitiatePendingRegistry initiatePendingRegistry, User user) {
    if (initiatePendingRegistry.borrower.id == user.id) {
      return initiatePendingRegistry.lender;
    } else {
      return initiatePendingRegistry.borrower;
    }
  }

  Color getAmountColor(
      InitiatePendingRegistry initiatePendingRegistry, User user) {
    if (initiatePendingRegistry.borrower.id == user.id) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final otherUser = getOtherUser(widget.initiatePendingRegistry, widget.user);
    return Stack(
      children: [
        ListTile(
          enabled: !_accepted && !_rejected,
          enableFeedback: true,
          isThreeLine: true,
          titleAlignment: ListTileTitleAlignment.top,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) => InitiateAcceptRejectBloc(
                    authToken: context.read<AuthCubit>().state.authToken!,
                    dio: Dio(),
                    initiatePendingRegistry: widget.initiatePendingRegistry,
                  ),
                  child: BlocBuilder<InitiateAcceptRejectBloc,
                      InitiateAcceptRejectState>(
                    builder: (context, state) {
                      if (state is InitiateAcceptRejectAccepted) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Accepted'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      } else if (state is InitiateAcceptRejectRejected) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Rejected'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      } else if (state is InitiateAcceptRejectInitial) {
                        return AlertDialog(
                          title: const Text('Accept or Reject'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.initiatePendingRegistry.description ??
                                    "",
                                style: bodyStyle.copyWith(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .fontSize),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '₹${widget.initiatePendingRegistry.amount}',
                                style: bodyStyle.copyWith(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontSize,
                                  color: getAmountColor(
                                      widget.initiatePendingRegistry,
                                      widget.user),
                                ),
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.read<InitiateAcceptRejectBloc>().add(
                                    InitiateAcceptRejectAccept(
                                        onAccept: _accept));
                              },
                              child: const Text('Accept'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<InitiateAcceptRejectBloc>().add(
                                    InitiateAcceptRejectReject(
                                        onReject: _reject));
                              },
                              child: const Text('Reject'),
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
                    widget.initiatePendingRegistry.create_date,
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
                widget.initiatePendingRegistry.description ?? "",
                style: bodyStyle.copyWith(
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '₹${widget.initiatePendingRegistry.amount}',
                style: bodyStyle.copyWith(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: getAmountColor(
                      widget.initiatePendingRegistry, widget.user),
                ),
              )
            ],
          ),
        ),
        if (_accepted)
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
                    "Accepted",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        if (_rejected)
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
                    "Rejected",
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
