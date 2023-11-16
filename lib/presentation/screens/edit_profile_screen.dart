import 'package:flutter/material.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/user/user_bloc.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/presentation/widgets/custom_appbar.dart';
import 'package:savio/presentation/widgets/user_detail_tile.dart';
// import 'package:shimmer/shimmer.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    UserState state = context.watch<UserBloc>().state;
    User user = state.user!;
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: CustomAppbar(
              title: title,
            ),
          ),
          const SizedBox(height: 16),
          UserdetailTile(
            Icons.chevron_right_outlined,
            titleDescription: user.name,
            trailingIcon: Icons.create,
            title: 'Name',
            onPress: () async {
              var result = await showTextInputDialog(
                  title: "Update Student Name",
                  barrierDismissible: true,
                  // style: AdaptiveStyle
                  context: context,
                  textFields: [
                    DialogTextField(
                      hintText: "Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                    ),
                  ]);
              if (result == null) return;
              if (!context.mounted) return;
              context.read<UserBloc>().add(UserUpdate({'name': result[0]}));
            },
          ),
          const Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          UserdetailTile(
            Icons.chevron_right_outlined,
            titleDescription: user.city,
            trailingIcon: Icons.create,
            title: 'City',
            onPress: () async {
              var result = await showTextInputDialog(
                  title: "Update City",
                  barrierDismissible: true,
                  // style: AdaptiveStyle
                  context: context,
                  textFields: [
                    DialogTextField(
                      hintText: "City",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                    ),
                  ]);
              if (result == null) return;
              if (!context.mounted) return;
              context.read<UserBloc>().add(UserUpdate({'city': result[0]}));
            },
          ),
          const Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          UserdetailTile(
            Icons.chevron_right_outlined,
            titleDescription: '${user.totalBudget}',
            trailingIcon: Icons.create,
            title: 'Total budget',
            onPress: () async {
              var result = await showTextInputDialog(
                  title: "Update Total Budget",
                  barrierDismissible: true,
                  // style: AdaptiveStyle
                  context: context,
                  textFields: [
                    DialogTextField(
                      hintText: "TotalBudget",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        var budget = double.tryParse(value);
                        if (budget == null) {
                          return "Only numeric input allowed";
                        }
                        return null;
                      },
                    ),
                  ]);
              if (result == null) return;
              if (!context.mounted) return;
                    context
                        .read<UserBloc>()
                        .add(UserUpdate({'total_budget': result[0]}));
            },
          ),
          const Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
        ],
      )),
    );
  }
}
