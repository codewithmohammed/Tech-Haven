import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/small_long_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/entities/order.dart' as model;
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/vendor/features/order/presentation/bloc/vendor_order_page_bloc.dart';
import 'package:tech_haven/vendor/features/order/presentation/widgets/delivery_date_change.dart';

class VendorOrderPage extends StatelessWidget {
  const VendorOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    context.read<VendorOrderPageBloc>().add(GetAllOrdersForVendorEvent());
    // });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        title: const Text('Your Order'),
        centerTitle: true,
      ),
      body: BlocConsumer<VendorOrderPageBloc, VendorOrderPageState>(
        listener: (context, state) {
          if (state is GetAllOrderListFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is UpdateOrderDeliveryFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is DeliverOrderToAdminSuccess) {
            print('object');
            context
                .read<VendorOrderPageBloc>()
                .add(GetAllOrdersForVendorEvent());
          }
          if (state is DeliverOrderToAdminFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          return state is GetAllOrderListSuccess
              ? ListView.separated(
                  itemCount: state.listOfOrderDetails.length,
                  itemBuilder: (context, index) {
                    print(state.listOfOrderDetails.length);
                    return VendorOrderTile(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            AppRouteConstants.vendorOrderDetailsPage,
                            extra: state.listOfOrderDetails[index]);
                      },
                      order: state.listOfOrderDetails[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: Container(),
                );
        },
      ),
    );
  }
}

class VendorOrderTile extends StatelessWidget {
  const VendorOrderTile({
    super.key,
    required this.order,
    required this.onTap,
    // required this.listOfProductsModel,
  });
  // final List<Product> listOfProductsModel;
  final model.Order order;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          10,
        ),
        decoration: const BoxDecoration(
          color: AppPallete.darkgreyColor,
        ),
        //the whole container column
        child: Column(
          children: [
            //row for the first bar
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //clock icon
                Row(
                  children: [
                    const SvgIcon(
                      icon: CustomIcons.clockSvg,
                      radius: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //column for the text
                    Column(
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          formatDateTime(order.orderDate),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //text for the amount
                const Text('Not Delivered'),
                Text(
                  'Order Amount ${changeAmountDecimal(amount: order.totalAmount)}',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            //divider
            const Divider(),
            //text for the order details
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GlobalTitleText(
                    title: 'Order Details',
                    fontSize: 16,
                  ),
                ),
                //row for the pic and details
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //row for the name and quantity of the product ordered
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('No of Items : ${order.products.length}'),
                              ],
                            ),
                            //text customer details
                            const GlobalTitleText(
                              title: 'Customer Details',
                              fontSize: 14,
                            ),
                            Text('Name : ${order.name}'),
                            Text('Location : ${order.address}'),
                            Text(
                              'Customer ID :${order.userID}',
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //column for the two buttons
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //accept button
                        Text(
                          'Your Share : ${calculateTotalPrizeForVendorOrdrer(productOrderModel: order.products)}',
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        SmallLongButton(
                          onPressed: () {
                            //remove the products from the ordered page and add this into the delivered collection and

                            // print('hi how are you');
                            context.read<VendorOrderPageBloc>().add(
                                  DeliverOrderToAdminEvent(
                                    order: order,
                                  ),
                                );
                          },
                          text: 'Deliver',
                          bgColor: Colors.green,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //decline button
                        // const Text(
                        //   'Date of Delivery',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //   ),
                        // ),
                        DeliveryDateChange(order: order),
                        // SmallLongButton(
                        //   onPressed: () {},
                        //   text: 'Choose Date',
                        //   bgColor: Colors.red,
                        // )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
