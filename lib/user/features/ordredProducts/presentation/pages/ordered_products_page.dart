import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/user/features/ordredProducts/presentation/bloc/ordered_products_page_bloc.dart';
import 'package:tech_haven/user/features/ordredProducts/presentation/widgets/ordered_product_card.dart';

class OrderedProductsPage extends StatelessWidget {
  final String orderID;

  const OrderedProductsPage({super.key, required this.orderID});

  @override
  Widget build(BuildContext context) {
    // print(orderID);
    context
        .read<OrderedProductsPageBloc>()
        .add(FetchOrderProductsEvent(orderId: orderID));

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: BlocBuilder<OrderedProductsPageBloc, OrderedProductsPageState>(
        builder: (context, state) {
          if (state is OrderedProductsPageLoading) {
            return const Loader();
          } else if (state is OrderedProductsPageError) {
            return Center(child: Text(state.message));
          } else if (state is OrderedProductsPageLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return OrderedProductCard(product: products[index]);
              },
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
