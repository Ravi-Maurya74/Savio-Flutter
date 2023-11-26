import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/search_user/search_user_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/presentation/widgets/user_profile_pic.dart';

class SelectOtherUser extends StatelessWidget {
  const SelectOtherUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Other User'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
            ),
            onChanged: (value) {
              if (value.length > 2) {
                context.read<SearchUserBloc>().add(SearchUserEvent(value));
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<SearchUserBloc, SearchUserState>(
              builder: (context, state) {
                if (state is SearchUserLoaded) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pop(state.users[index]);
                        },
                        leading:
                            UserProfilePic(url: state.users[index].profilePic),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.users[index].name,
                              style: bodyStyle,
                            ),
                            Text(
                              state.users[index].email,
                              style: bodyStyle.copyWith(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .fontSize),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is SearchUserInitial) {
                  return Container();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
