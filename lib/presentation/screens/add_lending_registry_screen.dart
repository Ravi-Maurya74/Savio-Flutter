import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/create_lending_registry/create_lending_registry_bloc.dart';
import 'package:savio/business_logic/blocs/search_user/search_user_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/user.dart';
import 'package:savio/presentation/screens/search_other_user.dart';
import 'package:savio/presentation/widgets/user_profile_pic.dart';

class AddLendingRegistryScreen extends StatefulWidget {
  const AddLendingRegistryScreen({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  AddLendingRegistryScreenState createState() =>
      AddLendingRegistryScreenState();
}

class AddLendingRegistryScreenState extends State<AddLendingRegistryScreen> {
  String role = 'Lender';
  String? amount;
  String? description;
  User? otherUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Add Lending Registry',style: titleStyle,),
      ),
      body: BlocProvider(
        create: (context) => CreateLendingRegistryBloc(
          authToken: context.read<AuthCubit>().state.authToken!,
          dio: Dio(),
        ),
        child:
            BlocListener<CreateLendingRegistryBloc, CreateLendingRegistryState>(
          listener: (context, state) {
            if (state is CreateLendingRegistryLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Record added successfully. Refresh the page to see the registry.',
                  ),
                  duration: Duration(seconds: 10),
                ),
              );
              // await Future.delayed(const Duration(seconds: 3));
              if (!context.mounted) return;
              Navigator.pop(context);
            } else if (state is CreateLendingRegistryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Error adding registry. Please try again.',
                  ),
                  duration: Duration(seconds: 10),
                ),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text('You are: ',style: bodyStyle,),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: role,
                        items: ['Lender', 'Borrower'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: const Text('Select Role'),
                        onChanged: (String? newValue) {
                          setState(() {
                            role = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) => amount = value,
                  decoration:  InputDecoration(
                    labelText: 'Amount',
                    labelStyle: bodyStyle,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field  is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) => description = value,
                  decoration:  InputDecoration(
                    labelText: 'Description',
                    labelStyle: bodyStyle,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field  is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                if (otherUser != null)
                  ListTile(
                    leading: UserProfilePic(url: otherUser!.profilePic),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          otherUser!.name,
                          style: bodyStyle,
                        ),
                        Text(
                          otherUser!.email,
                          style: bodyStyle.copyWith(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .fontSize),
                        ),
                      ],
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextButton(
                    onPressed: () async {
                      final User? user = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => SearchUserBloc(
                                      authToken: context
                                          .read<AuthCubit>()
                                          .state
                                          .authToken!,
                                      dio: Dio(),
                                    ),
                                    child: const SelectOtherUser(),
                                  )));
                      if (user != null) {
                        setState(() {
                          otherUser = user;
                        });
                      }
                    },
                    child: role == 'Lender'
                        ? const Text('Select Borrower')
                        : const Text('Select Lender'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: savioLinearGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: BlocBuilder<CreateLendingRegistryBloc,
                      CreateLendingRegistryState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state is CreateLendingRegistryLoading
                            ? null
                            : () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                if (otherUser == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please select the other user.',
                                      ),
                                      duration: Duration(seconds: 10),
                                    ),
                                  );
                                  return;
                                }
                                if (role == 'Lender') {
                                  context.read<CreateLendingRegistryBloc>().add(
                                        CreateLendingRegistryEvent(
                                          lender: widget.user.id,
                                          borrower: otherUser!.id,
                                          amount: amount!,
                                          description: description!,
                                        ),
                                      );
                                } else {
                                  context.read<CreateLendingRegistryBloc>().add(
                                        CreateLendingRegistryEvent(
                                          lender: otherUser!.id,
                                          borrower: widget.user.id,
                                          amount: amount!,
                                          description: description!,
                                        ),
                                      );
                                }
                              },
                        child: Text('Submit',
                            style: titleStyle.copyWith(
                                color: Colors.white, fontSize: 16)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
