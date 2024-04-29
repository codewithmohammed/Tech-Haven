import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/custom_drop_down.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  final TextEditingController brandNameTextEditingController =
      TextEditingController();
  final TextEditingController productNameTextEditingController =
      TextEditingController();
  final TextEditingController productPrizeTextEditingController =
      TextEditingController();
  final TextEditingController productQuantityTextEditingController =
      TextEditingController();
  final TextEditingController productOverviewTextEditingController =
      TextEditingController();
  final List<String> _textFields = [''];
  bool isChecked = false;
  final TextEditingController shippingController = TextEditingController();
  int attributeCount = 2;
  int totalImageCount = 2;

  @override
  void dispose() {
    shippingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VendorAppBar(
        title: 'Register New Product',
        bottom: null,
        messageIcon: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(
            8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GlobalTitleText(
                title: 'General',
              ),
              Constants.kHeight,
              CustomTextFormField(
                labelText: 'Brand Name',
                hintText: 'Brand Name',
                textEditingController: brandNameTextEditingController,
              ),
              Constants.kHeight,
              CustomTextFormField(
                labelText: 'Product Name',
                hintText: 'Product Name',
                textEditingController: productNameTextEditingController,
              ),
              Constants.kHeight,
              CustomTextFormField(
                labelText: 'Product Prize',
                hintText: 'Product Prize',
                textEditingController: productPrizeTextEditingController,
              ),
              Constants.kHeight,
              CustomTextFormField(
                labelText: 'Product Quantity',
                hintText: 'Product Quantity',
                textEditingController: productQuantityTextEditingController,
              ),
              Constants.kHeight,
              //droopdown for product main category
              const CustomDropDown(items: [], currentItem: 'currentItem'),
              Constants.kHeight,
              //drodown for product sub category
              const CustomDropDown(items: [], currentItem: 'currentItem'),
              Constants.kHeight,
              //dropdown for product variant category
              const CustomDropDown(items: [], currentItem: 'currentItem'),
              Constants.kHeight,
              Constants.kHeight,
              const SubText(subText: 'Overview'),
              Constants.kHeight,
              TextField(
                controller: productOverviewTextEditingController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              ),
              Constants.kHeight,
              const SubText(subText: 'Specifications'),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _textFields.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            labelText: 'Name',
                            hintText: 'Name',
                            textEditingController:
                                productQuantityTextEditingController,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            labelText: 'Spec.',
                            hintText: 'Spec.',
                            textEditingController:
                                productQuantityTextEditingController,
                          ),
                        ),
                      ),
                      index < _textFields.length - 1
                          ? IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  _textFields.removeAt(index);
                                });
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _textFields.add('');
                                });
                              },
                            ),
                    ],
                  );
                },
              ),
              Constants.kHeight,
              const GlobalTitleText(
                title: 'Shipping',
              ),
              Constants.kHeight,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Charge Shipping',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(width: 10.0),
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  if (isChecked)
                    CustomTextFormField(
                      labelText: 'Shipping Charge.',
                      hintText: 'Shipping Charge.',
                      textEditingController: shippingController,
                      durationMilliseconds: 250,
                    ),
                ],
              ),
              Constants.kHeight,
              const GlobalTitleText(
                title: 'Attribute',
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: attributeCount,
                  itemBuilder: (context, index) {
                    return ListViewContainer(
                      onTapCenterWidget: () {
                        setState(() {
                          attributeCount++;
                        });
                      },
                      onPressedCrossIcon: () {
                        setState(() {
                          attributeCount--;
                        });
                      },
                      containerWidth: 80,
                      centerWidget: index == attributeCount - 1
                          ? const SvgIcon(
                              icon: CustomIcons.plusSvg,
                              radius: 20,
                            )
                          : Image.asset(
                              'assets/dev/iphone-png.png',
                            ),
                      crossIcon: index == attributeCount - 1 ? false : true,
                    );
                  },
                ),
              ),
              Constants.kHeight,
              const GlobalTitleText(
                title: 'Upload Image',
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: attributeCount - 1,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubText(
                        subText: 'color ${index + 1}',
                      ),
                      Container(
                        width: 80,
                        height: 100,
                        margin: const EdgeInsets.all(
                          5,
                        ),
                        decoration: const BoxDecoration(
                          color: AppPallete.darkgreyColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                        ),
                        child: InkWell(
                          child: Center(
                            child: Image.asset(
                              'assets/dev/iphone-png.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: totalImageCount,
                          itemBuilder: (context, index) {
                            return ListViewContainer(
                              onTapCenterWidget: () {
                                setState(() {
                                  totalImageCount++;
                                });
                              },
                              onPressedCrossIcon: () {
                                setState(() {
                                  totalImageCount--;
                                });
                              },
                              containerWidth: 150,
                              centerWidget: index == totalImageCount - 1
                                  ? const SvgIcon(
                                      icon: CustomIcons.plusSvg,
                                      radius: 20,
                                    )
                                  : Image.asset(
                                      'assets/dev/iphone-png.png',
                                    ),
                              crossIcon:
                                  index == totalImageCount - 1 ? false : true,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              Constants.kHeight,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: RoundedRectangularButton(
                      title: 'Draft',
                      outlined: true,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: RoundedRectangularButton(title: 'Publish'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListViewContainer extends StatelessWidget {
  const ListViewContainer({
    super.key,
    required this.containerWidth,
    required this.centerWidget,
    required this.onTapCenterWidget,
    this.crossIcon = true,
    required this.onPressedCrossIcon,
  });
  final bool crossIcon;
  final double containerWidth;
  final Widget centerWidget;
  final void Function()? onTapCenterWidget;
  final void Function()? onPressedCrossIcon;
  @override
  Widget build(BuildContext context) {
    // int itemCount = widget.initialItemCount;
    return Stack(
      children: [
        Container(
          width: containerWidth,
          // height: 100,
          margin: const EdgeInsets.all(
            5,
          ),
          decoration: const BoxDecoration(
            color: AppPallete.darkgreyColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          child: InkWell(
            onTap: onTapCenterWidget,
            child: Center(child: centerWidget),
          ),
        ),
        crossIcon
            ? Positioned(
                right: 0,
                top: 0,
                child: CircularButton(
                  color: Colors.red,
                  onPressed: onPressedCrossIcon,
                  circularButtonChild: const SvgIcon(
                    icon: CustomIcons.closeSvg,
                    radius: 10,
                  ),
                  diameter: 25,
                ),
              )
            : const SizedBox()
      ],
    );
  }
}

class SubText extends StatelessWidget {
  const SubText({super.key, required this.subText});

  final String subText;

  @override
  Widget build(BuildContext context) {
    return Text(
      subText,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
