import 'package:flutter/material.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/presentation/widgets/active_registry_list.dart';
import 'package:savio/presentation/widgets/initiate_pending_registry_list.dart';

class Dues extends StatefulWidget {
  const Dues({super.key});

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
        ));
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
              InitiatePendingRegistryBuilder(),
            ],
          ),
        ),
      ],
    );
  }
}
