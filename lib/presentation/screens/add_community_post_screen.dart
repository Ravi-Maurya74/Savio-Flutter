import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/create_community_post/create_community_post_bloc.dart';
import 'package:savio/presentation/widgets/custom_appbar.dart';

class AddCommunityPostScreen extends StatefulWidget {
  const AddCommunityPostScreen({super.key});

  @override
  State<AddCommunityPostScreen> createState() => _AddCommunityPostScreenState();
}

class _AddCommunityPostScreenState extends State<AddCommunityPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
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
    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
        create: (context) => CreateCommunityPostBloc(
          authToken: context.read<AuthCubit>().state.authToken!,
          dio: Dio(),
        ),
        child: BlocListener<CreateCommunityPostBloc, CreateCommunityPostState>(
          listener: (context, state)  {
            if (state is CreateCommunityPostLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Post added successfully. Refresh the page to see the post.',
                  ),
                  duration: Duration(seconds: 10),
                ),
              );
              // await Future.delayed(const Duration(seconds: 3));
              if (!context.mounted) return;
              Navigator.pop(context);
            } else if (state is CreateCommunityPostError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text("Something went wrong. Please try again later."),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomAppbar(
                    title: 'Add Post',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLength: 250,
                          controller: _titleController,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field  is required';
                            }
                            return null;
                          },
                        ),
                        // TextFormField(
                        //   maxLength: 30,
                        //   controller: _cityController,
                        //   decoration: const InputDecoration(
                        //     label: Text('City'),
                        //   ),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'This feild  is required';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        if (_image != null)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Image.file(
                                _image!,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),

                        TextButton(
                          onPressed: _getImage,
                          child: Text(
                            'Add Image',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .fontSize,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(37, 42, 52, 1),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: TextFormField(
                            autofocus: false,
                            controller: _contentController,
                            maxLength: 1000,
                            // style: Theme.of(context).textTheme.titleSmall,
                            minLines: 7,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: 'Content',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field  is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        BlocBuilder<CreateCommunityPostBloc,
                            CreateCommunityPostState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 77, 83, 163),
                              ),
                              onPressed: state is CreateCommunityPostLoading || state is CreateCommunityPostLoaded
                                  ? null
                                  : () async {
                                      bool isValid =
                                          _formKey.currentState!.validate();
                                      if (isValid) {
                                        context
                                            .read<CreateCommunityPostBloc>()
                                            .add(
                                              CreateCommunityPostEvent(
                                                title: _titleController.text,
                                                content:
                                                    _contentController.text,
                                                image: _image,
                                              ),
                                            );
                                      }
                                    },
                              child: state is CreateCommunityPostLoading
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text('Add'),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
