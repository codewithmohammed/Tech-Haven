import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: const Text('CANCEL'),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.red,
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: AppPallete.whiteColor,
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onPressed: () {
            GoRouter.of(context).pushNamed(AppRouteConstants.homePage);
          },
          child: const Text(
            'CONFIRM LOCATION',
            style: TextStyle(color: AppPallete.whiteColor),
          ),
        ),
      ),
    );
  }
}
