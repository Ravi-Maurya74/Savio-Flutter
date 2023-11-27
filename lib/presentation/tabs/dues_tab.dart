import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/balance/balance_bloc.dart';
import 'package:savio/business_logic/blocs/user/user_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/presentation/screens/add_lending_registry_screen.dart';
import 'package:savio/presentation/screens/cleared_dues_screen.dart';
import 'package:savio/presentation/widgets/active_registry_list.dart';
import 'package:savio/presentation/widgets/clear_pending_registry_list.dart';
import 'package:savio/presentation/widgets/initiate_pending_registry_list.dart';

class Dues extends StatefulWidget {
  const Dues({super.key, required this.user});
  final User user;

  @override
  State<Dues> createState() => _DuesState();
}

class _DuesState extends State<Dues> {
  Key key = UniqueKey();
  void refresh() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dues',
          style: titleStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              refresh();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const BalanceWidget(),
            Expanded(
              child: MyListViewWithTabs(
                key: key,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: OpenContainer(
          transitionDuration: const Duration(milliseconds: 500),
          transitionType: ContainerTransitionType.fadeThrough,
          closedShape: const CircleBorder(),
          closedColor: const Color(0xFF50559a),
          openColor: Theme.of(context)
              .scaffoldBackgroundColor, //const Color(0xFF16161e),
          middleColor: const Color(0xFFd988a1),
          closedBuilder: (context, action) => Container(
                margin: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF50559a),
                ),
                child: const Icon(
                  Icons.add,
                  size: 25,
                  color: Color.fromARGB(255, 216, 216, 216),
                ),
              ),
          openBuilder: (context, action) => AddLendingRegistryScreen(
                user: widget.user,
              )),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceBloc, BalanceState>(
      builder: (context, state) {
        if (state is BalanceLoaded) {
          return Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Lending',
                      style: bodyStyle,
                    ),
                    Text(
                      state.total_lent.toString(),
                      style: bodyStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Total Borrowing',
                      style: bodyStyle,
                    ),
                    Text(
                      state.total_owed.toString(),
                      style: bodyStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Net',
                      style: bodyStyle,
                    ),
                    Text(
                      state.net.toString(),
                      style: bodyStyle,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 400,
          );
        }
      },
      bloc: BalanceBloc(
        authToken: context.read<AuthCubit>().state.authToken!,
        dio: Dio(),
      ),
    );
  }
}

class MyListViewWithTabs extends StatefulWidget {
  const MyListViewWithTabs({super.key});

  @override
  MyListViewWithTabsState createState() => MyListViewWithTabsState();
}

class MyListViewWithTabsState extends State<MyListViewWithTabs>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Text('Active',style: titleStyle.copyWith(fontSize: 20),),),
            Tab(child: Text('Pending',style: titleStyle.copyWith(fontSize: 20),),),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              ActiveRegistryBuilder(),
              CustomScrollView(
                slivers: [
                  InitiatePendingRegistryBuilder(),
                  ClearPendingRegistryBuilder(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
