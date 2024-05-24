import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/cart/presentation/pages/cart_page.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.totalAmount});
  final String totalAmount;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PageController pageController = PageController();
  int current_step = 0;

  // List<Step> steps = [

  // ];
  @override
  Widget build(BuildContext context) {
    context.read<CheckoutBloc>().add(CheckoutInitialEmit());
    return Scaffold(
      // Appbar
      appBar: const AppBarSearchBar(
        backButton: true,
        deliveryPlaceNeeded: false,
      ),
      // Body
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is SubmitPaymentFormSuccess) {
            pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
            print('showing the payment sheet');
            context.read<CheckoutBloc>().add(ShowPresentPaymentSheetEvent());
          }
        },
        builder: (context, state) {
          if (state is SubmitPaymentFormSuccess) {
            current_step = 1;
            return Column(
              children: [
                SizedBox(
                  // color: Colors.red,
                  height: 72,
                  child: Stepper(
                    elevation: 0,
                    currentStep: current_step,
                    steps: const [
                      Step(
                        title: Text('Shipping'),
                        content: Text('World!'),
                        state: StepState.complete,
                        isActive: true,
                      ),
                      Step(
                        title: Text('Submit'),
                        content: Text('Hello World!'),
                        state: StepState.indexed,
                        isActive: true,
                      ),
                    ],
                    type: StepperType.horizontal,
                    stepIconBuilder: (stepIndex, stepState) {
                      return null;
                    },
                    controlsBuilder: (context, details) {
                      return Container();
                    },
                    onStepTapped: (step) {
                      // setState(() {
                      //   current_step = step;
                      // });
                    },
                    onStepContinue: () {},
                    onStepCancel: () {
                      // setState(() {
                      //   if (current_step > 0) {
                      //     current_step = current_step - 1;
                      //   } else {
                      //     current_step = 0;
                      //   }
                      // });
                    },
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ShippingDetailsPage(
                        totalAmount: widget.totalAmount,
                      ),
                      const SubmitPage(),
                    ],
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              Container(
                color: Colors.red,
                height: 72,
                child: Stepper(
                  elevation: 0,
                  currentStep: current_step,
                  steps: [
                    Step(
                      title: const Text('Shipping'),
                      content: const Text('World!'),
                      state: current_step == 1
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: true,
                    ),
                    Step(
                      title: const Text('Submit'),
                      content: const Text('Hello World!'),
                      state: StepState.indexed,
                      isActive: current_step == 1,
                    ),
                  ],
                  type: StepperType.horizontal,
                  stepIconBuilder: (stepIndex, stepState) {
                    return null;
                  },
                  controlsBuilder: (context, details) {
                    return Container();
                  },
                  onStepTapped: (step) {
                    // setState(() {
                    //   current_step = step;
                    // });
                  },
                  onStepContinue: () {},
                  onStepCancel: () {
                    // setState(() {
                    //   if (current_step > 0) {
                    //     current_step = current_step - 1;
                    //   } else {
                    //     current_step = 0;
                    //   }
                    // });
                  },
                ),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ShippingDetailsPage(
                      totalAmount: widget.totalAmount,
                    ),
                    const SubmitPage()
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SubmitPage extends StatelessWidget {
  const SubmitPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // showsheet();
    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is PaymentFailed) {
          Fluttertoast.showToast(msg: state.message);
        }
        if (state is PaymentSuccess) {
          print('success');
          showSnackBar(
              context: context,
              title: 'Success',
              content: 'The Payment has successfully completed',
              contentType: ContentType.success);
          GoRouter.of(context).pop();
        }
      },
      builder: (context, state) {
        return const CartPage();
      },
    );
  }
}

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

        context.read<CheckoutBloc>().add(SubmitPaymentFormEvent(
            name: 'rayid',
            address: addressController.text,
            pin: pinController.text,
            city: cityController.text,
            state: stateController.text,
            country: countryController.text,
            currency: currencyController.text,
            amount: (amountController.text.isNotEmpty)
                ? (double.parse(amountController.text) * 100).toInt().toString()
                : '0'));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: BlocConsumer<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is SubmitPaymentFormFailed) {
              Fluttertoast.showToast(msg: state.message);
            }
            if (state is SubmitPaymentFormSuccess) {
              addressController.clear();
              pinController.clear();
              cityController.clear();
              stateController.clear();
              countryController.clear();
              currencyController.clear();
              amountController.clear();
            }
          },
          builder: (context, state) {
            print(state is CheckoutLoading);
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
