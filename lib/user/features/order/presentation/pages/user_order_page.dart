import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/user/features/order/presentation/bloc/user_order_page_bloc.dart';
import 'package:tech_haven/core/common/widgets/order_tile.dart';

class UserOrderPage extends StatelessWidget {
  const UserOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    context.read<UserOrderPageBloc>().add(GetAllOrdersForUserEvent());
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
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: InkWell(
                onTap: () {
                  GoRouter.of(context)
                      .pushNamed(AppRouteConstants.userOrderHistoryPage);
                },
                child: SvgIcon(icon: CustomIcons.clockSvg, radius: 25)),
          )
        ],
      ),
      body: BlocConsumer<UserOrderPageBloc, UserOrderPageState>(
        listener: (context, state) {
          if (state is GetAllOrderListFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is UpdateOrderDeliveryFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is DeliverOrderToAdminSuccess) {
            print('object');
            context.read<UserOrderPageBloc>().add(GetAllOrdersForUserEvent());
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
                      isUser: true,
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            AppRouteConstants.userOrderDetailsPage,
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
