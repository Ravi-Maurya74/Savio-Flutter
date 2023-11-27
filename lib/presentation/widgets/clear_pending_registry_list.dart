import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/clear_accept_reject/clear_accept_reject_bloc.dart';
import 'package:savio/business_logic/blocs/clear_pending_registry/clear_pending_registry_bloc.dart';
import 'package:savio/business_logic/blocs/user/user_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/clear_pending_registry.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/presentation/widgets/user_profile_pic.dart';

class ClearPendingRegistryBuilder extends StatelessWidget {
  const ClearPendingRegistryBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is ClearPendingRegistryLoaded) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ClearPendingRegistryListTile(
                  clearPendingRegistry: state.clearPendingRegistryList[index],
                  user: context.read<UserBloc>().state.user!,
                );
              },
              childCount: state.clearPendingRegistryList.length,
            ),
          );
        } else {
          return SliverToBoxAdapter(child: Container());
        }
      },
      bloc: ClearPendingRegistryBloc(
        authToken: context.read<AuthCubit>().state.authToken!,
        dio: Dio(),
      ),
    );
  }
}

class ClearPendingRegistryListTile extends StatefulWidget {
  const ClearPendingRegistryListTile({
    super.key,
    required this.clearPendingRegistry,
    required this.user,
  });
  final ClearPendingRegistry clearPendingRegistry;
  final User user;

  @override
  State<ClearPendingRegistryListTile> createState() =>
      _ClearPendingRegistryListTileState();
}

class _ClearPendingRegistryListTileState
    extends State<ClearPendingRegistryListTile> {
  bool _cleared = false;
  bool _denied = false;

  User getOtherUser() {
    if (widget.clearPendingRegistry.borrower.id == widget.user.id) {
      return widget.clearPendingRegistry.lender;
    } else {
      return widget.clearPendingRegistry.borrower;
    }
  }

  Color amountColor() {
    if (widget.clearPendingRegistry.borrower.id == widget.user.id) {
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

  void deny() {
    setState(() {
      _denied = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          enabled: !_cleared && !_denied,
          enableFeedback: true,
          isThreeLine: true,
          titleAlignment: ListTileTitleAlignment.top,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) => ClearAcceptRejectBloc(
                    clearPendingRegistry: widget.clearPendingRegistry,
                    authToken: context.read<AuthCubit>().state.authToken!,
                    dio: Dio(),
                  ),
                  child: BlocBuilder<ClearAcceptRejectBloc,
                      ClearAcceptRejectState>(
                    builder: (context, state) {
                      if (state is ClearAcceptRejectInitial) {
                        return AlertDialog(
                          title: const Text('Clear Due?'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.clearPendingRegistry.description,
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
                                '₹ ${widget.clearPendingRegistry.amount}',
                                style: bodyStyle.copyWith(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontSize,
                                  color: amountColor(),
                                ),
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.read<ClearAcceptRejectBloc>().add(
                                      ClearAcceptRejectClear(
                                        onClear: clear,
                                      ),
                                    );
                                Navigator.pop(context);
                              },
                              child: const Text('Clear'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<ClearAcceptRejectBloc>().add(
                                      ClearAcceptRejectDeny(
                                        onDeny: deny,
                                      ),
                                    );
                                Navigator.pop(context);
                              },
                              child: const Text('Deny'),
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
            url: getOtherUser().profilePic,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    getOtherUser().name,
                    style: bodyStyle,
                  ),
                  const Spacer(),
                  Text(
                    widget.clearPendingRegistry.create_date,
                    style: bodyStyle.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize),
                  ),
                ],
              ),
              Text(
                getOtherUser().email,
                style: bodyStyle.copyWith(
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.clearPendingRegistry.description,
                style: bodyStyle.copyWith(
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '₹${widget.clearPendingRegistry.amount}',
                style: bodyStyle.copyWith(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: amountColor(),
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
                    "Cleared",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        if (_denied)
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
                    "Denied",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        if (!_cleared && !_denied)
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
                // color: const Color(0xFFd988a1).withOpacity(0.7),
                decoration: BoxDecoration(
                  // border: Border.all(color: const Color(0xFF50559a)),
                  color: const Color(0xFF50559a).withOpacity(0.7),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Accept Clear",
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
