import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/common/widgets/profile_image_widget.dart';
import 'package:tech_haven/core/utils/pick_image.dart';
import 'package:tech_haven/user/features/profile%20edit/presentation/bloc/profile_edit_page_bloc.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  // Future<File?> pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     return File(pickedFile.path);
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    context.read<ProfileEditPageBloc>().add(GetUserDataEvent());
    ValueNotifier<String> username = ValueNotifier('');
    ValueNotifier<File?> image = ValueNotifier(null);
    void selectImage() async {
      final pickedImage = await pickImage();
      if (pickedImage != null) {
        image.value = pickedImage;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Edit your Data'),
      ),
      body: BlocConsumer<ProfileEditPageBloc, ProfileEditPageState>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
            context.read<ProfileEditPageBloc>().add(GetUserDataEvent());
          } else if (state is UpdateUserDataFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to update profile: ${state.message}')),
            );
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is ProfileEditPageLoading) {
            return const Loader();
          }
          if (state is GetUserDataSuccessState) {
            final user = state.user;
            username.value = user.username!;

            return ListView(
              padding: const EdgeInsets.all(40),
              children: [
                const Text(
                  'Upload or Edit your profile Picture',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Center(
                  child: ProfileImageWidget(
                    initialImage: user.profilePhoto,
                    image: image,
                    userColor: Color(user.color),
                    username: username,
                    onPressed: () async => selectImage(),
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: user.username,
                        onChanged: (value) {
                          username.value = value;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Edit your Username',
                          hintText: 'Name',
                        ),
                      ),
                      // CustomTextFormField(
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   labelText: 'Physical Address',
                      //   hintText: 'Enter your Physical Address',
                      //   textEditingController: TextEditingController(),
                      // ),
                      // CustomTextFormField(
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   labelText: 'Account Number',
                      //   hintText: 'Enter Your Account Number',
                      //   textEditingController: TextEditingController(),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                PrimaryAppButton(
                  buttonText: 'Update the Profile',
                  onPressed: () {
                    final updatedUser = UserModel(
                      uid: user.uid,
                      username: username.value,
                      email: user.email,
                      phoneNumber: user.phoneNumber,
                      currency: user.currency,
                      currencySymbol: user.currencySymbol,
                      profilePhoto: user.profilePhoto,
                      isVendor: user.isVendor,
                      isProfilePhotoUploaded:
                          user.profilePhoto != null || image.value != null,
                      color: user.color,
                      vendorID: user.vendorID,
                      userImageID: null,
                    );
                    context.read<ProfileEditPageBloc>().add(UpdateUserDataEvent(
                        userModel: updatedUser, newImage: image.value));
                  },
                ),
              ],
            );
          }
          return const Center(child: Text('Failed to load user data'));
        },
      ),
    );
  }
}
