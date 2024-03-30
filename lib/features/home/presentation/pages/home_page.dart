
import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/features/home/presentation/widgets/advertisement_container.dart';
import 'package:tech_haven/features/home/presentation/widgets/carousel_banner.dart';
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
    return Scaffold(
      // extendBody: true,
      // resizeToAvoidBottomInset: true,

      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              forceElevated: true,
              scrolledUnderElevation: 0,
              elevation: 0,
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              //the whole height of the appBar
              expandedHeight: 130,
              //the height of the app bar when it is collapsed or scrolled
              collapsedHeight: 100,
              stretchTriggerOffset: 100,
              onStretchTrigger: () async {},
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: AppPallete.primaryAppColor,
                  child: const Text(
                    'LOGO',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                expandedTitleScale: 1,
                centerTitle: true,
                //the default padding is made to some values based on the row widgets
                titlePadding: const EdgeInsetsDirectional.only(
                  start: 15,
                  bottom: 5,
                  end: 15,
                ),
                //
                title: const AppBarSearchBar(),
              ),
            ),
            const SliverToBoxAdapter(
              child: AdvertisementContainer(),
            ),
            const SliverToBoxAdapter(
              child: CarouselBannerContainer(),
            ),
            const SliverToBoxAdapter(
              child: CategoryIconListView(),
            ),
            const SliverToBoxAdapter(
              child: HorizontalProductListView(),
            ),
            // sliver items 2
            const SliverToBoxAdapter(
              child: DealsGridView(),
            ),
            const SliverToBoxAdapter(
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
