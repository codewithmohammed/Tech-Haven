import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/bloc/manage_product_bloc.dart';

class PublishedPage extends StatelessWidget {
  const PublishedPage({super.key, required this.listOfPublishedProduct});

  final List<Product> listOfPublishedProduct;

  @override
  Widget build(BuildContext context) {
    // Future<bool> deleteProduct(
    //     {required Product product,
    //     required Map<int, List<model.Image>> listOfImagesLinks}) async {
    //   final boolean = await showConfirmationDialog(
    //       context,
    //       'Delete This Product',
    //       'Are You Sure You Want To Delete this Product Forever', () {
    //     context.read<RegisterProductBloc>().add(
    //           DeleteTheProductEvent(
    //             product: product,
    //             mapOfListOfImages: listOfImagesLinks,
    //           ),
    //         );
    //   });
    //   return boolean!;
    // }

    return Scaffold(
      extendBody: true,
      body: BlocBuilder<ManageProductBloc, ManageProductState>(
        builder: (context, state) {
          if (state is ManageProductLoadingState) {
            return const Loader();
          }
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [],
            body: listOfPublishedProduct.isNotEmpty
                ? ListView.builder(
                    itemCount: listOfPublishedProduct.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        // enabled:,
                        startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  context.read<ManageProductBloc>().add(
                                      UpdateTheProductPublishEvent(
                                          product:
                                              listOfPublishedProduct[index],
                                          publish: false));
                                },
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.unpublished,
                                label: 'UnPublish',
                                padding: const EdgeInsets.all(
                                  2,
                                ),
                              ),
                              // SlidableAction(
                              //   onPressed: (context) {
                              //     // deleteProduct(product: listOfPublishedProduct[index], listOfImagesLinks: listOfImagesLinks)
                              //   },
                              //   backgroundColor: Colors.red,
                              //   foregroundColor: Colors.white,
                              //   icon: Icons.delete,
                              //   label: 'Delete',
                              //   padding: const EdgeInsets.all(
                              //     2,
                              //   ),
                              // ),
                            ]),
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: AppPallete.darkgreyColor,
                            ),
                            child: Image.network(
                              listOfPublishedProduct[index].displayImageURL,
                            ),
                          ),
                          title: Text(listOfPublishedProduct[index].name),
                          subtitle:
                              Text('AED${listOfPublishedProduct[index].prize}'),
                          // trailing:
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                                AppRouteConstants.registerProductPage,
                                extra: listOfPublishedProduct[index]);
                          },
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("You Haven't Published anything yet"),
                  ),
          );
        },
      ),
    );
  }
}
