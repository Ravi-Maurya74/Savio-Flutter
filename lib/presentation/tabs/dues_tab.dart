import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/user/user_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/presentation/screens/add_lending_registry_screen.dart';
import 'package:savio/presentation/widgets/active_registry_list.dart';
import 'package:savio/presentation/widgets/clear_pending_registry_list.dart';
import 'package:savio/presentation/widgets/initiate_pending_registry_list.dart';

class Dues extends StatefulWidget {
  const Dues({super.key,required this.user});
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
            const SizedBox(
              height: 200,
            ),
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
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Pending'),
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
