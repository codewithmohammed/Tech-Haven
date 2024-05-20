import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/custom_sliver_appbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<HomePageBloc>().add(GetAllProductsEvent());
      context.read<HomePageBloc>().add(GetAllBannerHomeEvent());
      context.read<HomePageBloc>().add(GetAllSubCategoriesHomeEvent());
    });
    // print('hskdfsjdhfjs');
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
              child: HorizontalProductListView(
                  // listOfProducts: state.listOfProducts,
                  ),
            ),
            SliverToBoxAdapter(
              child: DealsGridView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 80),
            )
          ],
        ),
      ),
    );
  }
}
