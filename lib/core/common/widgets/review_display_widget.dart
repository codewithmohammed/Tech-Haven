import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/star_widget.dart';
import 'package:tech_haven/user/features/reviews/presentation/bloc/review_page_bloc.dart';

import 'helpful_button_widget.dart';

class ReveiwDisplayWidget extends StatelessWidget {
  const ReveiwDisplayWidget(
      {super.key,
      required this.reviewModel,
      required this.userID,
      this.onPressed});

  final Review reviewModel;
  final String userID;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      // decoration: const BoxDecoration(color: Colors.amber),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //container for the picture
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                clipBehavior: Clip.antiAlias,
                width: 40,
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                child: reviewModel.userProfile != null
                    ? Image.network(reviewModel.userProfile!)
                    : null,
              ),
              GlobalTitleText(
                title: reviewModel.userName,
                fontSize: 15,
              ),
              //container for the title and the subtitle
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: StarsWidget(
              radius: 15,
              value: reviewModel.userRating,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              reviewModel.userReview,
              style: const TextStyle(
                fontSize: 13,
                // color: AppPallete.blackColor,
              ),
            ),
          ),
          SizedBox(
              height: 30,
              child: HelpfulButtonWidget(
                initialCount: reviewModel.listOfHelpFulUsers.length,
                onPressed: (bool isLiked) {
                  print(isLiked);
                  context.read<ReviewPageBloc>().add(AddUserToHelpfulEvent(
                      userID: userID,
                      isLiked: isLiked,
                      productID: reviewModel.productID,
                      reviewID: reviewModel.reviewID));
                },
                isInitiallyLiked:
                    reviewModel.listOfHelpFulUsers.contains(userID),
              )),
          const Divider()
        ],
      ),
    );
  }
}
