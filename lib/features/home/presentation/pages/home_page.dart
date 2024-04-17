import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/features/home/presentation/widgets/advertisement_container.dart';
import 'package:tech_haven/features/home/presentation/widgets/carousel_banner_container.dart';
import 'package:tech_haven/features/home/presentation/widgets/category_item_listview.dart';
import 'package:tech_haven/features/home/presentation/widgets/deals_gridview.dart';
import 'package:tech_haven/features/home/presentation/widgets/horizontal_product_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // extendBody: true,
      // resizeToAvoidBottomInset: true,

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

class CustomSliverAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: true,
      scrolledUnderElevation: 0,
      elevation: 0,
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      //the whole height of the appBar
      expandedHeight: 150,
      //the height of the app bar when it is collapsed or scrolled
      collapsedHeight: 100,
      stretchTriggerOffset: 100,
      onStretchTrigger: () async {},
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppPallete.primaryAppColor,
          alignment: Alignment.topLeft,
          child: Image.asset(
            scale: 10,
            Constants.techHavenLogoHR,
          ),
        ),
        expandedTitleScale: 1,
        centerTitle: true,
        // the default padding is made to some values based on the row widgets
        titlePadding: const EdgeInsetsDirectional.only(
          start: 10,
          bottom: 5,
          end: 10,
        ),
        //
        title: const AppBarSearchBar(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 130);
}
