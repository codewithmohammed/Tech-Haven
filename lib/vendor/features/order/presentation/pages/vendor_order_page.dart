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
import 'package:tech_haven/core/common/widgets/order_tile.dart';
import 'package:tech_haven/vendor/features/order/presentation/bloc/vendor_order_page_bloc.dart';
import 'package:tech_haven/core/common/widgets/delivery_date_change.dart';

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
                    return OrderTile(
                      onPressedDeliverButton: () {
                        print('hi how are you');
                        context.read<VendorOrderPageBloc>().add(
                              DeliverOrderToAdminEvent(
                                order: state.listOfOrderDetails[index],
                              ),
                            );
                      },
                      isUser: false,
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
