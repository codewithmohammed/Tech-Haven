import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/review_display_widget.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/user/features/details/data/models/review_route_model.dart';
// import '../bloc/product_search_bloc.dart';
// import '../bloc/product_search_event.dart';
// import '../bloc/product_search_state.dart';
// import '../../core/common/widgets/appbar_searchbar.dart';
// import '../../domain/entities/product.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key, required this.reviewRouteModel});

  final ReviewRouteModel reviewRouteModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const AppBarSearchBar(
        favouriteIconNeeded: false,
        backButton: true,
      ),
      body: SafeArea(
          child: ListView.separated(
        itemCount:reviewRouteModel. listOfReview.length,
        itemBuilder: (context, index) {
          return ReveiwDisplayWidget(reviewModel:reviewRouteModel. listOfReview[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      )),
    );
  }
}
