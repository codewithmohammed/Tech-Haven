import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class UnPublishedPage extends StatelessWidget {
  const UnPublishedPage({super.key, required this.listOfPublishedProduct});
  final List<Product> listOfPublishedProduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listOfPublishedProduct.length,
        itemBuilder: (context, index) {
          return Slidable(
            // enabled:,
            endActionPane: ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                padding: const EdgeInsets.all(
                  2,
                ),
              ),
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.unpublished,
                label: 'Publish',
                padding: const EdgeInsets.all(
                  2,
                ),
              ),
            ]),
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: AppPallete.darkgreyColor,
                ),
                child: Image.network(
                    listOfPublishedProduct[index].displayImageURL),
              ),
              title: Text(listOfPublishedProduct[index].name),
              subtitle: Text(listOfPublishedProduct[index].prize.toString()),
              // trailing:
              onTap: () {
                // GoRouter.of(context).pushNamed(
                //   AppRouteConstants.messagePage,
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
