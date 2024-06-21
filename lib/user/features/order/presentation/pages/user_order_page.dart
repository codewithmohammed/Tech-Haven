import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/order/presentation/bloc/user_order_bloc.dart';
import 'package:tech_haven/user/features/order/presentation/widgets/order_tile.dart';

class UserOrderPage extends StatelessWidget {
  const UserOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserOrderBloc>().add(GetAllOrderDetailsEvent());
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Your Orders'),
        actions: const [
          SvgIcon(
            icon: CustomIcons.clockSvg,
            radius: 20,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: BlocConsumer<UserOrderBloc, UserOrderState>(
        listener: (context, state) {
          if (state is GetAllOrderDetailsFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          print(state);
          if (state is GetAllOrderDetailsSuccess) {
            return Accordion(
              children: [
                ...List.generate(
                  state.listOfOrderModels.length,
                  (newIndex) => AccordionSection(
                      header: Row(
                        children: [
                          Expanded(
                            child: OrderTile(
                              keys: formatDateTime(
                                  state.listOfOrderModels[newIndex].orderDate),
                              value: formatDateTime(state
                                  .listOfOrderModels[newIndex].deliveryDate),
                            ),
                          ),
                        ],
                      ),
                      content: const Row(
                        children: [Column()],
                      )),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
