import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/widgets/custom_drop_down.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/entities/address_details.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';

// class ShippingDetailsPage extends StatefulWidget {
//   const ShippingDetailsPage({
//     super.key,
//     required this.totalAmount,
//   });

//   final String totalAmount;

//   @override
//   State<ShippingDetailsPage> createState() => _ShippingDetailsPageState();
// }

// class _ShippingDetailsPageState extends State<ShippingDetailsPage> {
//   @override
//   Widget build(BuildContext context) {
//     // context.read<CheckoutBloc>().add(CheckoutInitialEmit());
//     final TextEditingController addressController = TextEditingController();
//     final TextEditingController pinController = TextEditingController();
//     final TextEditingController cityController = TextEditingController();
//     final TextEditingController stateController = TextEditingController();
//     final TextEditingController countryController = TextEditingController();
//     final TextEditingController currencyController = TextEditingController();
//     final TextEditingController amountController = TextEditingController();
//     amountController.text = '${widget.totalAmount}0';
//     final formKey = GlobalKey<FormState>();
//     void submitForm() async {
//       if (formKey.currentState!.validate()) {
//         formKey.currentState!.save();
//         context.read<CheckoutBloc>().add(SubmitPaymentFormEvent(
//               address: addressController.text,
//               pin: pinController.text,
//               city: cityController.text,
//               state: stateController.text,
//               country: countryController.text,
//               currency: currencyController.text,
//               amount: (amountController.text.isNotEmpty)
//                   ? (double.parse(amountController.text) * 100)
//                       .toInt()
//                       .toString()
//                   : '0',
//             ));
//         // print('hello how are you');
//       }
//     }

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: formKey,
//         child: BlocConsumer<CheckoutBloc, CheckoutState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 // itemExtent: 700,
//                 children: <Widget>[

//                   CustomTextFormField(
//                       enabled: state is CheckoutLoading ? false : true,
//                       labelText: 'Address',
//                       hintText: 'Enter Your Address',
//                       textEditingController: addressController),
//                   CustomTextFormField(
//                       enabled: state is CheckoutLoading ? false : true,
//                       labelText: 'Country',
//                       hintText: 'Enter Your Country',
//                       textEditingController: countryController),
//                   CustomTextFormField(
//                       enabled: state is CheckoutLoading ? false : true,
//                       labelText: 'State',
//                       hintText: 'Enter Your State',
//                       textEditingController: stateController),
//                   CustomTextFormField(
//                       enabled: state is CheckoutLoading ? false : true,
//                       labelText: 'City',
//                       hintText: 'Enter Your City',
//                       textEditingController: cityController),
//                   CustomTextFormField(
//                       enabled: state is CheckoutLoading ? false : true,
//                       labelText: 'PIN',
//                       hintText: 'Enter Your PIN',
//                       keyboardType: TextInputType.number,
//                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                       textEditingController: pinController),
//                   CustomTextFormField(
//                     enabled: state is CheckoutLoading ? false : true,
//                     labelText: 'Curreny',
//                     hintText: 'Enter Your Currency',
//                     textEditingController: currencyController,
//                   ),
//                   CustomTextFormField(
//                       enabled: false,
//                       labelText: 'Total Amount',
//                       hintText: 'Enter Your Amount',
//                       textEditingController: amountController),
//                   const SizedBox(height: 20),
//                   RoundedRectangularButton(
//                     isLoading: state is CheckoutLoading ? true : false,
//                     title: 'SUBMIT PAYMENT',
//                     onPressed: () {
//                       state is! CheckoutLoading
//                           ? submitForm()
//                           : () {
//                               Fluttertoast.showToast(msg: 'Please Wait');
//                             };
//                     },
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class ShippingDetailsPage extends StatefulWidget {
  const ShippingDetailsPage({super.key, required this.totalAmount});

  final String totalAmount;

  @override
  State<ShippingDetailsPage> createState() => _ShippingDetailsPageState();
}

class _ShippingDetailsPageState extends State<ShippingDetailsPage> {
  late TextEditingController addressController;
  late TextEditingController pinController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;
  late TextEditingController currencyController;
  late TextEditingController amountController;
  TextEditingController addressSearchEditingController =
      TextEditingController();
  AddressDetails? selectedAddress;
  List<String> stringAddresses = [];
  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
    pinController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
    currencyController = TextEditingController();
    amountController = TextEditingController();
    currencyController.text = 'aed';
    amountController.text = '${widget.totalAmount}0';
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    void submitForm() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        //save the address
        if (selectedAddress == null &&
            !stringAddresses.contains(addressController.text)) {
          context.read<CheckoutBloc>().add(SaveUserAddressEvent(
              address: addressController.text,
              pin: pinController.text,
              city: cityController.text,
              state: stateController.text,
              country: countryController.text));
        } else {
          if (stringAddresses.contains(addressController.text)) {
            Fluttertoast.showToast(
              msg:
                  'This Address will not be saved for future purposes as It Already exists',
            );
          }
        }
        // print('object');
        context.read<CheckoutBloc>().add(SubmitPaymentFormEvent(
              address: addressController.text,
              pin: pinController.text,
              city: cityController.text,
              state: stateController.text,
              country: countryController.text,
              currency: currencyController.text,
              amount: (amountController.text.isNotEmpty)
                  ? (double.parse(amountController.text) * 100)
                      .toInt()
                      .toString()
                  : '0',
            ));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: BlocConsumer<CheckoutBloc, CheckoutState>(
          // listenWhen: (previous, current) => current is AddressSelectState,
          listener: (context, state) {
            // print(state);
            if (state is SaveUserAddressFailed) {
              Fluttertoast.showToast(msg: state.message);
            }
            if (state is SaveUserAddressSuccess) {
              Fluttertoast.showToast(msg: 'New Location is added SuccessFully');
            }
            if (state is AddressFailed) {
              Fluttertoast.showToast(msg: "You don't have saved address yet");
            }
          },

          builder: (context, addressLoadState) {
            // if (addressLoadState is AddressLoaded) {
            //   stringAddresses =
            //       addressLoadState.addresses.map((e) => e.line1).toList();
            stringAddresses.add('UnSelect Location');
            return SingleChildScrollView(
              child: Column(
                children: [
                  // if (addressLoadState is AddressLoaded)
                  // BlocBuilder<CheckoutBloc, CheckoutState>(
                  // buildWhen: (previous, current) =>
                  //     current is AddressSelectState,
                  // builder: (context, state) {
                  // if(state is AddressSelected){

                  // }
                  // return
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    buildWhen: (previous, current) =>
                        current is GetAllUserAddressState,
                    builder: (context, state) {
                      if (addressLoadState is AddressLoaded) {
                        stringAddresses = addressLoadState.addresses
                            .map((e) => e.line1)
                            .toList();
                        stringAddresses.add('UnSelect Location');
                        return CustomDropDown<String>(
                            searchEditingController:
                                addressSearchEditingController,
                            hintText: 'Select Address',
                            items: stringAddresses,
                            currentItem: selectedAddress?.line1,
                            onChanged: (selectedAddress) {
                              setState(() {
                                if (selectedAddress != null &&
                                    addressLoadState.addresses
                                        .map((e) => e.line1)
                                        .contains(selectedAddress)) {
                                  this.selectedAddress = addressLoadState
                                      .addresses
                                      .firstWhere((element) =>
                                          element.line1 == selectedAddress);
                                  addressController.text =
                                      this.selectedAddress!.line1;
                                  pinController.text =
                                      this.selectedAddress!.postalCode;
                                  cityController.text =
                                      this.selectedAddress!.city;
                                  stateController.text =
                                      this.selectedAddress!.state;
                                  countryController.text =
                                      this.selectedAddress!.country;
                                } else {
                                  addressController.clear();
                                  pinController.clear();
                                  cityController.clear();
                                  stateController.clear();
                                  countryController.clear();
                                  this.selectedAddress = null;
                                }
                              });
                            });
                      }
                      return Container();
                    },
                  ),
                  //   },
                  // ),
                  CustomTextFormField(
                    enabled: selectedAddress == null,
                    labelText: 'Address',
                    hintText: 'Enter Your Address',
                    textEditingController: addressController,
                  ),
                  CustomTextFormField(
                    enabled: selectedAddress == null,
                    labelText: 'Country',
                    hintText: 'Enter Your Country',
                    textEditingController: countryController,
                  ),
                  CustomTextFormField(
                    enabled: selectedAddress == null,
                    labelText: 'State',
                    hintText: 'Enter Your State',
                    textEditingController: stateController,
                  ),
                  CustomTextFormField(
                    enabled: selectedAddress == null,
                    labelText: 'City',
                    hintText: 'Enter Your City',
                    textEditingController: cityController,
                  ),
                  CustomTextFormField(
                    enabled: selectedAddress == null,
                    labelText: 'PIN',
                    hintText: 'Enter Your PIN',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textEditingController: pinController,
                  ),
                  CustomTextFormField(
                    enabled: false,
                    labelText: 'Currency',
                    hintText: 'Enter Your Currency',
                    textEditingController: currencyController,
                  ),
                  CustomTextFormField(
                    enabled: false,
                    labelText: 'Total Amount',
                    hintText: 'Enter Your Amount',
                    textEditingController: amountController,
                  ),
                  const SizedBox(height: 20),
                  RoundedRectangularButton(
                    isLoading:
                        context.read<CheckoutBloc>().state is CheckoutLoading,
                    title: 'SUBMIT PAYMENT',
                    onPressed: () {
                      if (context.read<CheckoutBloc>().state
                          is! CheckoutLoading) {
                        submitForm();
                      } else {
                        Fluttertoast.showToast(msg: 'Please Wait');
                      }
                    },
                  ),
                ],
              ),
            );
            // }
            // return const Loader();
          },
        ),
      ),
    );
  }
}
