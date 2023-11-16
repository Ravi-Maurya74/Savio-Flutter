import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/presentation/widgets/custom_button.dart';
import 'package:savio/presentation/widgets/custom_passwordfield.dart';
import 'package:savio/presentation/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  File? _image;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailedRegister) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                // backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text('Create new account',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Please fill in the form to continue'),
                  const SizedBox(height: 70),
                  CustomTextFormField(
                    label: 'Email',
                    iconData: Icons.person,
                    textEditingController: emailController,
                    validator: (p0) =>
                        p0!.isEmpty ? 'Email cannot be empty' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomPasswordFormField(
                    label: 'Password',
                    iconData: Icons.person,
                    textEditingController: passwordController,
                    validator: (p0) =>
                        p0!.isEmpty ? 'Password cannot be empty' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    label: 'Full Name',
                    iconData: Icons.person,
                    textEditingController: nameController,
                    validator: (p0) =>
                        p0!.isEmpty ? 'Name cannot be empty' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    label: 'City',
                    iconData: Icons.location_history,
                    textEditingController: cityController,
                    validator: (p0) =>
                        p0!.isEmpty ? 'City cannot be empty' : null,
                  ),
                  // Give user option to upload profile picture from gallery
                  // or take a picture from camera.

                  if (_image != null)
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(_image!),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: _getImage,
                    child: Text(
                      'Upload Profile Picture',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 70,
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                          dimensions: dimensions,
                          action: state is AuthLoadingRegister
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().register(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        city: cityController.text,
                                        profilePic: _image);
                                  }
                                },
                          child: state is AuthLoadingRegister
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize,
                                  ),
                                ));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an Account? ",
                        style: TextStyle(),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthCubit>().navigateToLogin();
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
