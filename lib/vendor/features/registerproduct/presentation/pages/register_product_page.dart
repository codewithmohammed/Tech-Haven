import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/validators/validators.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/bloc/register_product_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/add_images_widget.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/drop_down_widgets.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/sub_text.dart';

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
  final TextEditingController shippingChargeController =
      TextEditingController();

  List<int?> categoryIndexes = [null, null, null];

  int? mainCategoryIndex;

  int? subCategoryIndex;

  int? variantCategoryIndex;
  GlobalKey<FormState> globalFormKey = GlobalKey();
  final Map<int, Map<String, String>> specificationTextFormFields = {};

  bool isChecked = false;

  Map<int, List<File>> productImages = {};

  ValueNotifier<bool> shippingChargeBool = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!RegisterProductBloc.isDataLoaded) {
        // If data is not loaded and not loading, fetch the data
        BlocProvider.of<RegisterProductBloc>(context)
            .add(GetAllCategoryEvent(refreshPage: false));
      }
    });
    List<Category> allCategories = [];
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
          child: Form(
            key: globalFormKey,
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
                  validator: Validator.validateEmptyField,
                ),
                Constants.kHeight,
                CustomTextFormField(
                  labelText: 'Product Name',
                  hintText: 'Product Name',
                  textEditingController: productNameTextEditingController,
                  validator: Validator.validateEmptyField,
                ),
                Constants.kHeight,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        labelText: 'Product Prize',
                        hintText: 'Product Prize',
                        textEditingController:
                            productPrizeTextEditingController,
                        validator: Validator.validateEmptyField,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}$')),
                        ],
                      ),
                    ),
                    Constants.kWidth,
                    Expanded(
                      child: CustomTextFormField(
                        labelText: 'Product Quantity',
                        hintText: 'Product Quantity',
                        textEditingController:
                            productQuantityTextEditingController,
                        validator: Validator.validateEmptyField,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                Constants.kHeight,
                BlocBuilder<RegisterProductBloc, RegisterProductState>(
                  buildWhen: (previous, current) =>
                      current is RegisterProductPageActionState,
                  builder: (context, state) {
                    if (state is RegisterProductLoading) {
                      return const Loader();
                    }
                    if (state is RegisterProductAllCategoryLoadedSuccess) {
                      allCategories = state.allCategoryModel;
                      return DropDownWidgets(
                        allCategories: allCategories,
                        categoryIndexes: categoryIndexes,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Constants.kHeight,
                const SubText(subText: 'Overview'),
                Constants.kHeight,
                TextFormField(
                  controller: productOverviewTextEditingController,
                  validator: Validator.validateEmptyField,
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
                  itemCount: specificationTextFormFields.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CustomTextFormField(
                              labelText: 'Name',
                              hintText: 'Name',
                              durationMilliseconds: 150,
                              textEditingController: null,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CustomTextFormField(
                              labelText: 'Spec.',
                              hintText: 'Spec.',
                              textEditingController: null,
                              durationMilliseconds: 150,
                            ),
                          ),
                        ),
                        index < specificationTextFormFields.length - 1
                            ? IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    specificationTextFormFields.remove(index);
                                  });
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  // final Map<String, String> newEntry =
                                  final Map<String, String> myMap = {};

                                  myMap[index.toString()] = '';

                                  setState(() {
                                    specificationTextFormFields[index] = myMap;
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
                ValueListenableBuilder(
                    valueListenable: shippingChargeBool,
                    builder: (context, shippingBool, child) {
                      // shippingBool == false
                      //     ? shippingChargeController.text = '0'
                      //     : null;
                      return Column(
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
                                value: shippingBool,
                                onChanged: (value) {
                                  shippingChargeBool.value = value!;
                                },
                              ),
                            ],
                          ),
                          if (shippingBool)
                            CustomTextFormField(
                              labelText: 'Shipping Charge.',
                              hintText: 'Shipping Charge.',
                              textEditingController: shippingChargeController,
                              validator: shippingBool
                                  ? Validator.validateEmptyField
                                  : null,
                              durationMilliseconds: 150,
                            ),
                        ],
                      );
                    }),
                Constants.kHeight,
                const GlobalTitleText(
                  title: 'Attribute',
                ),
                AddImagesWidget(
                  productImages: productImages,
                ),
                Constants.kHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 150,
                      child: RoundedRectangularButton(
                        title: 'Draft',
                        outlined: true,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RoundedRectangularButton(
                        title: 'Publish',
                        onPressed: () {
                          if (globalFormKey.currentState!.validate() &&
                              mainCategoryValue != null &&
                              subCategoryValue != null &&
                              variantCategoryValue != null &&
                              productImages.isNotEmpty) {
                              
                            context.read<RegisterProductBloc>().add(
                                  RegisterNewProductEvent(
                                    brandName:
                                        brandNameTextEditingController.text,
                                    productName:
                                        productNameTextEditingController.text,
                                    productPrize: double.parse(
                                        productPrizeTextEditingController.text),
                                    // productPrizeTextEditingController.text,
                                    productQuantity: int.parse(
                                        productQuantityTextEditingController
                                            .text),
                                    mainCategory: mainCategoryValue!,
                                    mainCategoryID:
                                        allCategories[mainCategoryIndex!].id,
                                    subCategory: subCategoryValue!,
                                    subCategoryID:
                                        allCategories[mainCategoryIndex!]
                                            .subCategories[subCategoryIndex!]
                                            .id,
                                    variantCategory: variantCategoryValue!,
                                    variantCategoryID: allCategories[
                                            mainCategoryIndex!]
                                        .subCategories[subCategoryIndex!]
                                        .subCategories[variantCategoryIndex!]
                                        .id,
                                    productOverview:
                                        productOverviewTextEditingController
                                            .text,
                                    shippingCharge:
                                        shippingChargeController.text.isEmpty
                                            ? 0
                                            : double.parse(
                                                shippingChargeController.text),
                                    productImages: productImages,
                                    isPublished: true,
                                  ),
                                );
                            print(true);
                          } else if (productImages.isEmpty) {
                            showSnackBar(
                              context: context,
                              title: 'Images',
                              content: 'Please Upload Product Images',
                              contentType: ContentType.warning,
                            );
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
