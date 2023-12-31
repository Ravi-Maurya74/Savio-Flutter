import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/CommunityPostList/community_post_list_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/user/user_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/presentation/tabs/community_tab.dart';
import 'package:savio/presentation/tabs/dues_tab.dart';
import 'package:savio/presentation/tabs/home_tab.dart';
import 'package:savio/presentation/tabs/insights_tab.dart';
import 'package:savio/presentation/tabs/user_profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routename = '/scaffold_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () {
        //       SystemNavigator.pop();
        //     },
        //     icon: const Icon(Icons.arrow_back),
        //   ),
        //   title: Text(
        //     'Savio',
        //     style:
        //         Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
        //   ),
        //   centerTitle: true,
        // ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 8),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              elevation: 100,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              selectedFontSize: 16,
              unselectedFontSize: 14,
              selectedLabelStyle: bodyStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 13),
              unselectedLabelStyle: bodyStyle.copyWith(fontSize: 11,fontWeight: FontWeight.normal),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_rounded),
                  label: 'Community',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart_rounded),
                  label: 'Insights',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.money_rounded),
                  label: 'Dues',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: [
            const HomeTab(),
            BlocProvider(
              create: (context) => CommunityPostListBloc(
                authToken: context.read<AuthCubit>().state.authToken!,
                dio: Dio(),
              ),
              child: const CommunityTab(),
            ),
            const InsightTab(),
            Dues(user: context.read<UserBloc>().state.user!),
            const UserProfileTab(),
          ],
        ),
      ),
    );
  }
}
