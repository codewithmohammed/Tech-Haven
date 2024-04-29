import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: const AppBarSearchBar(
          backButton: true,
          favouriteIconNeeded: false,
          deliveryPlaceNeeded: false,
          enabled: true,
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text('Suggestions'),
          );
        },
      )),
    );
  }
}
