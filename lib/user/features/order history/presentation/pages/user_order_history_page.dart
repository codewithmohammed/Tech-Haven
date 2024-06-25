import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/entities/user_ordered_product.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/order%20history/presentation/bloc/user_order_history_page_bloc.dart';

class UserOrderHistoryPage extends StatelessWidget {
  const UserOrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserOrderHistoryPageBloc>().add(GetUserOrderHistoryEvent());
    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const BackButton(),
          title: const Text('Your Order History'),
          centerTitle: true,
        ),
        body: BlocBuilder<UserOrderHistoryPageBloc, UserOrderHistoryState>(
          builder: (context, state) {
            if (state is UserOrderHistoryInitial) {
              return const Center(child: Text('Welcome!'));
            } else if (state is UserOrderHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserOrderHistoryLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductDetailsWidget(product: product);
                },
              );
            } else if (state is UserOrderHistoryError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Container();
            }
          },
        ));
  }
}

class ProductDetailsWidget extends StatelessWidget {
  final UserOrderedProduct product;

  const ProductDetailsWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.displayImageURL),
            const SizedBox(height: 10.0),
            Text('Product Name: ${product.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Quanity Bought: ${product.quantity}'),
            Text('Brand: ${product.brandName}'),
            Text('Category: ${product.mainCategory}'),
            Text('Sub-Category: ${product.subCategory}'),
            Text('Price: AED \$${product.prize.toStringAsFixed(2)}'),
            Text('Old Price: \$${product.oldPrize.toStringAsFixed(2)}'),
            Text(
                'Shipping Charge: \$${product.shippingCharge.toStringAsFixed(2)}'),
            Text('Vendor: ${product.vendorName}'),
            Text('Overview: ${product.overview}'),
            // Text('Order ID: ${product.orderID}'),
            // Text('Product ID: ${product.productID}'),
            Text('Ordered Date: ${formatDateTime(product.dateTime)}'),
            const SizedBox(height: 10.0),
            // const Text('Specifications:',
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...product.specifications.entries.map((entry) {
              return Text('${entry.key}: ${entry.value}');
            }),
          ],
        ),
      ),
    );
  }
}
