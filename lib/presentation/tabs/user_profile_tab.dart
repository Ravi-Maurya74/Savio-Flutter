import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/user/user_bloc.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/presentation/screens/edit_profile_screen.dart';
import 'package:savio/presentation/widgets/profile_stack_design.dart';
import 'package:savio/presentation/widgets/user_detail_tile.dart';

class UserProfileTab extends StatefulWidget {
  const UserProfileTab({super.key});

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserBloc>().state.user!;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ProfileStackDesign(),
          Text(
            user.name,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(user.email, style: Theme.of(context).textTheme.bodyMedium!),
          const SizedBox(
            height: 25,
          ),
          Column(
            children: [
              UserdetailTile(
                Icons.account_circle_outlined,
                titleDescription: 'Edit your profile name and city',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'User profile',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((_) => BlocProvider.value(
                                value: context.read<UserBloc>(),
                                child: const EditProfileScreen(
                                    title: 'Edit User Profile'),
                              ))));
                },
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              // UserdetailTile(
              //   Icons.account_balance_wallet_outlined,
              //   titleDescription: 'View your total and category budgets',
              //   trailingIcon: Icons.chevron_right_outlined,
              //   title: 'Budget',
              //   onPress: () {},
              // ),
              // const Divider(
              //   thickness: 0.5,
              //   indent: 20,
              //   endIndent: 20,
              // ),
              UserdetailTile(
                Icons.bookmark_outline,
                titleDescription: 'See all the saved posts from community',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'Saved posts',
                onPress: () {},
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(
                Icons.account_balance_outlined,
                titleDescription: 'See your monthly savings',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'Savings',
                onPress: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => const SavingsScreen())));
                },
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(
                Icons.forum_outlined,
                titleDescription: 'View all your posts',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'My posts',
                onPress: () {},
              ),
              const Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              UserdetailTile(
                Icons.power_settings_new,
                titleDescription: 'Log out your profile',
                trailingIcon: Icons.chevron_right_outlined,
                title: 'Log Out',
                onPress: () {
                  context.read<AuthCubit>().logout();
                },
              ),
              // const SizedBox(
              //   height: 150,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
