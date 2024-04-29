import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/custom_sliver_appbar.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/advertisement_container.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/carousel_banner_container.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/category_item_listview.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/deals_gridview.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/horizontal_product_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(),
            SliverToBoxAdapter(
              child: AdvertisementContainer(),
            ),
            SliverToBoxAdapter(
              child: CarouselBannerContainer(),
            ),
            SliverToBoxAdapter(
              child: CategoryIconListView(),
            ),
            SliverToBoxAdapter(
              child: HorizontalProductListView(),
            ),
            // sliver items 2
            SliverToBoxAdapter(
              child: DealsGridView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 80),
            )
            // sliver items 3
            // SliverToBoxAdapter(
            //   child:
            // ),
          ],
        ),
      ),
    );
  }
}

