import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/common/widgets/profile_image_widget.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/get_random_color.dart';
import 'package:tech_haven/core/utils/pick_image.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/sign_up_welcome_page.dart';

class SignUpWelcomePage extends StatelessWidget {
  final String initialUsername;
  const SignUpWelcomePage({super.key, required this.initialUsername});

  // final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Currency?> currentCurrency = ValueNotifier(null);
    ValueNotifier<String> username = ValueNotifier(initialUsername);
    ValueNotifier<File?> image = ValueNotifier(null);
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
    // String? selectedValue;

    // File? image;
    void selectImage() async {
      final pickedImage = await pickImage();
      if (pickedImage != null) {
        image.value = pickedImage;
      }
    }

    // TextEditingController countryTextEditingController =
    //     TextEditingController();

    final Color userColor = getRandomColor();
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        // listenWhen: (previous, current) =>
        //     current is SignUpWelcomePageActionState,
        // buildWhen: (previous, current) => current is AuthSignUpWelcomPageState,
        listener: (context, state) {
          if (state is AuthIsUserLoggedInSuccess) {
            context.read<AuthBloc>().add(
                  SignUpWelcomePageProfileUploadEvent(
                    uid: state.user.uid!,
                    isProfilePhotoUploaded: image.value != null,
                    image: image.value,
                    username: username.value,
                    color: userColor.value,
                  ),
                );
          }
          if (state is AuthIsUserLoggedInFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
          }
          if (state is CreateUserSuccess) {
            GoRouter.of(context).goNamed(AppRouteConstants.mainPage);
          }
          if (state is CreateUserFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(40),
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: username,
                  builder: (context, value, child) {
                    return Text(
                      'WELCOME ${username.value}!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w800),
                    );
                  },
                ),
                const Text(
                  'upload your image and enter your name below.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: ProfileImageWidget(
                    image: image,
                    userColor: userColor,
                    username: username,
                    onPressed: () async => selectImage(),
                  ),
                ),

                // const Spacer(),
                const SizedBox(
                  height: 50,
                ),

                TextFormField(
                  initialValue: initialUsername,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      username.value = value;
                    } else {
                      username.value = initialUsername;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your UserName',
                  ),
                ),
                //select you country of residence.
                InkWell(
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      onSelect: (Currency currency) {
                        currentCurrency.value = currency;
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: currentCurrency,
                      builder: (context, value, child) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              currentCurrency.value != null
                                  ? '${currentCurrency.value!.name} ${currentCurrency.value!.symbol}'
                                  : 'Select You Base Currency',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            // value: currentCurrency.value,
                            items: items
                                .map(
                                  (String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: 140,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // InkWell(
                //     onTap: () {
                //       print('hello');
                //     },
                //     child: Container(
                //       // width: 20,
                //       height: 20,
                //       decoration: const BoxDecoration(
                //         color: Colors.red,
                //       ),
                //     )),
                const SizedBox(
                  height: 50,
                ),
                PrimaryAppButton(
                  buttonText: 'Save',
                  onPressed: () {
                    if (currentCurrency.value != null) {
                      context.read<AuthBloc>().add(
                            CreateUserEvent(
                              username: username.value,
                              currency: currentCurrency.value!.name,
                              currencySymbol: currentCurrency.value!.symbol,
                              image: image.value,
                              color: userColor.value,
                            ),
                          );
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please Select Your Currency');
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

