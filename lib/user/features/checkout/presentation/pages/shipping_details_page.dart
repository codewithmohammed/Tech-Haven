import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';

class ShippingDetailsPage extends StatefulWidget {
  const ShippingDetailsPage({
    super.key,
    required this.totalAmount,
  });

  final String totalAmount;

  @override
  State<ShippingDetailsPage> createState() => _ShippingDetailsPageState();
}

class _ShippingDetailsPageState extends State<ShippingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // context.read<CheckoutBloc>().add(CheckoutInitialEmit());
    final TextEditingController addressController = TextEditingController();
    final TextEditingController pinController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController currencyController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    amountController.text = '${widget.totalAmount}0';
    final formKey = GlobalKey<FormState>();
    void submitForm() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        // print('hello ok');
        context.read<CheckoutBloc>().add(SubmitPaymentFormEvent(
              name: 'rayid',
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
        // print('hello how are you');
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: BlocConsumer<CheckoutBloc, CheckoutState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            // print(state is CheckoutLoading);
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // itemExtent: 700,
                children: <Widget>[
                  CustomTextFormField(
                      enabled: state is CheckoutLoading ? false : true,
                      labelText: 'Address',
                      hintText: 'Enter Your Address',
                      textEditingController: addressController),
                  CustomTextFormField(
                      enabled: state is CheckoutLoading ? false : true,
                      labelText: 'Country',
                      hintText: 'Enter Your Country',
                      textEditingController: countryController),
                  CustomTextFormField(
                      enabled: state is CheckoutLoading ? false : true,
                      labelText: 'State',
                      hintText: 'Enter Your State',
                      textEditingController: stateController),
                  CustomTextFormField(
                      enabled: state is CheckoutLoading ? false : true,
                      labelText: 'City',
                      hintText: 'Enter Your City',
                      textEditingController: cityController),
                  CustomTextFormField(
                      enabled: state is CheckoutLoading ? false : true,
                      labelText: 'PIN',
                      hintText: 'Enter Your PIN',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textEditingController: pinController),
                  CustomTextFormField(
                    enabled: state is CheckoutLoading ? false : true,
                    labelText: 'Curreny',
                    hintText: 'Enter Your Currency',
                    textEditingController: currencyController,
                  ),
                  CustomTextFormField(
                      enabled: false,
                      labelText: 'Total Amount',
                      hintText: 'Enter Your Amount',
                      textEditingController: amountController),
                  const SizedBox(height: 20),
                  RoundedRectangularButton(
                    isLoading: state is CheckoutLoading ? true : false,
                    title: 'SUBMIT PAYMENT',
                    onPressed: () {
                      state is! CheckoutLoading
                          ? submitForm()
                          : () {
                              Fluttertoast.showToast(msg: 'Please Wait');
                            };
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
