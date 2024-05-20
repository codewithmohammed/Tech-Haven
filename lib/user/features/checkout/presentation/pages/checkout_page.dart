import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/user/features/map/presentation/pages/google_map_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PageController pageController = PageController();
  int current_step = 0;
  List<Step> steps = [
    // const Step(
    //   title: Text('Shipping'),
    //   content: Text('Hello!'),
    //   isActive: true,
    // ),
    const Step(
      title: Text('Payment'),
      content: Text('World!'),
      isActive: false,
    ),
    const Step(
      title: Text('Submit'),
      content: Text('Hello World!'),
      state: StepState.complete,
      isActive: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        // Title
        title: const Text("Checkout"),
      ),
      // Body
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: 72,
            child: Stepper(
              elevation: 0,
              currentStep: current_step,
              steps: steps,
              type: StepperType.horizontal,
              stepIconBuilder: (stepIndex, stepState) {
                return null;
              },
              controlsBuilder: (context, details) {
                return Container();
              },
              onStepTapped: (step) {
                setState(() {
                  current_step = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (current_step < steps.length - 1) {
                    current_step = current_step + 1;
                  } else {
                    current_step = 0;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (current_step > 0) {
                    current_step = current_step - 1;
                  } else {
                    current_step = 0;
                  }
                });
              },
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // const GoogleMapPage(
                //   isForCheckout: true,
                // ),
                Container(),
                Container(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          height: 50,
          // decoration: const BoxDecoration(color: Colors.amber),
          // clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(15),
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RoundedRectangularButton(
                title: 'Prev',
                onPressed: () {
                  setState(() {
                    pageController.previousPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.bounceInOut);
                    if (current_step < steps.length - 1) {
                      current_step = current_step - 1;
                    } else {
                      current_step = 0;
                    }
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              RoundedRectangularButton(
                title: 'Next',
                onPressed: () {
                  setState(() {
                    pageController.nextPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.bounceInOut);
                    if (current_step < steps.length - 1) {
                      current_step = current_step + 1;
                    } else {
                      current_step = 0;
                    }
                  });
                },
              ),
            ],
          )),

      //  Container(
      //   child: Column(
      //     children: [
      //       Container(
      //         color: Colors.red,
      //         height: 1000,
      //         child: Stepper(
      //           currentStep: current_step,
      //           steps: steps,
      //           type: StepperType.horizontal,
      //           stepIconBuilder: (stepIndex, stepState) {
      //             return null;
      //           },
      //           controlsBuilder: (context, details) {
      //             return
      //           },
      // onStepTapped: (step) {
      //   setState(() {
      //     current_step = step;
      //   });
      // },
      // onStepContinue: () {
      //   setState(() {
      //     if (current_step < steps.length - 1) {
      //       current_step = current_step + 1;
      //     } else {
      //       current_step = 0;
      //     }
      //   });
      // },
      // onStepCancel: () {
      //   setState(() {
      //     if (current_step > 0) {
      //       current_step = current_step - 1;
      //     } else {
      //       current_step = 0;
      //     }
      //   });
      // },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
    );
  }
}
