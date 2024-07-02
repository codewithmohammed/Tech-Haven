import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/custom_sliver_appbar.dart';
import 'package:tech_haven/user/features/favorite/presentation/bloc/favorite_page_bloc.dart';
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
      context.read<HomePageBloc>().add(GetAllBannerHomeEvent());
      context.read<HomePageBloc>().add(GetAllProductsEvent());
      context.read<HomePageBloc>().add(GetAllSubCategoriesHomeEvent());
      context.read<HomePageBloc>().add(GetNowTrendingProductEvent());
    });
    // print('hskdfsjdhfjs');
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(),
            SliverToBoxAdapter(
              child: BlocBuilder<HomePageBloc, HomePageState>(
                buildWhen: (previous, current) =>
                    current is TrendingProductState,
                builder: (context, state) {
                  if (state is TrendingProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TrendingProductLoaded) {
                    // print(state.product.productName);
                    return AdvertisementContainer(
                        trendingProduct: state.product);
                  } else if (state is TrendingProductError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const AdvertisementContainer(trendingProduct: null);
                  }
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: CarouselBannerContainer(),
            ),
            const SliverToBoxAdapter(
              child: CategoryIconListView(),
            ),
            const SliverToBoxAdapter(
              child: HorizontalProductListView(
                  // listOfProducts: state.listOfProducts,
                  ),
            ),
            const SliverToBoxAdapter(
              child: DealsGridView(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 80),
            )
          ],
        ),
      ),
    );
  }
}
