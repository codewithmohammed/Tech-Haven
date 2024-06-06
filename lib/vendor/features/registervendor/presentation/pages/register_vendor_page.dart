import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/pick_image.dart';
import 'package:tech_haven/vendor/features/registervendor/presentation/bloc/register_vendor_bloc.dart';

class RegisterVendorPage extends StatefulWidget {
  // final String initialUsername;
  final User user;
  const RegisterVendorPage({
    super.key,
    // required this.initialUsername,
    required this.user,
  });

  @override
  State<RegisterVendorPage> createState() => _RegisterVendorPageState();
}

class _RegisterVendorPageState extends State<RegisterVendorPage> {
  // TextEditingController businessNameController = TextEditingController();
  TextEditingController physicalAdressController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  // TextEditingController routingNumberController = TextEditingController();

  final vendorRegisterFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.user.vendorID != null) {
      print('object');
      context
          .read<RegisterVendorBloc>()
          .add(CheckForVendorStatusEvent(vendorID: widget.user.vendorID!));
      // print(
      //     'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss${widget.user.uid}');
    }
    // ValueNotifier<Currency?> currentCurrency = ValueNotifier(null);
    ValueNotifier<String> businnessName = ValueNotifier(widget.user.username!);
    ValueNotifier<File?> image = ValueNotifier(null);
    void selectImage() async {
      final pickedImage = await pickImage();
      if (pickedImage != null) {
        image.value = pickedImage;
      }
    }

//if the user is signed in we will pass the user model else we will else we will direct him to sign in or sign up page from the profile page and if he already is logged in or signed up we will direct them to register page if they are not vendor and to vendor page if thery are vendor.
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          leading: const BackButton(),
          title: const Text(
            'Register as Vendor',
          ),
        ),
        body: BlocConsumer<RegisterVendorBloc, RegisterVendorState>(
          listener: (context, state) {
            if (state is SendRequestForVendorSuccess) {
              context
                  .read<RegisterVendorBloc>()
                  .add(CheckForVendorStatusEvent(vendorID: state.vendorID));
            }
            if (state is SendRequestForVendorFailed) {
              // context
              //     .read<RegisterVendorBloc>()
              //     .add(CheckForVendorStatusEvent(vendorID: state.vendorID));
              Fluttertoast.showToast(msg: state.message);
            }
            if (state is CheckForVendorStatusFailed) {
              physicalAdressController.clear();
              accountNumberController.clear();
              Fluttertoast.showToast(msg: state.message);
            }
          },
          builder: (context, state) {
            print(state);
            if (state is RegisterVendorLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Please Wait...'),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
            if (state is CheckForVendorStatusSuccess) {
              return Center(
                child: Text(
                  !state.vendor.isVendor
                      ? 'This May take a while to be accepted by the admin , Please Wait...'
                      : 'You are a vendor',
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(40),
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey ${widget.user.username}!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const Text(
                  'upload your business image and enter your business name below.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius:
                                  Constants.globalBoxBlur.spreadRadius,
                              blurRadius: Constants.globalBoxBlur.blurRadius,
                              color: AppPallete.primaryAppColor,
                            ),
                          ],
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: image,
                        builder: (context, value, child) {
                          return Container(
                            alignment: Alignment.center,
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(widget.user.color),
                              image: image.value == null
                                  ? null
                                  : DecorationImage(
                                      image: FileImage(
                                        image.value!,
                                      ),
                                    ),
                            ),
                            child: image.value == null
                                ? ValueListenableBuilder(
                                    valueListenable: businnessName,
                                    builder: (context, value, child) {
                                      return Text(
                                        businnessName.value.split('').first,
                                        style: const TextStyle(
                                          fontSize: 100,
                                        ),
                                      );
                                    })
                                : const SizedBox(),
                          );
                        },
                        // child:
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircularButton(
                          onPressed: () async {
                            //select an image from the gallery and show
                            selectImage();
                          },
                          circularButtonChild: const Icon(
                            Icons.camera_alt,
                            color: AppPallete.whiteColor,
                          ),
                          diameter: 50,
                        ),
                      ),
                    ],
                  ),
                ),

                // const Spacer(),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: vendorRegisterFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        // controller: businessNameController,
                        initialValue: widget.user.username,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            businnessName.value = value;
                          } else {
                            businnessName.value = widget.user.username!;
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enter your Business Name',
                          hintText: 'Name',
                        ),
                      ),
                      // CustomTextFormField(
                      //   labelText: 'Enter Your Business name',
                      //   hintText: 'Name',
                      //   textEditingController: businessNameController,
                      // ),
                      CustomTextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Physical Address',
                        hintText: 'Enter your Physical Address',
                        textEditingController: physicalAdressController,
                      ),
                      CustomTextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Account Number',
                        hintText: 'Enter Your Account Number',
                        textEditingController: accountNumberController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                //first we need to make an request to the admin by sending this data for the acceptance of this data's

                // during that period we should show a page showing the admin is yet to be approved to make you a vendor

                //if the admin accepted this we will show and make the user profile as vendor and also a profile for this vendor will be created

                //if the admin accepted this they will be directed to the vendor page if not we will delete the vendor
                PrimaryAppButton(
                  buttonText: 'Register as Vendor',
                  onPressed: () {
                    // print(businnessName.value);
                    if (vendorRegisterFormKey.currentState!.validate()) {
                      context.read<RegisterVendorBloc>().add(
                            SendRequestForVendorEvent(
                              user: widget.user,
                              businessPicuture: image.value,
                              businessName: businnessName.value,
                              physicalAddress: physicalAdressController.text,
                              accountNumber: accountNumberController.text,
                            ),
                          );
                    }
                    // if (currentCurrency.value != null) {
                    //   context.read<AuthBloc>().add(
                    //         CreateUserEvent(
                    //           username: username.value,
                    //           currency: currentCurrency.value!.name,
                    //           currencySymbol: currentCurrency.value!.symbol,
                    //           image: image.value,
                    //           color: userColor.value,
                    //         ),
                    //       );
                    // } else {
                    //   Fluttertoast.showToast(
                    //       msg: 'Please Select Your Currency');
                    // }
                  },
                ),
              ],
            );
          },
        ));
  }
}
