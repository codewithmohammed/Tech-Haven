import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/rectangular_product_card.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/title_with_count_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartPageBloc>().add(GetAllProductsEvent());
    context.read<CartPageBloc>().add(GetAllCartEvent());
    //we need list of cartmodel list of wishlistmodel and list of productmodel
    var items = [
      '1',
      '2',
      '3',
      '4',
      '5',
    ];
    List<TextEditingController> controllers = [];
    void generateTextEditingController(int length) {
      for (int i = 0; i < length; i++) {
        controllers.add(TextEditingController());
      }
    }

    return Scaffold(
      appBar: const AppBarSearchBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: AppPallete.lightgreyColor,
            height: 50,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CartPageBloc, CartPageState>(
                  builder: (context, state) {
                    if (state is CartProductsListViewSuccess) {
                      print(state.listOfProducts.length);
                      return TitleWithCountBar(
                        title: 'Cart',
                        itemsCount: '${state.listOfProducts.length} Items',
                        totalPrize:
                            calculateTotalPrize(products: state.listOfProducts)
                                .toString(),
                      );
                    }
                    return const TitleWithCountBar(
                      title: 'Cart',
                      itemsCount: '0 Items',
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<CartPageBloc, CartPageState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CartProductsListViewSuccess) {
                  generateTextEditingController(state.listOfProducts.length);
                  return ListView.separated(
                    itemCount: state.listOfProducts.length,
                    itemBuilder: (context, index) {
                      final currentProduct = state.listOfProducts[index];
                      return BlocConsumer<CartPageBloc, CartPageState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        buildWhen: (previous, current) =>
                            current is UpdateProductToCartState,
                        builder: (context, state) {
                          bool stateSuccess = state is CartLoadedSuccessState;
                          bool stateLoading = state is CartUpdatedToCartLoading;
                          bool stateFailed = state is CartLoadedFailedState;
                          print(stateSuccess ? state.listOfCart[1].cartID : 0);
                          // controllers[index] = stateSuccess?
                          return RectangularProductCard(
                            // items: const [],
                            onTap: () {},
                            isFavoriteCard: false,
                            productName: currentProduct.name,
                            productPrize: currentProduct.prize.toString(),
                            vendorName: currentProduct.vendorName,
                            deliveryDate: currentProduct.brandName,
                            productCount: currentProduct.quantity,
                            productImage: currentProduct.displayImageURL,
                            textEditingController: controllers[index],
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 10,
                        color: AppPallete.lightgreyColor,
                      );
                    },
                  );
                }
                return ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return RectangularProductCard(
                      isLoading: state is CartPageLoadingState ? true : false,
                      // items: items,
                      onTap: () {},
                      isFavoriteCard: false,
                      productName:
                          ' Sony PlayStation 5 Console (Disc Version) With Controller',
                      productPrize: '2888',
                      vendorName: 'Mohammed Rayid',
                      deliveryDate: 'Tomorrow 5 March',
                      productCount: 12,
                      productImage: null,
                      textEditingController: null,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 10,
                      color: AppPallete.lightgreyColor,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  double calculateTotalPrize({required List<Product> products}) {
    double sum = 0;
    for (var product in products) {
      sum += product.prize;
    }
    return sum;
  }
}
