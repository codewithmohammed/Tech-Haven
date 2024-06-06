import 'package:flutter/material.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/specification_list_view.dart';

class OverviewAndSpecificationTabBar extends StatefulWidget {
  const OverviewAndSpecificationTabBar({
    super.key,
    required this.overview,
  });

  final String overview;

  @override
  State<OverviewAndSpecificationTabBar> createState() =>
      _OverviewAndSpecificationTabBarState();
}

class _OverviewAndSpecificationTabBarState
    extends State<OverviewAndSpecificationTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Specifications'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  widget.overview,
                ),
              ),
              const SpecificationListView()
            ],
          ),
        ),
      ],
    );
  }
}
