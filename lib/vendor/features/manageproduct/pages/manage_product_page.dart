import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/notification/presentation/widgets/tab_text.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';
import 'package:tech_haven/vendor/features/manageproduct/pages/subpages/published_page.dart';
import 'package:tech_haven/vendor/features/manageproduct/pages/subpages/unplubished_page.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          // extendBody: false,
          // resizeToAvoidBottomInset: true,
          appBar: VendorAppBar(
            title: 'Manage Products',
            bottom: TabBar(
              indicatorWeight: 1,
              indicatorPadding: EdgeInsets.only(top: 45),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: AppPallete.primaryAppButtonColor,
              ),
              dividerHeight: 0,
              tabs: [
                Tab(
                  child: TabText(
                    title: 'Published',
                  ),
                ),
                Tab(
                  child: TabText(
                    title: 'UnPublished',
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PublishedPage(),
              UnPublishedPage(),
            ],
          ),
        ),
      ),
    );
  }
}
